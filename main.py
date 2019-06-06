from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os


def create_model(data, timesteps):
    # Adjust Timesteps
    timesteps = pd.date_range('1/1/2019', periods=timesteps, freq='H')

    # Create Energy System
    es = solph.EnergySystem(timeindex=timesteps)
    Node.registry = es

    # Data Manipulation
    data = data

    # Create Busses
    b_coal = solph.Bus(label='bus_coal')
    b_gas  = solph.Bus(label='bus_gas')
    b_elec = solph.Bus(label='bus_elec')


    # Create Sources
    s_coal = solph.Source(label='source_coal',
                          outputs={b_coal: solph.Flow(
                              nominal_value=200)})
    s_gas = solph.Source(label='source_gas',
                         outputs={b_gas: solph.Flow(
                             nominal_value=200)})



    # Create Sink
    demand = solph.Sink(label='demand',
                        inputs={b_elec: solph.Flow(
                            actual_value=150,
                            fixed=True,
                            nominal_value=1)})

    # Create Transformer
    cfp = solph.Transformer(label='pp_coal',
                            inputs={b_coal: solph.Flow()},
                            outputs={b_elec: solph.Flow(
                                variable_costs=50)},
                            conversion_factors={b_elec: 0.5})

    gfp = solph.Transformer(label='pp_gas',
                            inputs={b_gas: solph.Flow()},
                            outputs={b_elec: solph.Flow(
                                variable_costs = 100)},
                            conversion_factors={b_elec: 0.6}
                            )


    # Create Model
    m = solph.Model(es)

    # Solve Model
    m.solve(solver='cbc', solve_kwargs={'tee': False})

    # Write LP File
    filename = os.path.join(os.path.dirname(__file__), 'model.lp')
    m.write(filename, io_options={'symbolic_solver_labels': True})

    # Save Results
    es.results['main'] = outputlib.processing.results(m)
    es.results['meta'] = outputlib.processing.meta_results(m)
    es.dump(dpath=None, filename=None)

    return m


if __name__ == '__main__':
    # Input Data & Timesteps
    data = None
    timesteps = 3

    # Create & Solve Model
    model = create_model(data, timesteps)

    # Get Results
    es = solph.EnergySystem()
    es.restore(dpath=None, filename=None)

    # Show Results
    b_coal = outputlib.views.node(es.results['main'], 'bus_coal')
    b_gas = outputlib.views.node(es.results['main'], 'bus_gas')
    b_elec = outputlib.views.node(es.results['main'], 'bus_elec')

    print('-----------------------------------------------------')
    print('Bus Coal\n', b_coal['sequences'])
    print('-----------------------------------------------------')
    print('Bus Gas\n',  b_gas['sequences'])
    print('-----------------------------------------------------')
    print('Bus Elec\n', b_elec['sequences'])
    print('-----------------------------------------------------')
    print('OBJ: ', model.objective())
