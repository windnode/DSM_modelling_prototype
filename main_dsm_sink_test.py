from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os
from pyomo.core.base.block import SimpleBlock
from pyomo.environ import (Binary, Set, NonNegativeReals, Var, Constraint,
                           Expression, BuildAction, Piecewise)


class SinkDsm(solph.Sink):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.c_up = kwargs.get('c_up', 4)
        self.c_do = kwargs.get('c_do', 4)
        self.l_dsm = kwargs.get('l-dsm', 4)

    def constraint_group(self):
        return SinkDsmBlock

    def show_input(self):
        return print(self.c_up)


class SinkDsmBlock(SimpleBlock):

    CONSTRAINT_GROUP = True

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def _create(self, group=None):
        if group is None:
            return None

        m = self.parent_block()


#


#################################################################


def create_model(data, timesteps):
    # Adjust Timesteps
    timesteps = pd.date_range('1/1/2019', periods=timesteps, freq='H')

    # Create Energy System
    es = solph.EnergySystem(timeindex=timesteps)
    Node.registry = es





    # Data Manipulation
    data = data

    # Create Busses
    #b_coal = solph.Bus(label='bus_coal')
    b_elec = solph.Bus(label='bus_elec')


    # Create Sources
    #s_coal = solph.Source(label='source_coal',
    #                      outputs={b_coal: solph.Flow(
    #                          nominal_value=200)})


    s_shortage_el = solph.Source(label='shortage_el',
                         outputs={b_elec: solph.Flow(
                             variable_costs=200)})

    s_wind = solph.Source(label='wind',
                          outputs={b_elec: solph.Flow(
                              actual_value=data['wind'],
                              fixed=True,
                              nominal_value=100)})




    # Create Sink
    demand = solph.Sink(label='demand',
                        inputs={b_elec: solph.Flow(
                            actual_value=data['demand_el'],
                            fixed=True,
                            nominal_value=100)})

    #'''
    demand_dsm = SinkDsm(label='demand_dsm',
                          inputs={b_elec: solph.Flow(
                              actual_value=data['demand_el'],
                              fixed=True,
                              nominal_value=100)},
                         c_up = 2,
                         c_do = 2,
                         l_dsm = 2)

    #'''





    # excess variable
    excess = solph.Sink(label='excess_el', inputs={b_elec: solph.Flow()})




    # Create Transformer

    #cfp = solph.Transformer(label='pp_coal',
    #                        inputs={b_coal: solph.Flow()},
    #                        outputs={b_elec: solph.Flow(
    #                            variable_costs=50)},
    #                        conversion_factors={b_elec: 0.5})



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

#b_coal = outputlib.views.node(es.results['main'], 'bus_coal')
b_elec = outputlib.views.node(es.results['main'], 'bus_elec')



#print('-----------------------------------------------------')
#print('Bus Coal\n', b_coal['sequences'])
print('-----------------------------------------------------')
print('Bus Elec\n', b_elec['sequences'])
print('-----------------------------------------------------')
print('OBJ: ', model.objective())

#results = outputlib.processing.results(model)


import pdb;    pdb.set_trace()
