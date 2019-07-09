from pyomo.core import (ConcreteModel, RangeSet, Var, Constraint, Objective,
						NonNegativeReals, summation, minimize)
from pyomo.opt.base import SolverFactory
import pyomo.environ as pyo
import math
import os
import pandas as pd
import matplotlib.pyplot as plt


##########


def create_model(df_data, timesteps):

	m = ConcreteModel()

	# I defined "t" and "T" from 1 to 30
	# L = 3, Cdo & Cup = 10, also from paper
	# n and R = 1, no idea about the real values of these parameters.
	# All variables and letters are the same with the ones in paper.

	m.tm = RangeSet(1,timesteps+1,1) # TimePeriod  (Hours)
	m.Tm = RangeSet(1,timesteps+1,1) # TimePeriod (Hours)(in paper tt)

	m.L = 3 # Delay Time (Hours)
	m.n = 1	# Zerrahn Parameter eta (---)
	m.R = 1	# Zerrahn Parameter Recovery (Hours)

	m.Cdo = 40 # Zerrahn Parameter DSM Capacity down (MWh) -> Demand-shift up
	m.Cup = 40 # Zerrahn Parameter DSM Capacity up(MWh) -> Demand-shift down

	m.DSMdo = Var(m.tm, m.Tm, initialize=0, within=NonNegativeReals)	# Zerrahn Variable load shift down (MWh)
	m.DSMup = Var(m.tm, initialize=0, within=NonNegativeReals)          # Zerrahn Variable load shift up(MWh)

	#################### For OBJECTIVE

	#m.Demand = [80,80,80,80,80,80,80,120,120,120,120,120,120,130,130,120,120,120,120,120,120,80,80,80,80,80,80,80,80,80, 80] #Demand

	#m.Demand = [80,80,80,80,80,80,80,120,120,120,120,120,120,120,120,120,120,120,120,120,120,80,80,80,80,80,80,80,80,80]

	factor_demand = 200
	temp = df_data.demand_el[:timesteps + 1] * factor_demand
	m.Demand = temp.tolist()  # Demand from input_data

	m.C = [0, 10, 20, 40]  # Cost constant of all Power Generators, P1, P2, P3, ...

	m.Cap = [100, 50, 70, 70]  # Capacity of all Generators Wind/PV, P1, P2, P3, ...

	m.Wind = (df_data.wind * m.Cap[0]).round().tolist()
	m.PV = (df_data.pv * m.Cap[0]).round().tolist()

	m.P1 = Var(m.tm, initialize=0, within=NonNegativeReals) # Power Generator 1 (cheap)
	m.P2 = Var(m.tm, initialize=0, within=NonNegativeReals) # Power Generator 2 (expensive)
	m.P3 = Var(m.tm, initialize=0, within=NonNegativeReals) # Power Gen Backup (super expensive)
	#m.Wind = Var(m.tm, initialize=0, within=NonNegativeReals)




	return m


###############################################################################
#                                  ZERRAHN CONSTRAINTS

def dsmupdo_constraint_rule(m, t):

	# Equation 7'
	# Eq. 7 and 7' is the same, only one difference, which is "efficiency factor n".
	# m.n == efficiency factor set to "n=1"
	if t <= m.L:
		return sum(m.DSMdo[t, T] for T in range(1, t+1+m.L)) \
			== m.DSMup[t] * m.n

	elif m.L+1 <= t <= timesteps - m.L: # and t <= timesteps - m.L:
		return sum(m.DSMdo[t, T] for T in range(t-m.L, t+1+m.L)) \
			== m.DSMup[t] * m.n

	else:
		return sum(m.DSMdo[t, T] for T in range(t-m.L, timesteps+2)) \
			== m.DSMup[t] * m.n


def dsmup_constraint_rule(m, t):

	# Equation 8

	return m.DSMup[t] <= m.Cup


def dsmdo_constraint_rule(m, T):

	# Equation 9
	if T <= m.L:
		return sum(m.DSMdo[t, T] for t in range(1, T+1+m.L)) \
			<= m.Cdo

	elif m.L+1 <= T <= timesteps+1 - m.L:
		return sum(m.DSMdo[t, T] for t in range(T-m.L, T+1+m.L)) \
			<= m.Cdo

	else:
		return sum(m.DSMdo[t, T] for t in range(T-m.L, timesteps+2)) \
			<= m.Cdo


def C2_constraint_rule(m, T):

	# Equation 10
	if T <= m.L:
		return max(m.Cup, m.Cdo) \
			>= m.DSMup[T] + sum(m.DSMdo[t, T] for t in range(1, T+1+m.L))

	elif m.L+1 <= T <= timesteps - m.L:
		return max(m.Cup, m.Cdo) \
			>= m.DSMup[T] + sum(m.DSMdo[t, T] for t in range(T-m.L, T+1+m.L))

	else:
		return max(m.Cup, m.Cdo) \
			>= m.DSMup[T] + sum(m.DSMdo[t, T] for t in range(T-m.L, timesteps+2))


def dsmup2_constraint_rule(m, t):

	# Equation 11
	if t + m.R <= timesteps+2:
		return sum(m.DSMup[t] for t in range(t, t+m.R)) \
			<= m.Cup * m.L
	else:
		return sum(m.DSMup[t] for t in range(t, timesteps+2)) \
			<= m.Cup * m.L


####################################################################################
#                             DEMAND CONSTRAINTS


def demand_constraint_rule(m, t):

	if t <= m.L:
		return m.P1[t] + m.P2[t] + m.P3[t] \
			>= m.Demand[t-1] + m.DSMup[t] - sum(m.DSMdo[T, t] for T in range(1, t+m.L+1))

	elif m.L+1 <= t <= timesteps+1 - m.L:
		return m.P1[t] + m.P2[t] + m.P3[t] \
			>= m.Demand[t-1] + m.DSMup[t] - sum(m.DSMdo[T, t] for T in range(t-m.L, t+1+m.L))

	else:
		return m.P1[t] + m.P2[t] + m.P3[t] \
			>= m.Demand[t-1] + m.DSMup[t] - sum(m.DSMdo[T, t] for T in range(t-m.L, timesteps+2))


def power1_constraint_rule(m, t):

	return m.P1[t] <= m.Cap[1]


def power2_constraint_rule(m, t):

	return m.P2[t] <= m.Cap[2]


def power3_constraint_rule(m, t):

	return m.P3[t] <= m.Cap[3]

'''
def powerWind_constraint_rule(m, t, data):

	return m.Wind[t] == m.CapWind * data.wind[t]
'''
###############################################################################
#                                  OBJECTIVE

def obj_expression_cost(m):

	return summation(m.P1) * m.C[1] + summation(m.P2) * m.C[2] + summation(m.P3) * m.C[3]


#########################################################################
# 					EXTRA OBJECTIVES TRIES
'''
def obj_expression_cost_dsm(m):

	return summation(m.P1) * m.C[0] + summation(m.P2) * m.C[1] + summation(m.DSMup) * m.C[2] + summation(m.DSMdo) * m.C[2]


def obj_expression_demand(m):

	return summation(m.P1) + summation(m.P2) - summation(m.DSMup) + summation(m.DSMdo)

'''
##############################################################################
# 									HELP PRINT


def align_yaxis(ax1, v1, ax2, v2):
	"""adjust ax2 ylimit so that v2 in ax2 is aligned to v1 in ax1"""
	_, y1 = ax1.transData.transform((0, v1))
	_, y2 = ax2.transData.transform((0, v2))
	adjust_yaxis(ax2, (y1 - y2) / 2, v2)
	adjust_yaxis(ax1, (y2 - y1) / 2, v1)


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


def output(m):

	# extract data from pyomo variables

	output_DSMdo = []
	output_DSMup = []
	output_P1 = []
	output_P2 = []
	output_P3 = []
	output_delay = []

	# Pyomo Var index do start with 1
	for i in range(1, timesteps+2):

		output_DSMup.append(m.DSMup[i].value)
		output_P1.append(m.P1[i].value)
		output_P2.append(m.P2[i].value)
		output_P3.append(m.P3[i].value)

		test_num = 0

		for ii in range(1, timesteps+2):

			test_num += m.DSMdo[ii, i].value

		output_DSMdo.append(test_num)
		output_delay.append(- sum(output_DSMup) + sum(output_DSMdo))

	# create DataFrame

	df = pd.DataFrame()
	df['Demand'] = pd.Series(m.Demand).round()
	df['P1'] = pd.Series(output_P1).round()
	df['P2'] = pd.Series(output_P2).round()
	df['P3'] = pd.Series(output_P3).round()
	df['DSM_tot'] = (pd.Series(output_DSMup) - pd.Series(output_DSMdo)).round()
	df['DSMdo'] = pd.Series(output_DSMdo).round()
	df['DSMup'] = pd.Series(output_DSMup).round()
	df['DSM_delayed'] = pd.Series(output_delay).round()

	# create Plot

	fig, ax1 = plt.subplots()

	# Demands

	ax1.plot(df.Demand[:timesteps], label='Demand', linestyle='--')

	# Demands +- DSM

	ax1.plot(df.Demand[:timesteps] + df.DSM_tot, label='new_Demand')#, linestyle='--')

	# Generation

	plt.fill_between(range(timesteps+1), 0, df.P1, alpha=0.5,  label='P1', color='black')
	plt.fill_between(range(timesteps+1), df.P1, df.P2+df.P1, alpha=0.5,  label='P2' , color='grey')
	plt.fill_between(range(timesteps + 1), df.P1+df.P2, df.P1 + df.P2 + df.P3, alpha=0.5, label='P3', color='brown')


	# DSM work

	#plt.fill_between(range(timesteps+1), df.P3 + df.P2 + df.P1, df.P3 + df.P2 + df.P1 + df.DSM_tot, alpha=0.5,  label='DSM', color='yellow')
	plt.fill_between(range(timesteps+1), df.Demand, df.Demand + df.DSM_tot, alpha=0.5,  label='DSM', color='yellow')

	plt.yticks(range(0, round(max(df.Demand) * 1.1), 10))


	plt.grid()

	# 2nc scale

	ax2 = ax1.twinx()


	# DSM only

	ax2.bar(range(timesteps+1),  df.DSM_delayed, alpha=0.5, color='green', label='DSM_delayed')
	ax2.bar(range(timesteps+1), df.DSM_tot, alpha=0.5, color='yellow')

	fig.legend(loc=9, ncol=4)
	align_yaxis(ax1,60, ax2,0)
	#plt.grid()

	fig.savefig('DSM.png', bbox_inches='tight')

	return print(df)


####################################################
# 				CREATE MODEL

# START

df_data = pd.read_csv('input_data.csv', sep = ",")

timesteps = 120


m = create_model(df_data, timesteps)


# Constraints

# Demand
m.demandConstraint = Constraint(m.tm, rule=demand_constraint_rule)


# Equation 7'
m.dsmupdoConstraint = Constraint(m.tm, rule=dsmupdo_constraint_rule)
# Equation 8
m.dsmupConstraint = Constraint(m.tm, rule=dsmup_constraint_rule)
# Equation 9
m.dsmdoConstraint = Constraint(m.Tm, rule=dsmdo_constraint_rule)
# Equation 10
m.C2Constraint = Constraint(m.Tm, rule=C2_constraint_rule)
# Equation 11
m.dsmup2Constraint = Constraint(m.tm, rule=dsmup2_constraint_rule)

# Power
m.power1Constraint = Constraint(m.tm, rule=power1_constraint_rule)
m.power2Constraint = Constraint(m.tm, rule=power2_constraint_rule)
m.power3Constraint = Constraint(m.tm, rule=power3_constraint_rule)

#m.powerWindConstraint = Constraint(m.tm, rule=powerWind_constraint_rule)

# Objective

m.obj = Objective(rule=obj_expression_cost, sense=minimize)


###############################################################################
#                                    SOLVE
# solve model and read results


optim = SolverFactory('cbc')
result = optim.solve(m, tee=False)

# Check obj or var example
print('Objective:', m.obj())


output(m)


filename = os.path.join(os.path.dirname(__file__), 'model.lp')
m.write(filename, io_options={'symbolic_solver_labels': True})

#import pdb;    pdb.set_trace()
