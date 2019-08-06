from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os
from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Binary, Set, NonNegativeReals, Var, Constraint,
                           Expression, BuildAction, Piecewise)
from oemof.solph import sequence as solph_sequence
import matplotlib.pyplot as plt

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
            """Connection between input and internal demand."""
            for t in m.TIMESTEPS:
                for g in group:

                    if t <= g.l_dsm:

                        lhs = m.flow[g.inflow, g, t]
                        #rhs = g.demand[t] + self.DSMup[g, t] - sum(
                        #    self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))
                        block.input_output_relation.add((g, t), (lhs >= rhs))

                    elif g.l_dsm < t <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        lhs = m.flow[g.inflow, g, t]
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t-g.l_dsm, t + g.l_dsm + 1))
                        block.input_output_relation.add((g, t), (lhs >= rhs))

                    else:

                        lhs = m.flow[g.inflow, g, t]
                        rhs = g.demand[t] + self.DSMup[g, t] - sum(
                            self.DSMdo[g, t, T] for T in range(t - g.l_dsm, m.TIMESTEPS._bounds[1] + 1))
                        block.input_output_relation.add((g, t), (lhs >= rhs))

        self.input_output_relation = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.input_output_relation_build = BuildAction(rule=_input_output_relation_rule)

        # Equation 7'
        # Eq. 7 and 7' is the same, only one difference, which is "efficiency factor n".
        # # m.n == efficiency factor set to "n=1"

        def dsmupdo_constraint_rule(block):

            for t in m.TIMESTEPS:
                for g in group:

                    if t <= g.l_dsm:
                        lhs = sum(self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))
                        rhs = self.DSMup[g, t]

                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

                        #return sum(self.DSMdo[g, t, T] for T in range(t + g.l_dsm + 1))\
                        #       == self.DSMup[g, t] # * m.n

                    elif g.l_dsm < t <= m.TIMESTEPS._bounds[1] - g.l_dsm:
                        lhs = sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, t + g.l_dsm + 1))
                        rhs = self.DSMup[g, t]

                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

                        #return sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, t + g.l_dsm + 1))\
                        #       == m.DSMup[t] # * m.n

                    else:

                        lhs = sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, m.TIMESTEPS._bounds[1] + 1))
                        rhs = self.DSMup[g, t]

                        block.dsmupdo_constraint.add((g, t), (lhs == rhs))

                        #return sum(self.DSMdo[g, t, T] for T in range(t - g.l_dsm, m.TIMESTEPS._bounds[1] + 1))\
                        #       == self.DSMup[g, t] # * m.n

        self.dsmupdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmupdo_constraint_build = BuildAction(rule=dsmupdo_constraint_rule)

        # Equation 8

        def dsmup_constraint_rule(block):

            for t in m.TIMESTEPS:
                for g in group:
                    #return  <=
                    #return (None, self.DSMup[g,t], g.c_do[t])
                    lhs = self.DSMup[g, t]
                    rhs = g.c_do[t]
                    block.dsmup_constraint.add((g, t), (lhs <= rhs))

        self.dsmup_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmup_constraint_build = BuildAction(rule= dsmup_constraint_rule)


        # Equation 9

        def dsmdo_constraint_rule(block):

            for T in m.TIMESTEPS:
                for g in group:

                    if T <= g.l_dsm:

                        #return sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)) \
                        #    <= g.c_do[T]
                        lhs = sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1))
                        rhs = g.c_do[T]
                        block.dsmdo_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)),
                        #        g.c_do[T])

                    elif g.l_dsm < T <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        #return sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))\
                        #       <= g.c_do[T]
                        lhs = sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))
                        rhs = g.c_do[T]
                        block.dsmdo_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1)),
                        #        g.c_do[T])

                    else:

                        #return sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1)) \
                        #    <= g.c_do[T]
                        lhs = sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1))
                        rhs = g.c_do[T]
                        block.dsmdo_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] + 1)),
                        #        g.c_do[T])

        self.dsmdo_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.dsmdo_constraint_build = BuildAction(rule=dsmdo_constraint_rule)


        # Equation 10

        def C2_constraint_rule(block):

            for T in m.TIMESTEPS:
                for g in group:

                    if T <= g.l_dsm:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1))
                        lhs = self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1))
                        rhs = max(g.c_up[T], g.c_do[T])

                        block.C2_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T + g.l_dsm + 1)),
                        #        max(g.c_up[T], g.c_do[T]))

                    elif g.l_dsm < T <= m.TIMESTEPS._bounds[1] - g.l_dsm:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))

                        lhs = self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1))
                        rhs = max(g.c_up[T], g.c_do[T])
                        block.C2_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, T + g.l_dsm + 1)),
                        #        max(g.c_up[T], g.c_do[T]))

                    else:

                        #return max(g.c_up[T], g.c_do[T]) >= self.DSMup[g, T] + sum(
                        #    self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1))

                        lhs = self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] +1))
                        rhs = max(g.c_up[T], g.c_do[T])
                        block.C2_constraint.add((g, T), (lhs <= rhs))

                        #return (None,
                        #        self.DSMup[g, T] + sum(self.DSMdo[g, t, T] for t in range(T - g.l_dsm, m.TIMESTEPS._bounds[1] + 1)),
                        #        max(g.c_up[T], g.c_do[T]))

        self.C2_constraint = Constraint(group, m.TIMESTEPS, noruleinit=True)
        self.C2_constraint_build = BuildAction(rule=C2_constraint_rule)

        # Equation 11
        # Recovery rule missing

#################################################################
#                       Output Graph


def adjust_yaxis(ax, ydif, v):
    """shift axis ax by ydiff, maintaining point v at the same location"""
    inv = ax.transData.inverted()
    _, dy = inv.transform((0, 0)) - inv.transform((0, ydif))
    miny, maxy = ax.get_ylim()
    miny, maxy = miny - v, maxy - v
    if -miny > maxy or (-miny == maxy and dy > 0):
        nminy = miny
        nmaxy = miny*(maxy+dy)/(miny+dy)
    else:
        nmaxy = maxy
        nminy = maxy * (miny + dy) / (maxy + dy)
    ax.set_ylim(nminy+v, nmaxy+v)


def align_yaxis(ax1, v1, ax2, v2):
    """adjust ax2 ylimit so that v2 in ax2 is aligned to v1 in ax1"""
    _, y1 = ax1.transData.transform((0, v1))
    _, y2 = ax2.transData.transform((0, v2))
    adjust_yaxis(ax2, (y1 - y2) / 2, v2)
    adjust_yaxis(ax1, (y2 - y1) / 2, v1)


def extract_results(model, timesteps, data):
    '''Extract data fro Pyomo Variables in DataFrames and plot for visualization'''

    # Get output data
    df_coal_1 = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pp_coal_1', 'bus_elec'), 'flow')]
    df_coal_2 = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pp_coal_2', 'bus_elec'), 'flow')]
    df_wind = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('wind', 'bus_elec'), 'flow')]
    df_pv = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pv', 'bus_elec'), 'flow')]
    df_dsm = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('bus_elec', 'demand_dsm'), 'flow')]
    df_excess = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('bus_elec', 'excess_el'), 'flow')]
    df_shortage = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('shortage_el', 'bus_elec'), 'flow')]

    df_dsmdo = outputlib.views.node(model.es.results['main'], 'demand_dsm')['sequences'].iloc[:, 1:-1].sum(axis=1)
    df_dsmup = outputlib.views.node(model.es.results['main'], 'demand_dsm')['sequences'].iloc[:, -1]

    df_gesamt = pd.concat([df_coal_1, df_coal_2, df_dsm, df_pv, df_wind, df_dsmdo, df_dsmup], axis=1)

    df_gesamt.to_csv('dsm.csv')

    demand = 100 * data.demand_el[0:timesteps].values
    dsm = df_dsm.values
    graph_coal1 = df_coal_1.values
    graph_coal2 = graph_coal1 + df_coal_2.values
    graph_wind = graph_coal2 + df_wind.values
    graph_pv = graph_wind + df_pv.values
    graph_shortage = graph_pv + df_shortage.values
    graph_excess = dsm + df_excess.values

    residual = graph_coal2
    dsm_capup = 1e3 * data.Cap_up
    dsm_capdo = 1e3 * data.Cap_do

    # create Figure
    fig1, ax1 = plt.subplots()
    # Demands
    ax1.plot(range(timesteps), demand, label='Demand', linestyle='--')
    ax1.plot(range(timesteps), dsm, label='demand_DSM')
    ax1.plot(range(timesteps), graph_excess, label='excess')
    ax1.fill_between(range(timesteps), 0, graph_coal1, label='Coal_1', facecolor='black', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_coal1, graph_coal2, label='Coal_1', facecolor='black', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_coal2, graph_wind, label='Wind', facecolor='darkcyan', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_wind, graph_pv, label='PV', facecolor='gold', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_pv, graph_shortage, label='Shortage', facecolor='red', alpha=0.5)

    ax1.legend(loc=9, ncol=5)
    fig1.savefig('./Grafiken/oemof_dsm.png', bbox_inches='tight')

    #fig2, ax2 = plt.subplots()

    return df_gesamt


#################################################################


def create_model(data, timesteps):
    # Adjust Timesteps
    timesteps = pd.date_range('1/1/2019', periods=timesteps, freq='H')

    # Create Energy System
    es = solph.EnergySystem(timeindex=timesteps)
    Node.registry = es


    # Create Busses
    b_coal_1 = solph.Bus(label='bus_coal_1')
    b_coal_2 = solph.Bus(label='bus_coal_2')
    b_elec = solph.Bus(label='bus_elec')


    # Create Sources
    s_coal_p1 = solph.Source(label='source_coal_p1',
                             outputs={
                                b_coal_1: solph.Flow(
                                    nominal_value=100,
                                    variable_costs=10)
                             })

    s_coal_p2 = solph.Source(label='source_coal_p2',
                             outputs={
                                 b_coal_2: solph.Flow(
                                    nominal_value=100,
                                    variable_costs=20)
                             })

    s_wind = solph.Source(label='wind',
                          outputs={
                              b_elec: solph.Flow(
                                  actual_value=data['wind'],
                                  fixed=True,
                                  nominal_value=100)
                          })

    s_pv = solph.Source(label='pv',
                          outputs={
                              b_elec: solph.Flow(
                                  actual_value=data['pv'],
                                  fixed=True,
                                  nominal_value=100)
                          })

    # Create Transformer
    cfp_1 = solph.Transformer(label='pp_coal_1',
                           inputs={b_coal_1: solph.Flow()},
                           outputs={
                               b_elec: solph.Flow(
                                   variable_costs=0)},
                           conversion_factors={b_elec: 1}
                            )

    cfp_2 = solph.Transformer(label='pp_coal_2',
                           inputs={b_coal_2: solph.Flow()},
                           outputs={
                               b_elec: solph.Flow(
                                   variable_costs=0)},
                           conversion_factors={b_elec: 1}
                            )

    # Create DSM
    demand_dsm = SinkDsm(label='demand_dsm',
                         inputs={b_elec: solph.Flow()},
                         c_up=data['Cap_up'] * 1e3,
                         c_do=data['Cap_do'] * 1e3,
                         l_dsm=1,
                         demand=data['demand_el'] * 100
                         )
    # excess
    excess = solph.Sink(label='excess_el', inputs={b_elec: solph.Flow()})

    s_shortage_el = solph.Source(label='shortage_el',
                                 outputs={b_elec: solph.Flow(
                                     variable_costs=200)})

    # Create Sink Demand
    #demand = solph.Sink(label='demand',
    #                    inputs={
    #                        b_elec: solph.Flow(
    #                            actual_value=data['demand_el'],
    #                            fixed=True,
    #                            nominal_value=10)
    #                    })


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
oemof_test = 'oemof_dsm_test.csv'
input_urbs = './Input/input_new.csv'
filename = os.path.join(os.path.dirname(__file__), oemof_test)
data = pd.read_csv(filename, sep=",", encoding='utf-8')


# Timesteps
timesteps = 20



# Create & Solve Model
model = create_model(data, timesteps)

# Get Results
es = solph.EnergySystem()
es.restore(dpath=None, filename=None)

# Get output data
b_coal_1 = outputlib.views.node(model.es.results['main'], 'bus_coal_1')
b_coal_2 = outputlib.views.node(model.es.results['main'], 'bus_coal_2')
b_elec = outputlib.views.node(model.es.results['main'], 'bus_elec')
b_dsm = outputlib.views.node(es.results['main'], 'demand_dsm')
b_wind = outputlib.views.node(es.results['main'], 'wind')


# Sum dsmdo
dsmdo = []
dsmup = []
for k in range(timesteps):
    dsmdo.append(b_dsm['sequences'].iloc[k, 1:-1].sum())
    dsmup.append(b_dsm['sequences'].iloc[k, -1])

df_output = pd.DataFrame(data=dsmdo, columns=['DSM_do'])
df_output['DSM_up'] = pd.DataFrame(data=dsmup, columns=['DSM_up'])
df_output['demand'] = data.demand_el.iloc[:timesteps]*100

df_gesamt = extract_results(model, timesteps, data)

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
print(b_wind['sequences'].iloc[:,0])
print('-----------------------------------------------------')
print(df_output)
print('------------------TOTAL------------------------')
print(df_output.sum())






#import pdb;    pdb.set_trace()


