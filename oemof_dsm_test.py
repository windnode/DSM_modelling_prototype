from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os

# plotting
import plot_dsm as pltdsm


#################################################################
# MODEL


def create_model(data, datetimeindex):

    # Create Energy System
    es = solph.EnergySystem(timeindex=datetimeindex)
    Node.registry = es

    # Create Busses
    b_coal_1 = solph.Bus(label='bus_coal_1')
    b_coal_2 = solph.Bus(label='bus_coal_2')
    b_elec = solph.Bus(label='bus_elec')

    # Create Sources
    s_coal_p1 = solph.Source(label='source_coal_p1',
                             outputs={
                                b_coal_1: solph.Flow(
                                    nominal_value=10000,
                                    variable_costs=10)}
                             )

    s_coal_p2 = solph.Source(label='source_coal_p2',
                             outputs={
                                 b_coal_2: solph.Flow(
                                    nominal_value=10000,
                                    variable_costs=20)}
                             )

    s_wind = solph.Source(label='wind',
                          outputs={
                              b_elec: solph.Flow(
                                  actual_value=data['wind'][datetimeindex],
                                  fixed=True,
                                  nominal_value=1)}
                          )

    s_pv = solph.Source(label='pv',
                        outputs={
                            b_elec: solph.Flow(
                                actual_value=data['pv'][datetimeindex],
                                fixed=True,
                                nominal_value=1)}
                        )

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
    demand_dsm = solph.custom.SinkDSM(label='demand_dsm',
                                      inputs={b_elec: solph.Flow()},
                                      capacity_up=data['Cap_up'][datetimeindex],
                                      capacity_down=data['Cap_do'][datetimeindex],
                                      delay_time=DELAYTIME,
                                      demand=data['demand_el'][datetimeindex],
                                      shift_interval=INTERVAL,
                                      method=METHOD,
                                      cost_dsm_down=2)

    # Backup excess / shortage
    excess = solph.Sink(label='excess_el',
                        inputs={b_elec: solph.Flow(variable_costs=1)}
                        )

    s_shortage_el = solph.Source(label='shortage_el',
                                 outputs={
                                     b_elec: solph.Flow(
                                         variable_costs=200)}
                                 )


    ######################################################################
    # -------------------------- Create Model ----------------------

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

# ################################################################
# ----------------- Input Data & Timesteps ----------------------------

# Provide Data
#project = '24h_konzept'
project = 'recovery-time'

pltdsm.make_directory(project, subfolder_name='Grafiken')
#pltdsm.make_directory(project + '/Grafiken')
directory = './' + project + '/'

#file = directory + 'oemof_dsm_test_recovery.csv'
#file = directory + 'abw_test_timestamp.csv'
#file = directory + '24_konzept_generisch.csv'
file = directory + 'recovery.csv'
filename_data = os.path.join(os.path.dirname(__file__), file)

oemof_test = directory + 'oemof_dsm_test_generisch_short2.csv'
#oemof_test = directory + 'oemof_dsm_test_generisch_longer.csv'
input_urbs = './Input/input_new.csv'
filename_data = os.path.join(os.path.dirname(__file__), oemof_test)

# replace timestamp
data['timestamp'] = pd.date_range(start='1/1/2013', periods=len(data.index), freq='H')
data.set_index('timestamp', inplace=True)

# Data manipulation
data = data

# Timesteps
timesteps = 58


# Adjust Timesteps

datetimeindex = pd.date_range(start='1/1/2013', periods=timesteps, freq='H')


# Create & Solve Model
model = create_model(data, datetimeindex)


# Get Results
es = solph.EnergySystem()
es.restore(dpath=None, filename=None)



df_gesamt = pltdsm.extract_results(model, data, datetimeindex, directory)
# Plot
pltdsm.plot(df_gesamt, datetimeindex, directory, timesteps, project)


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

print(df_gesamt[['dsm_up', 'dsm_do', 'dsm_tot', 'demand_dsm']])
print('------------------TOTAL------------------------')

print('DSMup')
print(df_gesamt['dsm_up'].sum())

print('DSMdown')
print(df_gesamt['dsm_do'].sum())

#import pdb;    pdb.set_trace()


