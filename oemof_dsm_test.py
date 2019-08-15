from oemof import solph, outputlib
from oemof.network import Node
import pandas as pd
import os

import DSM_component as oemof_dsm

import matplotlib.pyplot as plt



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

    # ########################### Get DataFrame out of Pyomo and rename series

    # Generators
    df_coal_1 = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pp_coal_1', 'bus_elec'), 'flow')]
    df_coal_1.rename('coal1', inplace=True)
    df_coal_2 = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pp_coal_2', 'bus_elec'), 'flow')]
    df_coal_2.rename('coal2', inplace=True)
    df_wind = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('wind', 'bus_elec'), 'flow')]
    df_wind.rename('wind', inplace=True)
    df_pv = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('pv', 'bus_elec'), 'flow')]
    df_pv.rename('pv', inplace=True)
    df_shortage = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('shortage_el', 'bus_elec'), 'flow')]
    df_shortage.rename('shortage', inplace=True)
    df_excess = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('bus_elec', 'excess_el'), 'flow')]
    df_excess.rename('excess', inplace=True)

    # DSM Demand
    df_dsm = outputlib.views.node(model.es.results['main'], 'bus_elec')['sequences'][
        (('bus_elec', 'demand_dsm'), 'flow')]
    df_dsm.rename('dsm', inplace=True)

    # DSM Variables
    df_dsmdo = outputlib.views.node(model.es.results['main'], 'demand_dsm')['sequences'].iloc[:, 1:-1].sum(axis=1)
    df_dsmdo.rename('dsm_do', inplace=True)
    df_dsmup = outputlib.views.node(model.es.results['main'], 'demand_dsm')['sequences'].iloc[:, -1]
    df_dsmup.rename('dsm_up', inplace=True)
    df_dsm_tot = df_dsmdo - df_dsmup
    df_dsm_tot.rename('dsm_tot', inplace=True)
    # Merge in one DataFrame
    df_total = pd.concat([df_coal_1, df_coal_2, df_dsm, df_pv, df_wind, df_dsmdo, df_dsmup, df_dsm_tot], axis=1)

    # write Data in Csv
    #df_gesamt.to_csv('DSM_component_data.csv')

    # ############ DATA PREPARATION FOR FIGURE #############################

    # ###################### from input DATA ####################
    # Demand from input
    demand = data.demand_el[0:timesteps].values
    # Capacity from input
    dsm_capup = data.Cap_up[0:timesteps].values
    dsm_capdo = data.Cap_do[0:timesteps].values

    # ##################### from model DATA ###################
    # DSM from model
    dsm = df_dsm.values
    dsmup = df_dsmup.values
    dsmdo = df_dsmdo.values
    dsmtot = df_dsm_tot.values

    # Generators from model
    graph_coal1 = df_coal_1.values
    graph_coal2 = graph_coal1 + df_coal_2.values
    graph_wind = graph_coal2 + df_wind.values
    graph_pv = graph_wind + df_pv.values
    graph_shortage = graph_pv + df_shortage.values
    graph_excess = dsm + df_excess.values
    excess = df_excess.values

    # ########################################### create Figure

    fig1, ax1 = plt.subplots()
    ax1.set_ylim([0, 200])

    # Demands
    ax1.plot(range(timesteps), dsm, label='demand_DSM', color='black')
    ax1.plot(range(timesteps), demand, label='Demand', linestyle='--', color='blue')

    # DSM Capacity
    #ax1.plot(range(timesteps), demand + dsm_capup, label='Cup', color='black', linestyle='--')
    #ax1.plot(range(timesteps), demand - dsm_capdo, label='Cdo', color='black', linestyle='--')

    ax1.plot(range(timesteps), excess, label='Excess', linestyle='--', color='green')
    #ax1.plot(range(timesteps), graph_excess, label='excess', linestyle='--', color='green')

    # Generators
    ax1.fill_between(range(timesteps), 0, graph_coal1, label='Coal_1', facecolor='black', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_coal1, graph_coal2, label='Coal_2', facecolor='grey', alpha=0.5)
    ax1.fill_between(range(timesteps), graph_coal2, graph_wind, label='Wind', facecolor='darkcyan', alpha=0.5)
    #ax1.fill_between(range(timesteps), graph_wind, graph_pv, label='PV', facecolor='gold', alpha=0.5)
    #ax1.fill_between(range(timesteps), graph_pv, graph_shortage, label='Shortage', facecolor='red', alpha=0.5)

    # Legend
    ax1.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3, ncol=4, mode="expand", borderaxespad=0.)

    # Second axis
    ax2 = ax1.twinx()
    ax2.set_ylim([-100, 100])

    # DSM up/down
    ax2.bar(range(timesteps), -dsmdo, label='DSM up/down',  alpha=0.5, color='orange')
    ax2.bar(range(timesteps), dsmup, alpha=0.5, color='black')
    #ax2.bar(range(timesteps), -dsmtot, label='DSM up/down',  alpha=0.5, color='firebrick')


    # DSM Capacity
    ax2.plot(range(timesteps), dsm_capup, label='Capacity DSM up/down', color='red', linestyle='--')
    ax2.plot(range(timesteps), - dsm_capdo, color='red', linestyle='--')
    align_yaxis(ax1, 100, ax2, 0)

    # Legend
    ax2.legend(bbox_to_anchor=(0., -0.15, 1., 0.102), loc=3, ncol=3,  borderaxespad=0., mode="expand")
    #ax2.grid()
    fig1.set_tight_layout(True)
    fig1.savefig(directory + 'Grafiken/oemof_dsm.png')

    return df_total


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
                                    variable_costs=10)}
                             )

    s_coal_p2 = solph.Source(label='source_coal_p2',
                             outputs={
                                 b_coal_2: solph.Flow(
                                    nominal_value=100,
                                    variable_costs=20)}
                             )

    s_wind = solph.Source(label='wind',
                          outputs={
                              b_elec: solph.Flow(
                                  actual_value=data['wind'],
                                  fixed=True,
                                  nominal_value=1)}
                          )

    s_pv = solph.Source(label='pv',
                        outputs={
                            b_elec: solph.Flow(
                                actual_value=data['pv'],
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
    demand_dsm = oemof_dsm.SinkDsm(label='demand_dsm',
                                   inputs={b_elec: solph.Flow()},
                                   c_up=data['Cap_up'],
                                   c_do=data['Cap_do'],
                                   delay_time=2,
                                   demand=data['demand_el']
                                   )

    # Backup excess / shortage
    excess = solph.Sink(label='excess_el',
                        inputs={b_elec: solph.Flow()}
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
    filename = os.path.join(os.path.dirname(__file__), directory, 'oemof_dsm_test.lp')
    m.write(filename, io_options={'symbolic_solver_labels': True})

    # Save Results
    es.results['main'] = outputlib.processing.results(m)
    es.results['meta'] = outputlib.processing.meta_results(m)
    es.dump(dpath=None, filename=None)

    return m

# ################################################################
# ----------------- Input Data & Timesteps ----------------------------


directory = './Comparisson/'

# Provide Data

oemof_test = directory + 'oemof_dsm_test_generisch_short.csv'
#oemof_test = directory + 'oemof_dsm_test_generisch_longer.csv'
input_urbs = './Input/input_new.csv'
filename_data = os.path.join(os.path.dirname(__file__), oemof_test)

data = pd.read_csv(filename_data, sep=",", encoding='utf-8')

# Data manipulation
data = data * 1e2

# Timesteps
timesteps = 25

# Create & Solve Model
model = create_model(data, timesteps)

# Get Results
es = solph.EnergySystem()
es.restore(dpath=None, filename=None)


# Plot
df_result = extract_results(model, timesteps, data)


# Show Output Data
'''
DSMup = positiv, additional load is called from the grid  -> total demand rises
DSMdo = positiv, less load is called from the grid -> total demand  drops 
'''



print('-----------------------------------------------------')
print('OBJ: ', model.objective())


print('-----------------------------------------------------')
#print(df_result[ (('pp_coal_2', 'bus_elec'), 'flow') ])
#print('-----------------------------------------------------')
#print(df_result[ (('bus_elec', 'demand_dsm'), 'flow') ])
#print('-----------------------------------------------------')
#print(df_result[ (('pv', 'bus_elec'), 'flow') ])
#print('-----------------------------------------------------')
#print(df_result[ (('wind', 'bus_elec'), 'flow') ])
print('-----------------------------------------------------')
print(df_result[['dsm_up', 'dsm_do', 'dsm_tot', 'dsm' ]] )

print('------------------TOTAL------------------------')
print('DSMup')
print(df_result['dsm_up'].sum())
print('DSMdown')
print(df_result['dsm_do'].sum())

#import pdb;    pdb.set_trace()


