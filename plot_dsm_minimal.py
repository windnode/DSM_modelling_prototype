from oemof import outputlib

import pandas as pd
import os

import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import matplotlib.ticker as ticker

from pandas.plotting import register_matplotlib_converters

# register matplotlib converters which have been overwritten by pandas
register_matplotlib_converters()


#################################################################
#                       Directory Creator

def make_directory(folder_name, **kwargs):
    """"
    Parameters
    ------------
    folder_name: str, Name of the folder to be created

    Info
    ------------
    checks whether fold_name already exist. If not, it is created in the current directory.
    """
    subfolder_name = kwargs.get('subfolder_name', False)

    existing_folders = next(os.walk('.'))[1]
    if folder_name in existing_folders:
        print('----------------------------------------------------------')
        print('Folder "' + folder_name + '" already exists in current directory.')
        print('----------------------------------------------------------')
    else:
        path = "./" + folder_name
        os.mkdir(path)
        print('----------------------------------------------------------')
        print('Created folder "' + folder_name + '" in current directory.')
        print('----------------------------------------------------------')

    if isinstance(subfolder_name, str):
        existing_folders = next(os.walk('./' + folder_name))[1]
        if subfolder_name in existing_folders:
            print('----------------------------------------------------------')
            print('Subfolder "' + subfolder_name + '" already exists in ./' + folder_name + '.')
            print('----------------------------------------------------------')
        else:
            path = "./" + folder_name
            os.mkdir(path)
            print('----------------------------------------------------------')
            print('Created subfolder "' + subfolder_name + '" in ./' + folder_name + '.')
            print('----------------------------------------------------------')
    elif ~isinstance(subfolder_name, bool):
        print('Keyword subfolder_name is no valid str!')


#                       Output Graph

def adjust_yaxis(ax, ydif, v):
    """shift axis ax by ydiff, maintaining point v at the same location"""
    inv = ax.transData.inverted()
    _, dy = inv.transform((0, 0)) - inv.transform((0, ydif))
    miny, maxy = ax.get_ylim()
    miny, maxy = miny - v, maxy - v
    if -miny > maxy or (-miny == maxy and dy > 0):
        nminy = miny
        nmaxy = miny * (maxy + dy) / (miny + dy)
    else:
        nmaxy = maxy
        nminy = maxy * (miny + dy) / (maxy + dy)
    ax.set_ylim(nminy + v, nmaxy + v)


def align_yaxis(ax1, v1, ax2, v2):
    """adjust ax2 ylimit so that v2 in ax2 is aligned to v1 in ax1"""
    _, y1 = ax1.transData.transform((0, v1))
    _, y2 = ax2.transData.transform((0, v2))
    adjust_yaxis(ax2, (y1 - y2) / 2, v2)
    adjust_yaxis(ax1, (y2 - y1) / 2, v1)


def extract_results(model, data, datetimeindex, directory):
    '''Extract data fro Pyomo Variables in DataFrames and plot for visualization'''

    # ########################### Get DataFrame out of Pyomo and rename series

    # Generators coal
    df_grid = outputlib.views.node(model.es.results['main'], 'Electricity bus')['sequences'][
        (('Grid', 'Electricity bus'), 'flow')]
    df_grid.rename('grid', inplace=True)

    # Generators RE
    df_wind = outputlib.views.node(model.es.results['main'], 'Electricity bus')['sequences'][
        (('wind', 'Electricity bus'), 'flow')]
    df_wind.rename('wind', inplace=True)

    # DSM Demand
    df_demand_dsm = outputlib.views.node(model.es.results['main'], 'Electricity bus')['sequences'][
        (('Electricity bus', 'DSM'), 'flow')]
    df_demand_dsm.rename('DSM', inplace=True)

    # DSM Variables
    df_dsmdo = outputlib.views.node(model.es.results['main'], 'DSM')['sequences'].iloc[:, 1:-1].sum(axis=1)
    df_dsmdo.rename('dsm_do', inplace=True)

    df_dsmup = outputlib.views.node(model.es.results['main'], 'DSM')['sequences'].iloc[:, -1]
    df_dsmup.rename('dsm_up', inplace=True)

    df_dsm_tot = df_dsmdo - df_dsmup
    df_dsm_tot.rename('dsm_tot', inplace=True)

    # ###################### from input DATA ####################

    # Demand from input
    demand = data.demand_el[datetimeindex].values

    # Capacity from input
    dsm_capup = data.Cap_up[datetimeindex].values
    dsm_capdo = data.Cap_do[datetimeindex].values

    ######## Merge in one DataFrame
    df_gesamt = pd.concat([df_grid, df_wind,
                           df_demand_dsm, df_dsmdo, df_dsmup, df_dsm_tot,
                           data.demand_el[datetimeindex].rename('demand_el'),
                           data.Cap_up[datetimeindex].rename('Cap_up'),
                           data.Cap_do[datetimeindex].rename('Cap_do')], axis=1)



    # write Data in Csv
    df_gesamt.to_csv(directory + '/DSM_component_data.csv')

    return df_gesamt


def plot(df_gesamt, datetimeindex, directory, timesteps, project):

    # ############ DATA PREPARATION FOR FIGURE #############################

    # ########################################### create Figure
    for info, slice in df_gesamt.resample('D'):
        # Generators from model
        # hierarchy for plot: coal1, coal2, wind, pv, shortage
        # graph_wind = graph_grid + slice.wind.values
        graph_pv = slice.wind.values
        graph_grid = graph_pv + slice.grid.values


        #################
        # first axis
        fig, ax1 = plt.subplots()
        # ax1.set_ylim([0, 30])

        # x-Axis date format
        ax1.xaxis_date()
        ax1.xaxis.set_major_formatter(mdates.DateFormatter('%H h'))  # ('%d.%m-%H h'))
        ax1.set_xlim(info - pd.Timedelta(0, 'h'), info + pd.Timedelta(timesteps - 1, 'h'))
        ax1.set_ylim(0, max(graph_pv) * 1.1)
        plt.xticks(pd.date_range(start=info._date_repr, periods=timesteps, freq='H'), rotation=45)

        # Demands
        # ax1.plot(range(timesteps), dsm, label='demand_DSM', color='black')
        ax1.step(slice.index, slice.demand_el.values, where='post', label='Demand', linestyle='--', color='blue')
        ax1.step(slice.index, slice.DSM.values, where='post', label='Demand after DSM', color='black')

        # DSM Capacity
        # ax1.plot(range(timesteps), demand + dsm_capup, label='Cup', color='black', linestyle='--')
        # ax1.plot(range(timesteps), demand - dsm_capdo, label='Cdo', color='black', linestyle='--')

        # Generators
        # ax1.fill_between(range(timesteps), 0, shortage, step='post', label='Shortage', facecolor='grey', alpha=0.5)
        # ax1.fill_between(range(timesteps), shortage, wind, step='post', label='Wind', facecolor='darkcyan', alpha=0.5)

        ax1.fill_between(slice.index, 0, graph_pv, step='post', label='PV', facecolor='gold', alpha=0.5)
        ax1.fill_between(slice.index, graph_pv, graph_grid, step='post', label='Grid', facecolor='black', alpha=0.5)


        # DSM cumsum
        # ax1.step(datetimeindex, df_gesamt.dsm_up.cumsum().values, where='post', label='dsm_hold', linestyle='--', color='green')

        # Legend axis 1
        # handles, labels = ax1.get_legend_handles_labels()
        # handles = [handles[0], handles[1], handles[3], handles[4], handles[2], handles[5], handles[6]]#, handles[7] ]
        # labels = [labels[0], labels[1], labels[3], labels[4], labels[2], labels[5], labels[6]]#,labels[7]  ]
        # ax1.legend(handles, labels, bbox_to_anchor=(0., 1.02, 1., .102), loc=3, ncol=4, mode="expand", borderaxespad=0.)
        ax1.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3, ncol=4, mode="expand", borderaxespad=0.)

        # plt.xticks(range(0,timesteps,5))

        # plt.grid()

        '''
        ###########################
        # Second axis
        ax2 = ax1.twinx()
        ax2.set_ylim([-1, 1])
        align_yaxis(ax1, 1, ax2, 0)


        # DSM up/down
        ax2.step(datetimeindex, -df_gesamt_dsmdo.values, where='post', label='DSM down',  alpha=0.5, color='red')
        ax2.step(datetimeindex, df_gesamt.dsmup.values, where='post', label='DSM up', alpha=0.5, color='green')
        #ax2.bar(range(timesteps), -df_gesamt.dsmtot.values, label='DSM up/down',  alpha=0.5, color='firebrick')

        # DSM Capacity
        #ax2.plot(range(timesteps), df_gesamt.Cap_up.values, label='Capacity DSM up/down', color='red', linestyle='--')
        #ax2.plot(range(timesteps), - df_gesamt.Cap_do.values, color='red', linestyle='--')

        # Deman +- Capacity
        #ax2.plot(range(timesteps), demand + dsm_capup, label='Cup', color='red', linestyle='--')
        #ax2.plot(range(timesteps), demand - dsm_capdo, label='Cdo', color='red', linestyle='--')

        # Legend axis 2
        ax2.legend(bbox_to_anchor=(0., -0.3, 1., 0.102), loc=3, ncol=3,  borderaxespad=0., mode="expand")
        ax1.set_xlabel('Time t in h')
        ax1.set_ylabel('MW')
        ax2.set_ylabel('MW')

        #ax2.grid()

        #'''

        fig.set_tight_layout(True)
        name = 'Plot_' + project + '_' + info._date_repr + '.svg'
        fig.savefig(os.path.join(directory, 'Grafiken', name), bbox_inches='tight')
        plt.close()
        print(name + ' saved.')

        """
        #################
        # first axis
        fig, ax1 = plt.subplots()
        # ax1.set_ylim([0, 30])
        ax1.xaxis_date()
        ax1.xaxis.set_major_formatter(mdates.DateFormatter('%H h'))#('%d.%m-%H h'))
        plt.xticks(datetimeindex, rotation=45)

        # Date formater
        # ax1.xaxis.set_major_locator(dates.DateFormatter('%d'))
        # ax1.xaxis.set_major_formatter(dates.DateFormatter('%d'))

        # Demands
        # ax1.plot(range(timesteps), dsm, label='demand_DSM', color='black')
        ax1.step(datetimeindex, df_gesamt.demand_el.values, where='post', label='Demand', linestyle='--', color='blue')
        ax1.step(datetimeindex, df_gesamt.demand_dsm.values, where='post', label='Demand after DSM', color='black')

        # DSM Capacity
        # ax1.plot(range(timesteps), demand + dsm_capup, label='Cup', color='black', linestyle='--')
        # ax1.plot(range(timesteps), demand - dsm_capdo, label='Cdo', color='black', linestyle='--')


        # Generators
        # ax1.fill_between(range(timesteps), 0, shortage, step='post', label='Shortage', facecolor='grey', alpha=0.5)
        # ax1.fill_between(range(timesteps), shortage, wind, step='post', label='Wind', facecolor='darkcyan', alpha=0.5)

        ax1.fill_between(datetimeindex, 0, graph_coal1, step='post', label='Coal_1', facecolor='black', alpha=0.5)
        ax1.fill_between(datetimeindex, graph_coal1, graph_coal2, step='post', label='Coal_2', facecolor='grey', alpha=0.5)
        ax1.fill_between(datetimeindex, graph_coal2, graph_wind, step='post', label='Wind', facecolor='darkcyan', alpha=0.5)
        ax1.fill_between(datetimeindex, graph_wind, graph_pv, step='post', label='PV', facecolor='gold', alpha=0.5)
        # ax1.fill_between(range(timesteps), graph_pv, graph_shortage, label='Shortage', facecolor='red', alpha=0.5)

        # Excess
        #ax1.step(datetimeindex, excess, where='post', label='Excess', linestyle='--', color='green')
        ax1.fill_between(datetimeindex, df_gesamt.demand_dsm.values, graph_pv, step='post', label='Excess', facecolor='firebrick', alpha=0.5)

        # DSM cumsum
        #ax1.step(datetimeindex, df_gesamt.dsm_up.cumsum().values, where='post', label='dsm_hold', linestyle='--', color='green')

        # Legend axis 1
        #handles, labels = ax1.get_legend_handles_labels()
        #handles = [handles[0], handles[1], handles[3], handles[4], handles[2], handles[5], handles[6]]#, handles[7] ]
        #labels = [labels[0], labels[1], labels[3], labels[4], labels[2], labels[5], labels[6]]#,labels[7]  ]
        #ax1.legend(handles, labels, bbox_to_anchor=(0., 1.02, 1., .102), loc=3, ncol=4, mode="expand", borderaxespad=0.)
        ax1.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3, ncol=4, mode="expand", borderaxespad=0.)

        # plt.xticks(range(0,timesteps,5))

        plt.grid()

        '''
        ###########################
        # Second axis
        ax2 = ax1.twinx()
        ax2.set_ylim([-1, 1])
        align_yaxis(ax1, 1, ax2, 0)
    
    
        # DSM up/down
        ax2.step(datetimeindex, -df_gesamt_dsmdo.values, where='post', label='DSM down',  alpha=0.5, color='red')
        ax2.step(datetimeindex, df_gesamt.dsmup.values, where='post', label='DSM up', alpha=0.5, color='green')
        #ax2.bar(range(timesteps), -df_gesamt.dsmtot.values, label='DSM up/down',  alpha=0.5, color='firebrick')
    
        # DSM Capacity
        #ax2.plot(range(timesteps), df_gesamt.Cap_up.values, label='Capacity DSM up/down', color='red', linestyle='--')
        #ax2.plot(range(timesteps), - df_gesamt.Cap_do.values, color='red', linestyle='--')
    
        # Deman +- Capacity
        #ax2.plot(range(timesteps), demand + dsm_capup, label='Cup', color='red', linestyle='--')
        #ax2.plot(range(timesteps), demand - dsm_capdo, label='Cdo', color='red', linestyle='--')
    
        # Legend axis 2
        ax2.legend(bbox_to_anchor=(0., -0.3, 1., 0.102), loc=3, ncol=3,  borderaxespad=0., mode="expand")
        ax1.set_xlabel('Time t in h')
        ax1.set_ylabel('MW')
        ax2.set_ylabel('MW')
    
        #ax2.grid()
    
        #'''
        fig.set_tight_layout(True)
        fig.savefig(directory + 'Grafiken/abw_dsm_test.png')

        """