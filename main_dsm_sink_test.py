from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os
from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Binary, Set, NonNegativeReals, Var, Constraint,
                           Expression, BuildAction, Piecewise)
from oemof.solph import sequence as solph_sequence

class SinkDsm(solph.Sink):

    def __init__(self, demand, c_up, c_do, l_dsm,  *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.c_up = c_up
        self.c_do = c_do
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
                    lhs = m.flow[g.inflow, g, t]
                    rhs = g.demand[t] + 20
                    block.input_output_relation.add((g, t), (lhs == rhs))

        self.input_output_relation = Constraint(group, m.TIMESTEPS,
                                                noruleinit=True)
        self.input_output_relation_build = BuildAction(
            rule=_input_output_relation_rule)


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
                         c_up = [2],
                         c_do = [2],
                         l_dsm = [2],
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


#if __name__ == '__main__':
# Input Data & Timesteps

# Provide Data
filename = os.path.join(os.path.dirname(__file__), './Input/input_data.csv')
data = pd.read_csv(filename, sep=",")
timesteps = 1

# Create & Solve Model
model = create_model(data, timesteps)

# Get Results
es = solph.EnergySystem()
es.restore(dpath=None, filename=None)

# Show Results
b_coal = outputlib.views.node(model.es.results['main'], 'bus_coal')
b_elec = outputlib.views.node(model.es.results['main'], 'bus_elec')
b_dsm = outputlib.views.node(es.results['main'], 'demand_dsm')


#print('-----------------------------------------------------')
#print('Bus Coal\n', b_coal['sequences'])

print('-----------------------------------------------------')
print('OBJ: ', model.objective())
#print('-----------------------------------------------------')
#print('Bus Elec\n', b_elec['sequences'])


print('-----------------------------------------------------')
print(b_dsm['sequences'])
print('-----------------------------------------------------')
print(b_elec['sequences'].iloc[:,0])
print('-----------------------------------------------------')
print(b_elec['sequences'].iloc[:,1])

#results = outputlib.processing.results(model)
#print(type(list(results)[0]))


# key in b_elec.iteritems():
    #print(key)

#import pdb;    pdb.set_trace()


