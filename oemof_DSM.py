# -*- coding: utf-8 -*-
"""
Created on Di Sept 17 12:04:48 2019

@author: Okan Akca, Julian Endres, Guido Plessmann, Johannes Kochems

Module for creating a Demand Side Management component.
Based on the formulation given in a paper by Zerrahn, Alexander and Schill,
Wolf-Peter (2015): On the representation of demand-side management in power
system models, in: Energy (84), pp. 840-845, 10.1016/j.energy.2015.03.037,
accessed 17.09.2019, pp. 842-843.

The model formulation is used within the (GAMS-based) energy system model
DIETER at DIW, Berlin, as well as in the (python (Pyomo)-based) energy system
model urbs at TU Munich.
"""

from oemof import solph

from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Set, NonNegativeReals,Reals, Var, Constraint, BuildAction)
from oemof.solph import sequence as solph_sequence


########################################################################
# ----------------------- DSM Component --------------------------------

class SinkDsm(solph.Sink):
    r""" A special sink component which modifies the input demand series.

    Parameters
    ----------
    demand: int or array
        demand defines the original demand
    c_up: int or array
        c_up is the DSM capacity that may be increased at maximum
    c_do: int or array
        c_do is the DSM capacity that may be reduced at maximum
    *method: 'potential' or 'delay'

        potential : simple model in which the load shift must be compensated for in a predefined fixed interval
                    (24h by default). Foundation of this optimisation should be a potential analysis of the
                    DSM capacity during each interval. With this, the boundaries for the DSM variable are set.

        delay : sophisticated model based on the formulation by Zerrahn & Schill (DIW).
                The load-shift of the component must be compensated for in a predefined delay-time (3h by default).
                DSM capacity can either be a fixed value or an hourly time series.

    **shift_interval: int (only in method='potential')
        interval in between which total DSM  must be fully compensated for
        default=24h
    **

    Note: This component is still under development.

    Notes
    -----
    The following sets, variables, constraints and objective parts are created
     * :py:class:`~oemof.solph.blocks.Sink` (i.e. no further constraints)

    """

    def __init__(self, demand, c_up, c_do, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.c_up = solph_sequence(c_up)
        self.c_do = solph_sequence(c_do)
        self.demand = solph_sequence(demand)
        self.method = kwargs.get('method', 'delay')
        self.shift_interval = kwargs.get('shift_interval', 24)
        self.delay_time = kwargs.get('delay_time', 3)

    def constraint_group(self):
        possible_methods = ['delay', 'potential']
        if self.method not in possible_methods:
            raise ValueError('The method selection must be one of the following set: '
                             '"{}"'.format('","'.join(possible_methods)))

        if self.method == possible_methods[0]:
            return SinkDsmPotentialBlock
        else:
            return SinkDsmDelayBlock


#######################################################################################
#                      Potential Method

class SinkDsmPotentialBlock(SimpleBlock):
    r"""Block for the linear relation of a DSM component and an electrical bus

    Note: This component is under development. Use it with care.

     **The following constraints are created for method='potential':**

    math::

    (1) \quad flow = demand(t) + DSM_{t}^{updown} \quad \forall t \\
    &
    (2) \quad

    """
    CONSTRAINT_GROUP = True

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def _create(self, group=None):
        if group is None:
            return None

        m = self.parent_block()

        # for all DSM components get inflow from bus_elec
        for n in group:
            n.inflow = list(n.inputs)[0]

        #  ************* SETS *********************************

        # Set of DSM Components
        self.DSM = Set(initialize=[n for n in group])

        #  ************* VARIABLES *****************************

        def dsm_capacity_bound_rule(block):
            """Rule definition for bounds(capacity) of DSM - Variable g in timestep t"""
            for t in m.TIMESTEPS:
                for g in group:
                    bounds = (-g.c_do[t], g.c_up[t])
                    return bounds

        # Variable load shift down (MWh)
        self.DSMupdown = Var(self.DSM, m.TIMESTEPS, initialize=0, within=Reals, bounds=dsm_capacity_bound_rule)

        #  ************* CONSTRAINTS *****************************

        # Demand Production Relation
        def _input_output_relation_rule(block):
            """
            Relation between input data and pyomo variables. The actual demand after DSM.
            Generator Production == Demand_el +- DSM
            """
            for t in m.TIMESTEPS:
                for g in group:
                    # Generator loads directly from bus
                    lhs = m.flow[g.inflow, g, t]

                    # Demand +- DSM
                    rhs = g.demand[t] + self.DSMupdown[g, t]

                    # add constraint
                    block.input_output_relation.add((g, t), (lhs == rhs))

        self.input_output_relation = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.input_output_relation_build = BuildAction(rule=_input_output_relation_rule)

        # Equation 7
        def dsm_sum_constraint_rule(block):
            """
            Relation to compensate the total amount of positive and negative DSM in between the shift_interval.
            2 Cases: A full interval is optimised or an incomplete one.
            """
            for t in m.TIMESTEPS:
                for g in group:

                    shft_intvl = g.shift_interval

                    # full interval
                    if (t // shft_intvl) < (m.TIMESTEPS._bounds[1] // shft_intvl):
                        # DSM up/down
                        lhs = sum(self.DSMupdown[g, tt] for tt in range((t // shft_intvl) * shft_intvl,
                                                                        (t // shft_intvl + 1) * shft_intvl, 1))
                        # value
                        rhs = 0
                        # add constraint
                        block.dsm_sum_constraint.add((g, t), (lhs == rhs))

                    # incomplete interval
                    else:
                        # DSM up/down
                        lhs = sum(self.DSMupdown[g, tt] for tt in range((t // shft_intvl) * shft_intvl,
                                                                        m.TIMESTEPS._bounds[1] + 1, 1))
                        # value
                        rhs = 0
                        # add constraint
                        block.dsm_sum_constraint.add((g, t), (lhs == rhs))

        self.dsm_sum_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsm_sum_constraint_build = BuildAction(rule=dsm_sum_constraint_rule)


#######################################################################################
#                      Delay Method

class SinkDsmDelayBlock(SimpleBlock):
    r"""Block for the linear relation of a DSM component and an electrical bus

    Note: This component is under development. Use it with care.

    **The following constraints are created for method=delay:**

    .. math::

    t =  timevariable 1
    tt = timevariabel 2
    L = delay time


    (1) \quad flow_{t} = demand_{t} + DSM_{t}^{up} - \sum_{tt=t-L}^{t+L} DSM_{t,tt}^{do}  \quad \forall t \\
    &
    (2) \quad DSM_{t}^{up} = \sum_{tt=t-L}^{t+L} DSM_{t,tt}^{do} \quad \forall t \\
    &
    (3) \quad DSM_{t}^{up} \leq  C_{t}^{up} \quad \forall t \\
    &
    (4) \quad /sum_{t=tt-L}^{tt+L} DSM_{t,tt}^{do} \leq  C_{t}^{do] \quad \forall tt \\
    &
    (5) \quad DSM_{tt}^{up}  + \sum_{t=tt-L}^{tt+L} DSM_{t,tt}^{do} \leq max \{ C_{t}^{up},C_{t}^{do} \} \quad \forall tt \\
    &

    **Table: Symbols and attribute names of variables and parameters**

    .. csv-table:: Variables (V) and Parameters (P)
        :header: "symbol", "attribute", "type", "explanation"
        :widths: 1, 1, 1, 1

        ":math:`DSM_{t}^{up}` ", ":py:obj:`DSMdo[g,t,tt]` ", "V", "DSM up shift (additional load)"
        ":math:`DSM_{t,tt}^{do}` ", ":py:obj:`DSMup[g,t]`", "V", "DSM down shift (less load)"
        ":math:`flow_{t}` ", ":py:obj:`flow[g,t]`", "V", "production at electrical bus"
        ":math:`L` ", ":py:obj:`delay_time`", "P", "delay time for load shift"
        ":math:`demand_{t} ` ", ":py:obj:`demand[t]`", "P", "electrical demand"
        ":math:`C_{t}^{do} ` ", ":py:obj:`c_do[tt]`", "P", "DSM down shift capacity"
        ":math:`C_{t}^{up} ` ", ":py:obj:`c_up[tt]`", "P", "DSM up shift capacity"


    """
    CONSTRAINT_GROUP = True

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def _create(self, group=None):
        if group is None:
            return None

        m = self.parent_block()

        # for all DSM components get inflow from bus_elec
        for n in group:
            n.inflow = list(n.inputs)[0]

        #  ************* SETS *********************************

        # Set of DSM Components
        self.DSM = Set(initialize=[g for g in group])

        #  ************* VARIABLES *****************************

        # Variable load shift down (MWh)
        self.DSMdo = Var(self.DSM, m.TIMESTEPS, m.TIMESTEPS, initialize=0, within=NonNegativeReals)

        # Variable load shift up(MWh)
        self.DSMup = Var(self.DSM, m.TIMESTEPS, initialize=0, within=NonNegativeReals)

        #  ************* CONSTRAINTS *****************************

        # Demand Production Relation
        def _input_output_relation_rule(block):
            """
            Relation between input data and pyomo variables. The actual demand after DSM.
            Generator Production == Demand +- DSM
            """
            for t in m.TIMESTEPS:
                for g in group:

                    # first time steps: 0 + delay time
                    if t <= g.delay_time:

                        # Generator loads from bus
                        lhs = m.flow[g.inflow, g, t]
                        # Demand +- DSM
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, tt, t] for tt in range(t + g.delay_time + 1))
                        # add constraint
                        block.input_output_relation.add((g, t), (lhs == rhs))

                    # main use case
                    elif g.delay_time < t <= m.TIMESTEPS._bounds[1] - g.delay_time:

                        # Generator loads from bus
                        lhs = m.flow[g.inflow, g, t]
                        # Demand +- DSM
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, tt, t] for tt in range(t - g.delay_time, t + g.delay_time + 1))
                        # add constraint
                        block.input_output_relation.add((g, t), (lhs == rhs))

                    # last time steps: end - delay time
                    else:
                        # Generator loads from bus
                        lhs = m.flow[g.inflow, g, t]
                        # Demand +- DSM
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, tt, t] for tt in range(t - g.delay_time, m.TIMESTEPS._bounds[1] + 1))
                        # add constraint
                        block.input_output_relation.add((g, t), (lhs == rhs))

        self.input_output_relation = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.input_output_relation_build = BuildAction(rule=_input_output_relation_rule)

        # Equation 7
        def dsmupdo_constraint_rule(block):
            '''
            Equation 7 by Zerrahn, Schill:
            Every upward load shift has to be compensated by downward load shifts in a defined time frame.
            Slightly modified equations for the first and last time steps due to variable initialization.
            '''

            for t in m.TIMESTEPS:
                for g in group:

                    # first time steps: 0 + delay time
                    if t <= g.delay_time:

                        # DSM up
                        lhs = self.DSMup[g, t]
                        # DSM down
                        rhs = sum(self.DSMdo[g, t, tt] for tt in range(t + g.delay_time + 1))
                        # add constraint
                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

                    # main use case
                    elif g.delay_time < t <= m.TIMESTEPS._bounds[1] - g.delay_time:

                        # DSM up
                        lhs = self.DSMup[g, t]
                        # DSM down
                        rhs = sum(self.DSMdo[g, t, tt] for tt in range(t - g.delay_time, t + g.delay_time + 1))
                        # add constraint
                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

                    # last time steps: end - delay time
                    else:

                        # DSM up
                        lhs = self.DSMup[g, t]
                        # DSM down
                        rhs = sum(self.DSMdo[g, t, tt] for tt in range(t - g.delay_time, m.TIMESTEPS._bounds[1] + 1))
                        # add constraint
                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

        self.dsmupdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmupdo_constraint_build = BuildAction(rule=dsmupdo_constraint_rule)

        # Equation 8
        def dsmup_constraint_rule(block):
            '''
            Equation 8 by Zerrahn, Schill:
            Realised upward load shift at time t has to be smaller than upward DSM capacity at time t.
            '''

            for t in m.TIMESTEPS:
                for g in group:
                    # DSM up
                    lhs = self.DSMup[g, t]
                    # Capacity DSMup
                    rhs = g.c_up[t]
                    # add constraint
                    block.dsmup_constraint.add((g, t), (lhs <= rhs))

        self.dsmup_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmup_constraint_build = BuildAction(rule=dsmup_constraint_rule)

        # Equation 9
        def dsmdo_constraint_rule(block):
            '''
            Equation 9 by Zerrahn, Schill:
            Realised downward load shift at time t has to be smaller than downward DSM capacity at time t.
            '''

            for tt in m.TIMESTEPS:
                for g in group:

                    # first times steps: 0 + delay time
                    if tt <= g.delay_time:

                        # DSM down
                        lhs = sum(self.DSMdo[g, t, tt] for t in range(tt + g.delay_time + 1))
                        # Capacity DSM down
                        rhs = g.c_do[tt]
                        # add constraint
                        block.dsmdo_constraint.add((g, tt), (lhs <= rhs))

                    # main use case
                    elif g.delay_time < tt <= m.TIMESTEPS._bounds[1] - g.delay_time:

                        # DSM down
                        lhs = sum(self.DSMdo[g, t, tt] for t in range(tt - g.delay_time, tt + g.delay_time + 1))
                        # Capacity DSM down
                        rhs = g.c_do[tt]
                        # add constraint
                        block.dsmdo_constraint.add((g, tt), (lhs <= rhs))

                    # last time steps: end - delay time
                    else:

                        # DSM down
                        lhs = sum(self.DSMdo[g, t, tt] for t in range(tt - g.delay_time, m.TIMESTEPS._bounds[1] + 1))
                        # Capacity DSM down
                        rhs = g.c_do[tt]
                        # add constraint
                        block.dsmdo_constraint.add((g, tt), (lhs <= rhs))

        self.dsmdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmdo_constraint_build = BuildAction(rule=dsmdo_constraint_rule)

        # Equation 10
        def C2_constraint_rule(block):
            '''
            Equation 10 by Zerrahn, Schill:
            The realised DSM up or down at time T has to be smaller than the maximum downward or upward capacity
            at time T. Therefore in total each DSM unit can only be shifted up OR down.
            '''

            for tt in m.TIMESTEPS:
                for g in group:

                    # first times steps: 0 + delay time
                    if tt <= g.delay_time:

                        # DSM up/down
                        lhs = self.DSMup[g, tt] + sum(self.DSMdo[g, t, tt] for t in range(tt + g.delay_time + 1))
                        # max capacity at tt
                        rhs = max(g.c_up[tt], g.c_do[tt])
                        # add constraint
                        block.C2_constraint.add((g, tt), (lhs <= rhs))

                    elif g.delay_time < tt <= m.TIMESTEPS._bounds[1] - g.delay_time:

                        # DSM up/down
                        lhs = self.DSMup[g, tt] + sum(
                            self.DSMdo[g, t, tt] for t in range(tt - g.delay_time, tt + g.delay_time + 1))
                        # max capacity at tt
                        rhs = max(g.c_up[tt], g.c_do[tt])
                        # add constraint
                        block.C2_constraint.add((g, tt), (lhs <= rhs))

                    else:

                        # DSM up/down
                        lhs = self.DSMup[g, tt] + sum(
                            self.DSMdo[g, t, tt] for t in range(tt - g.delay_time, m.TIMESTEPS._bounds[1] + 1))
                        # max capacity at tt
                        rhs = max(g.c_up[tt], g.c_do[tt])
                        # add constraint
                        block.C2_constraint.add((g, tt), (lhs <= rhs))

        self.C2_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.C2_constraint_build = BuildAction(rule=C2_constraint_rule)


