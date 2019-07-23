from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os
from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Binary, Set, NonNegativeReals, Var, Constraint,
                           Expression, BuildAction, Piecewise)
from oemof.solph import sequence as solph_sequence


#import modelprint as mp




########################################################################
# ----------------------- DSM Component --------------------------------

class SinkDsm(solph.Sink):

    def __init__(self, demand, c_up, c_do, l_dsm,  *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.c_up = solph_sequence(c_up)
        self.c_do = solph_sequence(c_do)
        self.l_dsm = l_dsm
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

        for n in group:
            n.inflow = list(n.inputs)[0]

        #  ************* SETS *********************************

        self.DSM = Set(initialize=[n for n in group])

        #  ************* VARIABLES *****************************

        self.DSMdo = Var(self.DSM, m.TIMESTEPS, m.TIMESTEPS, initialize=0, within=NonNegativeReals)  # Zerrahn Variable load shift down (MWh)

        self.DSMup = Var(self.DSM, m.TIMESTEPS, initialize=0, within=NonNegativeReals)  # Zerrahn Variable load shift up(MWh)

        #  ************* CONSTRAINTS *****************************

        def _input_output_relation_rule(block):
            """Connection between input and internal demand.
            """
            for t in m.TIMESTEPS:
                for g in group:

                    if t <= g.l_dsm:

                        lhs = m.flow[g.inflow, g, t]
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))
                        block.input_output_relation.add((g, t), (lhs == rhs))

                    elif g.l_dsm < t <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        lhs = m.flow[g.inflow, g, t]
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t-g.l_dsm, t + g.l_dsm + 1))
                        block.input_output_relation.add((g, t), (lhs == rhs))

                    else:

                        lhs = m.flow[g.inflow, g, t]
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t - g.l_dsm, m.TIMESTEPS._bounds[1] + 1))
                        block.input_output_relation.add((g, t), (lhs == rhs))


        self.input_output_relation = Constraint(group, m.TIMESTEPS,
                                                noruleinit=True)
        self.input_output_relation_build = BuildAction(
            rule=_input_output_relation_rule)

        # Equation 7'
        # Eq. 7 and 7' is the same, only one difference, which is "efficiency factor n".
        # # m.n == efficiency factor set to "n=1"

        def dsmupdo_constraint_rule(block):

            for t in m.TIMESTEPS:
                for g in group:

                    if t <= g.l_dsm:

                        return sum(self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))\
                               == self.DSMup[g, t] # * m.n

                    elif g.l_dsm < t <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        return sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, t + g.l_dsm + 1))\
                               == m.DSMup[t] # * m.n

                    else:

                        return sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, m.TIMESTEPS._bounds[1] + 1))\
                               == self.DSMup[g, t] # * m.n

        self.dsmupdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmupdo_constraint_build = BuildAction(rule= dsmupdo_constraint_rule)

        # Equation 8

        def dsmup_constraint_rule(block):

            for t in m.TIMESTEPS:
                for g in group:
                    #return self.DSMup[g, t] <= g.c_do[t]
                    return (None, self.DSMup[g,t], g.c_do[t])

        self.dsmup_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmup_constraint_build = BuildAction(rule= dsmup_constraint_rule)


        # Equation 9

        def dsmdo_constraint_rule(block):

            for T in m.TIMESTEPS:
                for g in group:

                    if T <= g.l_dsm:

                        #return sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)) \
                        #    <= g.c_do[T]

                        return (None,
                                sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)),
                                g.c_do[T])

                    elif g.l_dsm < T <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        #return sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))\
                        #       <= g.c_do[T]

                        return (None,
                                sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1)),
                                g.c_do[T])

                    else:

                        #return sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1)) \
                        #    <= g.c_do[T]

                        return (None,
                                sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] + 1)),
                                g.c_do[T])

        self.dsmdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmdo_constraint_build = BuildAction(rule=dsmdo_constraint_rule)


        # Equation 10

        def C2_constraint_rule(block):

            for T in m.TIMESTEPS:
                for g in group:

                    if T <= g.l_dsm:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1))

                        return (None,
                                self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)),
                                max(g.c_up[T], g.c_do[T]))

                    elif g.l_dsm < T <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))

                        return (None,
                                self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1)),
                                max(g.c_up[T], g.c_do[T]))

                    else:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1))

                        return (None,
                                self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] + 1)),
                                max(g.c_up[T], g.c_do[T]))

        # Equation 11

        self.C2_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.C2_constraint_build = BuildAction(rule=C2_constraint_rule)

        # Recovery rule missing


#################################################################


def create_model(data, timesteps):
    # Adjust Timesteps
    timesteps = pd.date_range('1/1/2019', periods=timesteps, freq='H')

    # Create Energy System
    es = solph.EnergySystem(timeindex=timesteps)
    Node.registry = es


    # Create Busses
    b_coal = solph.Bus(label='bus_coal')
    b_elec = solph.Bus(label='bus_elec')


    # Create Sources
    s_coal = solph.Source(label='source_coal',
                         outputs={b_coal: solph.Flow(
                             nominal_value=1000)})


    # Create Transformer
    cfp = solph.Transformer(label='pp_coal',
                           inputs={b_coal: solph.Flow()},
                           outputs={b_elec: solph.Flow(
                               variable_costs=50)},
                           conversion_factors={b_elec: 0.5})



    # Create DSM sink
    demand_dsm = SinkDsm(label='demand_dsm',
                         inputs={b_elec: solph.Flow()},
                         c_up=data['Cap_up'] * 10,
                         c_do=data['Cap_do'] * 10,
                         l_dsm=3,
                         demand=data['demand_el'] * 100)


    # Create Model
    m = solph.Model(es)

    # Solve Model
    m.solve(solver='cbc', solve_kwargs={'tee': False})

    # Write LP File
    filename = os.path.join(os.path.dirname(__file__), 'model_dsm_sink.lp')
    m.write(filename, io_options={'symbolic_solver_labels': True})

    # Save Results
    es.results['main'] = outputlib.processing.results(m)
    es.results['meta'] = outputlib.processing.meta_results(m)
    es.dump(dpath=None, filename=None)

    return m



#################################################################
# ----------------- Input Data & Timesteps ----------------------------

# Provide Data
filename = os.path.join(os.path.dirname(__file__), './Input/input_new.csv')
data = pd.read_csv(filename, sep=",")

# Timesteps
timesteps = 15


# Create & Solve Model
model = create_model(data, timesteps)

# Get Results
es = solph.EnergySystem()
es.restore(dpath=None, filename=None)

# Get output data
b_coal = outputlib.views.node(model.es.results['main'], 'bus_coal')
b_elec = outputlib.views.node(model.es.results['main'], 'bus_elec')
b_dsm = outputlib.views.node(es.results['main'], 'demand_dsm')

# Sum dsmdo
dsmdo = []
dsmup = []
for k in range(timesteps):
    dsmdo.append(b_dsm['sequences'].iloc[k, 1:-1].sum())
    dsmup.append(b_dsm['sequences'].iloc[k, -1])

df_output = pd.DataFrame(data = dsmdo, columns=['DSM_do'])
df_output['demand'] = data.demand_el.iloc[:timesteps]*100


# Show Output Data

print('-----------------------------------------------------')
print('OBJ: ', model.objective())
print('-----------------------------------------------------')
print(b_dsm['sequences'].iloc[:, 0])
print('-----------------------------------------------------')
print(b_elec['sequences'].iloc[:, 0])
print('-----------------------------------------------------')
print(b_elec['sequences'].iloc[:, 1])
print('-----------------------------------------------------')
print(df_output)
print('------------------TOTAL------------------------')
print(df_output.sum())






#import pdb;    pdb.set_trace()


