from oemof import solph

from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Set, NonNegativeReals, Var, Constraint, BuildAction)
from oemof.solph import sequence as solph_sequence


########################################################################
# ----------------------- DSM Component --------------------------------

class SinkDsm(solph.Sink):
    r""" A special sink component which modifies the input demand series.

    Parameters
    ----------
    c_up: int or array
        If True Bus is slack bus for network
    c_do: int or array
        Maximum value of voltage angle at electrical bus
    delay_time: int
        Mininum value of voltag angle at electrical bus
    demand: int or array
        Mininum value of voltag angle at electrical bus

    Note: This component is experimental. Use it with care.

    Notes
    -----
    The following sets, variables, constraints and objective parts are created
     * :py:class:`~oemof.solph.blocks.Bus`
    The objects are also used inside:
     * :py:class:`~oemof.solph.custom.ElectricalLine`

    """

    def __init__(self, demand, c_up, c_do, delay_time, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.c_up = solph_sequence(c_up)
        self.c_do = solph_sequence(c_do)
        self.delay_time = delay_time
        self.demand = solph_sequence(demand)

    def constraint_group(self):
        return SinkDsmBlock


class SinkDsmBlock(SimpleBlock):
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
                    rhs = g.c_do[t]
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

        def equivalent_power_constraint_rule(block):
            ''' new rule: inactive and doesnt work yet'''

            for t in m.TIMESTEPS:
                for g in group:

                    # first time steps: 0 + delay time
                    if t <= g.delay_time:

                        lhs = 0

                        rhs = value(min(self.DSMup[g, t], sum(self.DSMdo[g, t, tt]
                                                              for tt in range(t + g.delay_time + 1))))

                        block.input_output_relation.add((g, t), (lhs == rhs))

                    # main use case
                    elif g.delay_time < t <= m.TIMESTEPS._bounds[1] - g.delay_time:

                        lhs = 0

                        rhs = value(min(self.DSMup[g, t], sum(self.DSMdo[g, t, tt]
                                                              for tt in range(t - g.delay_time, t + g.delay_time + 1))))

                        # add constraint
                        block.input_output_relation.add((g, t), (lhs == rhs))


                    # last time steps: end - delay time
                    else:

                        lhs = 0

                        rhs = value(min(self.DSMup[g, t], sum(self.DSMdo[g, t, tt]
                                                              for tt in
                                                              range(t - g.delay_time, m.TIMESTEPS._bounds[1] + 1))))

                        block.input_output_relation.add((g, t), (lhs == rhs))

# self.equivalent_power_consraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
# self.equivalent_power_consraint_build = BuildAction(rule=equivalent_power_constraint_rule)


# Extendable with Equation 11:
# Recovery rule missing
