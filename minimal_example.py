from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os

# plotting
import plot_dsm_minimal as pltdsm


#################################################################
# MODEL


def create_model(data, datetimeindex):
    # Create some data
    pv_day = [(-(1 / 6 * x ** 2) + 6) / 6 for x in range(-6, 7)]
    pv_ts = [0] * 6 + pv_day + [0] * 6
    data_dict = {"demand_el": [3] * len(pv_ts),
                 "pv": pv_ts,
                 "Cap_up": [0.5] * len(pv_ts),
                 "Cap_do": [0.5] * len(pv_ts)}
    data = pd.DataFrame.from_dict(data_dict)

    # Do timestamp stuff
    datetimeindex = pd.date_range(start='1/1/2013', periods=len(data.index), freq='H')
    data['timestamp'] = datetimeindex
    data.set_index('timestamp', inplace=True)

    # Create Energy System
    es = solph.EnergySystem(timeindex=datetimeindex)
    Node.registry = es

    # Create bus representing electricity grid
    b_elec = solph.Bus(label='Electricity bus')

    # Create a back supply
    grid = solph.Source(label='Grid',
                        outputs={
                            b_elec: solph.Flow(
                                nominal_value=10000,
                                variable_costs=50)}
                        )

    # PV supply from time series
    s_wind = solph.Source(label='wind',
                          outputs={
                              b_elec: solph.Flow(
                                  actual_value=data['pv'],
                                  fixed=True,
                                  nominal_value=3.5)}
                          )

    # Create DSM Sink
    demand_dsm = solph.custom.SinkDSM(label='DSM',
                                      inputs={b_elec: solph.Flow()},
                                      capacity_up=data['Cap_up'],
                                      capacity_down=data['Cap_do'],
                                      delay_time=6,
                                      demand=data['demand_el'],
                                      method="delay",
                                      cost_dsm_down=5)

    # Create Model
    m = solph.Model(es)

    # Solve Model
    m.solve(solver='cbc', solve_kwargs={'tee': False})

    # Write LP File
    lp_filename = os.path.join(project_dir, 'SinkDSM.lp')
    m.write(lp_filename, io_options={'symbolic_solver_labels': True})

    # Save Results
    es.results['main'] = outputlib.processing.results(m)
    es.results['meta'] = outputlib.processing.meta_results(m)
    es.dump(dpath=None, filename=None)

    return m


if __name__ == "__main__":

    METHOD = "delay"
    DELAYTIME = 3
    INTERVAL = 14
    timesteps = 24

    # Provide path to project directory
    project_dir = os.path.join(os.path.expanduser("~"),
                               "rli-lokal",
                               "143_WindNODE",
                               "fix-wrong-dsn-capacity-constraint-interval-method")


    # Data
    data_filename = "oemof_dsm_test_data_varying_capacity.csv"


    os.makedirs(project_dir, exist_ok=True)
    os.makedirs(os.path.join(project_dir, "Grafiken"), exist_ok=True)
    # pltdsm.make_directory(project_dir, subfolder_name='Grafiken')

    # get data
    data_file = os.path.join(os.path.dirname(__file__), data_filename)
    pv_day = [(-(1/6*x**2)+6)/6 for x in range(-6, 7)]
    pv_ts = [0] * 6 + pv_day + [0] * 6
    data_dict = {"demand_el": [3] * len(pv_ts),
                 "wind": pv_ts,
                 "Cap_up": [0.5] * len(pv_ts),
                 "Cap_do": [0.5] * len(pv_ts)}
    data = pd.DataFrame.from_dict(data_dict)

    # replace timestamp
    data['timestamp'] = pd.date_range(start='1/1/2013', periods=len(data.index), freq='H')
    data.set_index('timestamp', inplace=True)

    # Adjust Timesteps
    datetimeindex = pd.date_range(start='1/1/2013', periods=timesteps, freq='H')

    # Create & Solve Model
    model = create_model(data, datetimeindex)

    # Get Results
    es = solph.EnergySystem()
    es.restore(dpath=None, filename=None)

    df_gesamt = pltdsm.extract_results(model, data, datetimeindex, project_dir)
    # Plot
    pltdsm.plot(df_gesamt, datetimeindex, project_dir, timesteps, METHOD)

    # Show Output Data

    #print('-----------------------------------------------------')
    #print(df_total[ (('pp_coal_2', 'bus_elec'), 'flow') ])
    #print('-----------------------------------------------------')
    #print(df_total[ (('bus_elec', 'demand_dsm'), 'flow') ])
    #print('-----------------------------------------------------')
    #print(df_total[ (('pv', 'bus_elec'), 'flow') ])
    #print('-----------------------------------------------------')
    #print(df_total[ (('wind', 'bus_elec'), 'flow') ])
    #print(model.es.groups[<class 'oemof_DSM_component.SinkDsmBlock'>].demand)

    print('-----------------------------------------------------')
    print('OBJ: ', model.objective())
    print('-----------------------------------------------------')

    print(df_gesamt[['dsm_up', 'dsm_do', 'dsm_tot', 'DSM']])
    print('------------------TOTAL------------------------')

    print('DSMup')
    print(df_gesamt['dsm_up'].sum())

    print('DSMdown')
    print(df_gesamt['dsm_do'].sum())

    #import pdb;    pdb.set_trace()


