\* Source Pyomo model name=Model *\

min 
objective:
+200 flow(shortage_el_bus_elec_0)
+200 flow(shortage_el_bus_elec_1)
+200 flow(shortage_el_bus_elec_10)
+200 flow(shortage_el_bus_elec_11)
+200 flow(shortage_el_bus_elec_12)
+200 flow(shortage_el_bus_elec_13)
+200 flow(shortage_el_bus_elec_14)
+200 flow(shortage_el_bus_elec_15)
+200 flow(shortage_el_bus_elec_16)
+200 flow(shortage_el_bus_elec_17)
+200 flow(shortage_el_bus_elec_18)
+200 flow(shortage_el_bus_elec_19)
+200 flow(shortage_el_bus_elec_2)
+200 flow(shortage_el_bus_elec_20)
+200 flow(shortage_el_bus_elec_21)
+200 flow(shortage_el_bus_elec_22)
+200 flow(shortage_el_bus_elec_23)
+200 flow(shortage_el_bus_elec_24)
+200 flow(shortage_el_bus_elec_3)
+200 flow(shortage_el_bus_elec_4)
+200 flow(shortage_el_bus_elec_5)
+200 flow(shortage_el_bus_elec_6)
+200 flow(shortage_el_bus_elec_7)
+200 flow(shortage_el_bus_elec_8)
+200 flow(shortage_el_bus_elec_9)
+10 flow(source_coal_p1_bus_coal_1_0)
+10 flow(source_coal_p1_bus_coal_1_1)
+10 flow(source_coal_p1_bus_coal_1_10)
+10 flow(source_coal_p1_bus_coal_1_11)
+10 flow(source_coal_p1_bus_coal_1_12)
+10 flow(source_coal_p1_bus_coal_1_13)
+10 flow(source_coal_p1_bus_coal_1_14)
+10 flow(source_coal_p1_bus_coal_1_15)
+10 flow(source_coal_p1_bus_coal_1_16)
+10 flow(source_coal_p1_bus_coal_1_17)
+10 flow(source_coal_p1_bus_coal_1_18)
+10 flow(source_coal_p1_bus_coal_1_19)
+10 flow(source_coal_p1_bus_coal_1_2)
+10 flow(source_coal_p1_bus_coal_1_20)
+10 flow(source_coal_p1_bus_coal_1_21)
+10 flow(source_coal_p1_bus_coal_1_22)
+10 flow(source_coal_p1_bus_coal_1_23)
+10 flow(source_coal_p1_bus_coal_1_24)
+10 flow(source_coal_p1_bus_coal_1_3)
+10 flow(source_coal_p1_bus_coal_1_4)
+10 flow(source_coal_p1_bus_coal_1_5)
+10 flow(source_coal_p1_bus_coal_1_6)
+10 flow(source_coal_p1_bus_coal_1_7)
+10 flow(source_coal_p1_bus_coal_1_8)
+10 flow(source_coal_p1_bus_coal_1_9)
+20 flow(source_coal_p2_bus_coal_2_0)
+20 flow(source_coal_p2_bus_coal_2_1)
+20 flow(source_coal_p2_bus_coal_2_10)
+20 flow(source_coal_p2_bus_coal_2_11)
+20 flow(source_coal_p2_bus_coal_2_12)
+20 flow(source_coal_p2_bus_coal_2_13)
+20 flow(source_coal_p2_bus_coal_2_14)
+20 flow(source_coal_p2_bus_coal_2_15)
+20 flow(source_coal_p2_bus_coal_2_16)
+20 flow(source_coal_p2_bus_coal_2_17)
+20 flow(source_coal_p2_bus_coal_2_18)
+20 flow(source_coal_p2_bus_coal_2_19)
+20 flow(source_coal_p2_bus_coal_2_2)
+20 flow(source_coal_p2_bus_coal_2_20)
+20 flow(source_coal_p2_bus_coal_2_21)
+20 flow(source_coal_p2_bus_coal_2_22)
+20 flow(source_coal_p2_bus_coal_2_23)
+20 flow(source_coal_p2_bus_coal_2_24)
+20 flow(source_coal_p2_bus_coal_2_3)
+20 flow(source_coal_p2_bus_coal_2_4)
+20 flow(source_coal_p2_bus_coal_2_5)
+20 flow(source_coal_p2_bus_coal_2_6)
+20 flow(source_coal_p2_bus_coal_2_7)
+20 flow(source_coal_p2_bus_coal_2_8)
+20 flow(source_coal_p2_bus_coal_2_9)

s.t.

c_e_Bus_balance(bus_coal_1_0)_:
-1 flow(bus_coal_1_pp_coal_1_0)
+1 flow(source_coal_p1_bus_coal_1_0)
= 0

c_e_Bus_balance(bus_coal_1_1)_:
-1 flow(bus_coal_1_pp_coal_1_1)
+1 flow(source_coal_p1_bus_coal_1_1)
= 0

c_e_Bus_balance(bus_coal_1_2)_:
-1 flow(bus_coal_1_pp_coal_1_2)
+1 flow(source_coal_p1_bus_coal_1_2)
= 0

c_e_Bus_balance(bus_coal_1_3)_:
-1 flow(bus_coal_1_pp_coal_1_3)
+1 flow(source_coal_p1_bus_coal_1_3)
= 0

c_e_Bus_balance(bus_coal_1_4)_:
-1 flow(bus_coal_1_pp_coal_1_4)
+1 flow(source_coal_p1_bus_coal_1_4)
= 0

c_e_Bus_balance(bus_coal_1_5)_:
-1 flow(bus_coal_1_pp_coal_1_5)
+1 flow(source_coal_p1_bus_coal_1_5)
= 0

c_e_Bus_balance(bus_coal_1_6)_:
-1 flow(bus_coal_1_pp_coal_1_6)
+1 flow(source_coal_p1_bus_coal_1_6)
= 0

c_e_Bus_balance(bus_coal_1_7)_:
-1 flow(bus_coal_1_pp_coal_1_7)
+1 flow(source_coal_p1_bus_coal_1_7)
= 0

c_e_Bus_balance(bus_coal_1_8)_:
-1 flow(bus_coal_1_pp_coal_1_8)
+1 flow(source_coal_p1_bus_coal_1_8)
= 0

c_e_Bus_balance(bus_coal_1_9)_:
-1 flow(bus_coal_1_pp_coal_1_9)
+1 flow(source_coal_p1_bus_coal_1_9)
= 0

c_e_Bus_balance(bus_coal_1_10)_:
-1 flow(bus_coal_1_pp_coal_1_10)
+1 flow(source_coal_p1_bus_coal_1_10)
= 0

c_e_Bus_balance(bus_coal_1_11)_:
-1 flow(bus_coal_1_pp_coal_1_11)
+1 flow(source_coal_p1_bus_coal_1_11)
= 0

c_e_Bus_balance(bus_coal_1_12)_:
-1 flow(bus_coal_1_pp_coal_1_12)
+1 flow(source_coal_p1_bus_coal_1_12)
= 0

c_e_Bus_balance(bus_coal_1_13)_:
-1 flow(bus_coal_1_pp_coal_1_13)
+1 flow(source_coal_p1_bus_coal_1_13)
= 0

c_e_Bus_balance(bus_coal_1_14)_:
-1 flow(bus_coal_1_pp_coal_1_14)
+1 flow(source_coal_p1_bus_coal_1_14)
= 0

c_e_Bus_balance(bus_coal_1_15)_:
-1 flow(bus_coal_1_pp_coal_1_15)
+1 flow(source_coal_p1_bus_coal_1_15)
= 0

c_e_Bus_balance(bus_coal_1_16)_:
-1 flow(bus_coal_1_pp_coal_1_16)
+1 flow(source_coal_p1_bus_coal_1_16)
= 0

c_e_Bus_balance(bus_coal_1_17)_:
-1 flow(bus_coal_1_pp_coal_1_17)
+1 flow(source_coal_p1_bus_coal_1_17)
= 0

c_e_Bus_balance(bus_coal_1_18)_:
-1 flow(bus_coal_1_pp_coal_1_18)
+1 flow(source_coal_p1_bus_coal_1_18)
= 0

c_e_Bus_balance(bus_coal_1_19)_:
-1 flow(bus_coal_1_pp_coal_1_19)
+1 flow(source_coal_p1_bus_coal_1_19)
= 0

c_e_Bus_balance(bus_coal_1_20)_:
-1 flow(bus_coal_1_pp_coal_1_20)
+1 flow(source_coal_p1_bus_coal_1_20)
= 0

c_e_Bus_balance(bus_coal_1_21)_:
-1 flow(bus_coal_1_pp_coal_1_21)
+1 flow(source_coal_p1_bus_coal_1_21)
= 0

c_e_Bus_balance(bus_coal_1_22)_:
-1 flow(bus_coal_1_pp_coal_1_22)
+1 flow(source_coal_p1_bus_coal_1_22)
= 0

c_e_Bus_balance(bus_coal_1_23)_:
-1 flow(bus_coal_1_pp_coal_1_23)
+1 flow(source_coal_p1_bus_coal_1_23)
= 0

c_e_Bus_balance(bus_coal_1_24)_:
-1 flow(bus_coal_1_pp_coal_1_24)
+1 flow(source_coal_p1_bus_coal_1_24)
= 0

c_e_Bus_balance(bus_coal_2_0)_:
-1 flow(bus_coal_2_pp_coal_2_0)
+1 flow(source_coal_p2_bus_coal_2_0)
= 0

c_e_Bus_balance(bus_coal_2_1)_:
-1 flow(bus_coal_2_pp_coal_2_1)
+1 flow(source_coal_p2_bus_coal_2_1)
= 0

c_e_Bus_balance(bus_coal_2_2)_:
-1 flow(bus_coal_2_pp_coal_2_2)
+1 flow(source_coal_p2_bus_coal_2_2)
= 0

c_e_Bus_balance(bus_coal_2_3)_:
-1 flow(bus_coal_2_pp_coal_2_3)
+1 flow(source_coal_p2_bus_coal_2_3)
= 0

c_e_Bus_balance(bus_coal_2_4)_:
-1 flow(bus_coal_2_pp_coal_2_4)
+1 flow(source_coal_p2_bus_coal_2_4)
= 0

c_e_Bus_balance(bus_coal_2_5)_:
-1 flow(bus_coal_2_pp_coal_2_5)
+1 flow(source_coal_p2_bus_coal_2_5)
= 0

c_e_Bus_balance(bus_coal_2_6)_:
-1 flow(bus_coal_2_pp_coal_2_6)
+1 flow(source_coal_p2_bus_coal_2_6)
= 0

c_e_Bus_balance(bus_coal_2_7)_:
-1 flow(bus_coal_2_pp_coal_2_7)
+1 flow(source_coal_p2_bus_coal_2_7)
= 0

c_e_Bus_balance(bus_coal_2_8)_:
-1 flow(bus_coal_2_pp_coal_2_8)
+1 flow(source_coal_p2_bus_coal_2_8)
= 0

c_e_Bus_balance(bus_coal_2_9)_:
-1 flow(bus_coal_2_pp_coal_2_9)
+1 flow(source_coal_p2_bus_coal_2_9)
= 0

c_e_Bus_balance(bus_coal_2_10)_:
-1 flow(bus_coal_2_pp_coal_2_10)
+1 flow(source_coal_p2_bus_coal_2_10)
= 0

c_e_Bus_balance(bus_coal_2_11)_:
-1 flow(bus_coal_2_pp_coal_2_11)
+1 flow(source_coal_p2_bus_coal_2_11)
= 0

c_e_Bus_balance(bus_coal_2_12)_:
-1 flow(bus_coal_2_pp_coal_2_12)
+1 flow(source_coal_p2_bus_coal_2_12)
= 0

c_e_Bus_balance(bus_coal_2_13)_:
-1 flow(bus_coal_2_pp_coal_2_13)
+1 flow(source_coal_p2_bus_coal_2_13)
= 0

c_e_Bus_balance(bus_coal_2_14)_:
-1 flow(bus_coal_2_pp_coal_2_14)
+1 flow(source_coal_p2_bus_coal_2_14)
= 0

c_e_Bus_balance(bus_coal_2_15)_:
-1 flow(bus_coal_2_pp_coal_2_15)
+1 flow(source_coal_p2_bus_coal_2_15)
= 0

c_e_Bus_balance(bus_coal_2_16)_:
-1 flow(bus_coal_2_pp_coal_2_16)
+1 flow(source_coal_p2_bus_coal_2_16)
= 0

c_e_Bus_balance(bus_coal_2_17)_:
-1 flow(bus_coal_2_pp_coal_2_17)
+1 flow(source_coal_p2_bus_coal_2_17)
= 0

c_e_Bus_balance(bus_coal_2_18)_:
-1 flow(bus_coal_2_pp_coal_2_18)
+1 flow(source_coal_p2_bus_coal_2_18)
= 0

c_e_Bus_balance(bus_coal_2_19)_:
-1 flow(bus_coal_2_pp_coal_2_19)
+1 flow(source_coal_p2_bus_coal_2_19)
= 0

c_e_Bus_balance(bus_coal_2_20)_:
-1 flow(bus_coal_2_pp_coal_2_20)
+1 flow(source_coal_p2_bus_coal_2_20)
= 0

c_e_Bus_balance(bus_coal_2_21)_:
-1 flow(bus_coal_2_pp_coal_2_21)
+1 flow(source_coal_p2_bus_coal_2_21)
= 0

c_e_Bus_balance(bus_coal_2_22)_:
-1 flow(bus_coal_2_pp_coal_2_22)
+1 flow(source_coal_p2_bus_coal_2_22)
= 0

c_e_Bus_balance(bus_coal_2_23)_:
-1 flow(bus_coal_2_pp_coal_2_23)
+1 flow(source_coal_p2_bus_coal_2_23)
= 0

c_e_Bus_balance(bus_coal_2_24)_:
-1 flow(bus_coal_2_pp_coal_2_24)
+1 flow(source_coal_p2_bus_coal_2_24)
= 0

c_e_Bus_balance(bus_elec_0)_:
-1 flow(bus_elec_demand_dsm_0)
-1 flow(bus_elec_excess_el_0)
+1 flow(pp_coal_1_bus_elec_0)
+1 flow(pp_coal_2_bus_elec_0)
+1 flow(shortage_el_bus_elec_0)
= -118

c_e_Bus_balance(bus_elec_1)_:
-1 flow(bus_elec_demand_dsm_1)
-1 flow(bus_elec_excess_el_1)
+1 flow(pp_coal_1_bus_elec_1)
+1 flow(pp_coal_2_bus_elec_1)
+1 flow(shortage_el_bus_elec_1)
= -121

c_e_Bus_balance(bus_elec_2)_:
-1 flow(bus_elec_demand_dsm_2)
-1 flow(bus_elec_excess_el_2)
+1 flow(pp_coal_1_bus_elec_2)
+1 flow(pp_coal_2_bus_elec_2)
+1 flow(shortage_el_bus_elec_2)
= -142

c_e_Bus_balance(bus_elec_3)_:
-1 flow(bus_elec_demand_dsm_3)
-1 flow(bus_elec_excess_el_3)
+1 flow(pp_coal_1_bus_elec_3)
+1 flow(pp_coal_2_bus_elec_3)
+1 flow(shortage_el_bus_elec_3)
= -149

c_e_Bus_balance(bus_elec_4)_:
-1 flow(bus_elec_demand_dsm_4)
-1 flow(bus_elec_excess_el_4)
+1 flow(pp_coal_1_bus_elec_4)
+1 flow(pp_coal_2_bus_elec_4)
+1 flow(shortage_el_bus_elec_4)
= -99

c_e_Bus_balance(bus_elec_5)_:
-1 flow(bus_elec_demand_dsm_5)
-1 flow(bus_elec_excess_el_5)
+1 flow(pp_coal_1_bus_elec_5)
+1 flow(pp_coal_2_bus_elec_5)
+1 flow(shortage_el_bus_elec_5)
= -40

c_e_Bus_balance(bus_elec_6)_:
-1 flow(bus_elec_demand_dsm_6)
-1 flow(bus_elec_excess_el_6)
+1 flow(pp_coal_1_bus_elec_6)
+1 flow(pp_coal_2_bus_elec_6)
+1 flow(shortage_el_bus_elec_6)
= -148

c_e_Bus_balance(bus_elec_7)_:
-1 flow(bus_elec_demand_dsm_7)
-1 flow(bus_elec_excess_el_7)
+1 flow(pp_coal_1_bus_elec_7)
+1 flow(pp_coal_2_bus_elec_7)
+1 flow(shortage_el_bus_elec_7)
= -69

c_e_Bus_balance(bus_elec_8)_:
-1 flow(bus_elec_demand_dsm_8)
-1 flow(bus_elec_excess_el_8)
+1 flow(pp_coal_1_bus_elec_8)
+1 flow(pp_coal_2_bus_elec_8)
+1 flow(shortage_el_bus_elec_8)
= -79

c_e_Bus_balance(bus_elec_9)_:
-1 flow(bus_elec_demand_dsm_9)
-1 flow(bus_elec_excess_el_9)
+1 flow(pp_coal_1_bus_elec_9)
+1 flow(pp_coal_2_bus_elec_9)
+1 flow(shortage_el_bus_elec_9)
= -66

c_e_Bus_balance(bus_elec_10)_:
-1 flow(bus_elec_demand_dsm_10)
-1 flow(bus_elec_excess_el_10)
+1 flow(pp_coal_1_bus_elec_10)
+1 flow(pp_coal_2_bus_elec_10)
+1 flow(shortage_el_bus_elec_10)
= -79

c_e_Bus_balance(bus_elec_11)_:
-1 flow(bus_elec_demand_dsm_11)
-1 flow(bus_elec_excess_el_11)
+1 flow(pp_coal_1_bus_elec_11)
+1 flow(pp_coal_2_bus_elec_11)
+1 flow(shortage_el_bus_elec_11)
= -120.00000000000001

c_e_Bus_balance(bus_elec_12)_:
-1 flow(bus_elec_demand_dsm_12)
-1 flow(bus_elec_excess_el_12)
+1 flow(pp_coal_1_bus_elec_12)
+1 flow(pp_coal_2_bus_elec_12)
+1 flow(shortage_el_bus_elec_12)
= -152

c_e_Bus_balance(bus_elec_13)_:
-1 flow(bus_elec_demand_dsm_13)
-1 flow(bus_elec_excess_el_13)
+1 flow(pp_coal_1_bus_elec_13)
+1 flow(pp_coal_2_bus_elec_13)
+1 flow(shortage_el_bus_elec_13)
= -126

c_e_Bus_balance(bus_elec_14)_:
-1 flow(bus_elec_demand_dsm_14)
-1 flow(bus_elec_excess_el_14)
+1 flow(pp_coal_1_bus_elec_14)
+1 flow(pp_coal_2_bus_elec_14)
+1 flow(shortage_el_bus_elec_14)
= -108

c_e_Bus_balance(bus_elec_15)_:
-1 flow(bus_elec_demand_dsm_15)
-1 flow(bus_elec_excess_el_15)
+1 flow(pp_coal_1_bus_elec_15)
+1 flow(pp_coal_2_bus_elec_15)
+1 flow(shortage_el_bus_elec_15)
= -133

c_e_Bus_balance(bus_elec_16)_:
-1 flow(bus_elec_demand_dsm_16)
-1 flow(bus_elec_excess_el_16)
+1 flow(pp_coal_1_bus_elec_16)
+1 flow(pp_coal_2_bus_elec_16)
+1 flow(shortage_el_bus_elec_16)
= -112.99999999999999

c_e_Bus_balance(bus_elec_17)_:
-1 flow(bus_elec_demand_dsm_17)
-1 flow(bus_elec_excess_el_17)
+1 flow(pp_coal_1_bus_elec_17)
+1 flow(pp_coal_2_bus_elec_17)
+1 flow(shortage_el_bus_elec_17)
= -77

c_e_Bus_balance(bus_elec_18)_:
-1 flow(bus_elec_demand_dsm_18)
-1 flow(bus_elec_excess_el_18)
+1 flow(pp_coal_1_bus_elec_18)
+1 flow(pp_coal_2_bus_elec_18)
+1 flow(shortage_el_bus_elec_18)
= -70

c_e_Bus_balance(bus_elec_19)_:
-1 flow(bus_elec_demand_dsm_19)
-1 flow(bus_elec_excess_el_19)
+1 flow(pp_coal_1_bus_elec_19)
+1 flow(pp_coal_2_bus_elec_19)
+1 flow(shortage_el_bus_elec_19)
= -64

c_e_Bus_balance(bus_elec_20)_:
-1 flow(bus_elec_demand_dsm_20)
-1 flow(bus_elec_excess_el_20)
+1 flow(pp_coal_1_bus_elec_20)
+1 flow(pp_coal_2_bus_elec_20)
+1 flow(shortage_el_bus_elec_20)
= -132

c_e_Bus_balance(bus_elec_21)_:
-1 flow(bus_elec_demand_dsm_21)
-1 flow(bus_elec_excess_el_21)
+1 flow(pp_coal_1_bus_elec_21)
+1 flow(pp_coal_2_bus_elec_21)
+1 flow(shortage_el_bus_elec_21)
= -112.00000000000001

c_e_Bus_balance(bus_elec_22)_:
-1 flow(bus_elec_demand_dsm_22)
-1 flow(bus_elec_excess_el_22)
+1 flow(pp_coal_1_bus_elec_22)
+1 flow(pp_coal_2_bus_elec_22)
+1 flow(shortage_el_bus_elec_22)
= -84

c_e_Bus_balance(bus_elec_23)_:
-1 flow(bus_elec_demand_dsm_23)
-1 flow(bus_elec_excess_el_23)
+1 flow(pp_coal_1_bus_elec_23)
+1 flow(pp_coal_2_bus_elec_23)
+1 flow(shortage_el_bus_elec_23)
= -90

c_e_Bus_balance(bus_elec_24)_:
-1 flow(bus_elec_demand_dsm_24)
-1 flow(bus_elec_excess_el_24)
+1 flow(pp_coal_1_bus_elec_24)
+1 flow(pp_coal_2_bus_elec_24)
+1 flow(shortage_el_bus_elec_24)
= -27

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_0)_:
+1 flow(bus_coal_1_pp_coal_1_0)
-1 flow(pp_coal_1_bus_elec_0)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_1)_:
+1 flow(bus_coal_1_pp_coal_1_1)
-1 flow(pp_coal_1_bus_elec_1)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_2)_:
+1 flow(bus_coal_1_pp_coal_1_2)
-1 flow(pp_coal_1_bus_elec_2)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_3)_:
+1 flow(bus_coal_1_pp_coal_1_3)
-1 flow(pp_coal_1_bus_elec_3)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_4)_:
+1 flow(bus_coal_1_pp_coal_1_4)
-1 flow(pp_coal_1_bus_elec_4)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_5)_:
+1 flow(bus_coal_1_pp_coal_1_5)
-1 flow(pp_coal_1_bus_elec_5)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_6)_:
+1 flow(bus_coal_1_pp_coal_1_6)
-1 flow(pp_coal_1_bus_elec_6)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_7)_:
+1 flow(bus_coal_1_pp_coal_1_7)
-1 flow(pp_coal_1_bus_elec_7)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_8)_:
+1 flow(bus_coal_1_pp_coal_1_8)
-1 flow(pp_coal_1_bus_elec_8)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_9)_:
+1 flow(bus_coal_1_pp_coal_1_9)
-1 flow(pp_coal_1_bus_elec_9)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_10)_:
+1 flow(bus_coal_1_pp_coal_1_10)
-1 flow(pp_coal_1_bus_elec_10)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_11)_:
+1 flow(bus_coal_1_pp_coal_1_11)
-1 flow(pp_coal_1_bus_elec_11)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_12)_:
+1 flow(bus_coal_1_pp_coal_1_12)
-1 flow(pp_coal_1_bus_elec_12)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_13)_:
+1 flow(bus_coal_1_pp_coal_1_13)
-1 flow(pp_coal_1_bus_elec_13)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_14)_:
+1 flow(bus_coal_1_pp_coal_1_14)
-1 flow(pp_coal_1_bus_elec_14)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_15)_:
+1 flow(bus_coal_1_pp_coal_1_15)
-1 flow(pp_coal_1_bus_elec_15)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_16)_:
+1 flow(bus_coal_1_pp_coal_1_16)
-1 flow(pp_coal_1_bus_elec_16)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_17)_:
+1 flow(bus_coal_1_pp_coal_1_17)
-1 flow(pp_coal_1_bus_elec_17)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_18)_:
+1 flow(bus_coal_1_pp_coal_1_18)
-1 flow(pp_coal_1_bus_elec_18)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_19)_:
+1 flow(bus_coal_1_pp_coal_1_19)
-1 flow(pp_coal_1_bus_elec_19)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_20)_:
+1 flow(bus_coal_1_pp_coal_1_20)
-1 flow(pp_coal_1_bus_elec_20)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_21)_:
+1 flow(bus_coal_1_pp_coal_1_21)
-1 flow(pp_coal_1_bus_elec_21)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_22)_:
+1 flow(bus_coal_1_pp_coal_1_22)
-1 flow(pp_coal_1_bus_elec_22)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_23)_:
+1 flow(bus_coal_1_pp_coal_1_23)
-1 flow(pp_coal_1_bus_elec_23)
= 0

c_e_Transformer_relation(pp_coal_1_bus_coal_1_bus_elec_24)_:
+1 flow(bus_coal_1_pp_coal_1_24)
-1 flow(pp_coal_1_bus_elec_24)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_0)_:
+1 flow(bus_coal_2_pp_coal_2_0)
-1 flow(pp_coal_2_bus_elec_0)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_1)_:
+1 flow(bus_coal_2_pp_coal_2_1)
-1 flow(pp_coal_2_bus_elec_1)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_2)_:
+1 flow(bus_coal_2_pp_coal_2_2)
-1 flow(pp_coal_2_bus_elec_2)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_3)_:
+1 flow(bus_coal_2_pp_coal_2_3)
-1 flow(pp_coal_2_bus_elec_3)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_4)_:
+1 flow(bus_coal_2_pp_coal_2_4)
-1 flow(pp_coal_2_bus_elec_4)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_5)_:
+1 flow(bus_coal_2_pp_coal_2_5)
-1 flow(pp_coal_2_bus_elec_5)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_6)_:
+1 flow(bus_coal_2_pp_coal_2_6)
-1 flow(pp_coal_2_bus_elec_6)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_7)_:
+1 flow(bus_coal_2_pp_coal_2_7)
-1 flow(pp_coal_2_bus_elec_7)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_8)_:
+1 flow(bus_coal_2_pp_coal_2_8)
-1 flow(pp_coal_2_bus_elec_8)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_9)_:
+1 flow(bus_coal_2_pp_coal_2_9)
-1 flow(pp_coal_2_bus_elec_9)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_10)_:
+1 flow(bus_coal_2_pp_coal_2_10)
-1 flow(pp_coal_2_bus_elec_10)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_11)_:
+1 flow(bus_coal_2_pp_coal_2_11)
-1 flow(pp_coal_2_bus_elec_11)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_12)_:
+1 flow(bus_coal_2_pp_coal_2_12)
-1 flow(pp_coal_2_bus_elec_12)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_13)_:
+1 flow(bus_coal_2_pp_coal_2_13)
-1 flow(pp_coal_2_bus_elec_13)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_14)_:
+1 flow(bus_coal_2_pp_coal_2_14)
-1 flow(pp_coal_2_bus_elec_14)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_15)_:
+1 flow(bus_coal_2_pp_coal_2_15)
-1 flow(pp_coal_2_bus_elec_15)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_16)_:
+1 flow(bus_coal_2_pp_coal_2_16)
-1 flow(pp_coal_2_bus_elec_16)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_17)_:
+1 flow(bus_coal_2_pp_coal_2_17)
-1 flow(pp_coal_2_bus_elec_17)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_18)_:
+1 flow(bus_coal_2_pp_coal_2_18)
-1 flow(pp_coal_2_bus_elec_18)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_19)_:
+1 flow(bus_coal_2_pp_coal_2_19)
-1 flow(pp_coal_2_bus_elec_19)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_20)_:
+1 flow(bus_coal_2_pp_coal_2_20)
-1 flow(pp_coal_2_bus_elec_20)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_21)_:
+1 flow(bus_coal_2_pp_coal_2_21)
-1 flow(pp_coal_2_bus_elec_21)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_22)_:
+1 flow(bus_coal_2_pp_coal_2_22)
-1 flow(pp_coal_2_bus_elec_22)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_23)_:
+1 flow(bus_coal_2_pp_coal_2_23)
-1 flow(pp_coal_2_bus_elec_23)
= 0

c_e_Transformer_relation(pp_coal_2_bus_coal_2_bus_elec_24)_:
+1 flow(bus_coal_2_pp_coal_2_24)
-1 flow(pp_coal_2_bus_elec_24)
= 0

c_e_SinkDsmBlock_input_output_relation(demand_dsm_0)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_0)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_0)
-1 SinkDsmBlock_DSMup(demand_dsm_0)
+1 flow(bus_elec_demand_dsm_0)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_1)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_1)
-1 SinkDsmBlock_DSMup(demand_dsm_1)
+1 flow(bus_elec_demand_dsm_1)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_2)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_1_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_2)
-1 SinkDsmBlock_DSMup(demand_dsm_2)
+1 flow(bus_elec_demand_dsm_2)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_3)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_2_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_3)
-1 SinkDsmBlock_DSMup(demand_dsm_3)
+1 flow(bus_elec_demand_dsm_3)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_4)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_3_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_4)
-1 SinkDsmBlock_DSMup(demand_dsm_4)
+1 flow(bus_elec_demand_dsm_4)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_5)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_4_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_5)
-1 SinkDsmBlock_DSMup(demand_dsm_5)
+1 flow(bus_elec_demand_dsm_5)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_6)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_5_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_6)
-1 SinkDsmBlock_DSMup(demand_dsm_6)
+1 flow(bus_elec_demand_dsm_6)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_7)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_6_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_7)
-1 SinkDsmBlock_DSMup(demand_dsm_7)
+1 flow(bus_elec_demand_dsm_7)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_8)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_7_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_8)
-1 SinkDsmBlock_DSMup(demand_dsm_8)
+1 flow(bus_elec_demand_dsm_8)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_9)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_9)
-1 SinkDsmBlock_DSMup(demand_dsm_9)
+1 flow(bus_elec_demand_dsm_9)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_10)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_10)
-1 SinkDsmBlock_DSMup(demand_dsm_10)
+1 flow(bus_elec_demand_dsm_10)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_11)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_11)
-1 SinkDsmBlock_DSMup(demand_dsm_11)
+1 flow(bus_elec_demand_dsm_11)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_12)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_11_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_12)
-1 SinkDsmBlock_DSMup(demand_dsm_12)
+1 flow(bus_elec_demand_dsm_12)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_13)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_12_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_13)
-1 SinkDsmBlock_DSMup(demand_dsm_13)
+1 flow(bus_elec_demand_dsm_13)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_14)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_13_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_14)
-1 SinkDsmBlock_DSMup(demand_dsm_14)
+1 flow(bus_elec_demand_dsm_14)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_15)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_14_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_15)
-1 SinkDsmBlock_DSMup(demand_dsm_15)
+1 flow(bus_elec_demand_dsm_15)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_16)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_15_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_16)
-1 SinkDsmBlock_DSMup(demand_dsm_16)
+1 flow(bus_elec_demand_dsm_16)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_17)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_16_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_17)
-1 SinkDsmBlock_DSMup(demand_dsm_17)
+1 flow(bus_elec_demand_dsm_17)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_18)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_17_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_18)
-1 SinkDsmBlock_DSMup(demand_dsm_18)
+1 flow(bus_elec_demand_dsm_18)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_19)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_18_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_19)
-1 SinkDsmBlock_DSMup(demand_dsm_19)
+1 flow(bus_elec_demand_dsm_19)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_20)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_19_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_20)
-1 SinkDsmBlock_DSMup(demand_dsm_20)
+1 flow(bus_elec_demand_dsm_20)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_21)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_20_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_21)
-1 SinkDsmBlock_DSMup(demand_dsm_21)
+1 flow(bus_elec_demand_dsm_21)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_22)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_21_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_22)
-1 SinkDsmBlock_DSMup(demand_dsm_22)
+1 flow(bus_elec_demand_dsm_22)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_23)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_22_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_23)
-1 SinkDsmBlock_DSMup(demand_dsm_23)
+1 flow(bus_elec_demand_dsm_23)
= 100

c_e_SinkDsmBlock_input_output_relation(demand_dsm_24)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_23_24)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_24)
-1 SinkDsmBlock_DSMup(demand_dsm_24)
+1 flow(bus_elec_demand_dsm_24)
= 100

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_0)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_0_0)
-1 SinkDsmBlock_DSMdo(demand_dsm_0_1)
+1 SinkDsmBlock_DSMup(demand_dsm_0)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_1)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_1_0)
-1 SinkDsmBlock_DSMdo(demand_dsm_1_1)
-1 SinkDsmBlock_DSMdo(demand_dsm_1_2)
+1 SinkDsmBlock_DSMup(demand_dsm_1)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_2)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_2_1)
-1 SinkDsmBlock_DSMdo(demand_dsm_2_2)
-1 SinkDsmBlock_DSMdo(demand_dsm_2_3)
+1 SinkDsmBlock_DSMup(demand_dsm_2)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_3)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_3_2)
-1 SinkDsmBlock_DSMdo(demand_dsm_3_3)
-1 SinkDsmBlock_DSMdo(demand_dsm_3_4)
+1 SinkDsmBlock_DSMup(demand_dsm_3)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_4)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_4_3)
-1 SinkDsmBlock_DSMdo(demand_dsm_4_4)
-1 SinkDsmBlock_DSMdo(demand_dsm_4_5)
+1 SinkDsmBlock_DSMup(demand_dsm_4)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_5)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_5_4)
-1 SinkDsmBlock_DSMdo(demand_dsm_5_5)
-1 SinkDsmBlock_DSMdo(demand_dsm_5_6)
+1 SinkDsmBlock_DSMup(demand_dsm_5)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_6)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_6_5)
-1 SinkDsmBlock_DSMdo(demand_dsm_6_6)
-1 SinkDsmBlock_DSMdo(demand_dsm_6_7)
+1 SinkDsmBlock_DSMup(demand_dsm_6)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_7)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_7_6)
-1 SinkDsmBlock_DSMdo(demand_dsm_7_7)
-1 SinkDsmBlock_DSMdo(demand_dsm_7_8)
+1 SinkDsmBlock_DSMup(demand_dsm_7)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_8)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_8_7)
-1 SinkDsmBlock_DSMdo(demand_dsm_8_8)
-1 SinkDsmBlock_DSMdo(demand_dsm_8_9)
+1 SinkDsmBlock_DSMup(demand_dsm_8)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_9)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_9_10)
-1 SinkDsmBlock_DSMdo(demand_dsm_9_8)
-1 SinkDsmBlock_DSMdo(demand_dsm_9_9)
+1 SinkDsmBlock_DSMup(demand_dsm_9)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_10)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_10_10)
-1 SinkDsmBlock_DSMdo(demand_dsm_10_11)
-1 SinkDsmBlock_DSMdo(demand_dsm_10_9)
+1 SinkDsmBlock_DSMup(demand_dsm_10)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_11)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_11_10)
-1 SinkDsmBlock_DSMdo(demand_dsm_11_11)
-1 SinkDsmBlock_DSMdo(demand_dsm_11_12)
+1 SinkDsmBlock_DSMup(demand_dsm_11)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_12)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_12_11)
-1 SinkDsmBlock_DSMdo(demand_dsm_12_12)
-1 SinkDsmBlock_DSMdo(demand_dsm_12_13)
+1 SinkDsmBlock_DSMup(demand_dsm_12)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_13)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_13_12)
-1 SinkDsmBlock_DSMdo(demand_dsm_13_13)
-1 SinkDsmBlock_DSMdo(demand_dsm_13_14)
+1 SinkDsmBlock_DSMup(demand_dsm_13)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_14)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_14_13)
-1 SinkDsmBlock_DSMdo(demand_dsm_14_14)
-1 SinkDsmBlock_DSMdo(demand_dsm_14_15)
+1 SinkDsmBlock_DSMup(demand_dsm_14)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_15)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_15_14)
-1 SinkDsmBlock_DSMdo(demand_dsm_15_15)
-1 SinkDsmBlock_DSMdo(demand_dsm_15_16)
+1 SinkDsmBlock_DSMup(demand_dsm_15)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_16)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_16_15)
-1 SinkDsmBlock_DSMdo(demand_dsm_16_16)
-1 SinkDsmBlock_DSMdo(demand_dsm_16_17)
+1 SinkDsmBlock_DSMup(demand_dsm_16)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_17)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_17_16)
-1 SinkDsmBlock_DSMdo(demand_dsm_17_17)
-1 SinkDsmBlock_DSMdo(demand_dsm_17_18)
+1 SinkDsmBlock_DSMup(demand_dsm_17)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_18)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_18_17)
-1 SinkDsmBlock_DSMdo(demand_dsm_18_18)
-1 SinkDsmBlock_DSMdo(demand_dsm_18_19)
+1 SinkDsmBlock_DSMup(demand_dsm_18)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_19)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_19_18)
-1 SinkDsmBlock_DSMdo(demand_dsm_19_19)
-1 SinkDsmBlock_DSMdo(demand_dsm_19_20)
+1 SinkDsmBlock_DSMup(demand_dsm_19)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_20)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_20_19)
-1 SinkDsmBlock_DSMdo(demand_dsm_20_20)
-1 SinkDsmBlock_DSMdo(demand_dsm_20_21)
+1 SinkDsmBlock_DSMup(demand_dsm_20)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_21)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_21_20)
-1 SinkDsmBlock_DSMdo(demand_dsm_21_21)
-1 SinkDsmBlock_DSMdo(demand_dsm_21_22)
+1 SinkDsmBlock_DSMup(demand_dsm_21)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_22)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_22_21)
-1 SinkDsmBlock_DSMdo(demand_dsm_22_22)
-1 SinkDsmBlock_DSMdo(demand_dsm_22_23)
+1 SinkDsmBlock_DSMup(demand_dsm_22)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_23)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_23_22)
-1 SinkDsmBlock_DSMdo(demand_dsm_23_23)
-1 SinkDsmBlock_DSMdo(demand_dsm_23_24)
+1 SinkDsmBlock_DSMup(demand_dsm_23)
= 0

c_e_SinkDsmBlock_dsmupdo_constraint(demand_dsm_24)_:
-1 SinkDsmBlock_DSMdo(demand_dsm_24_23)
-1 SinkDsmBlock_DSMdo(demand_dsm_24_24)
+1 SinkDsmBlock_DSMup(demand_dsm_24)
= 0

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_0)_:
+1 SinkDsmBlock_DSMup(demand_dsm_0)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_1)_:
+1 SinkDsmBlock_DSMup(demand_dsm_1)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_2)_:
+1 SinkDsmBlock_DSMup(demand_dsm_2)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_3)_:
+1 SinkDsmBlock_DSMup(demand_dsm_3)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_4)_:
+1 SinkDsmBlock_DSMup(demand_dsm_4)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_5)_:
+1 SinkDsmBlock_DSMup(demand_dsm_5)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_6)_:
+1 SinkDsmBlock_DSMup(demand_dsm_6)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_7)_:
+1 SinkDsmBlock_DSMup(demand_dsm_7)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_8)_:
+1 SinkDsmBlock_DSMup(demand_dsm_8)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_9)_:
+1 SinkDsmBlock_DSMup(demand_dsm_9)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_10)_:
+1 SinkDsmBlock_DSMup(demand_dsm_10)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_11)_:
+1 SinkDsmBlock_DSMup(demand_dsm_11)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_12)_:
+1 SinkDsmBlock_DSMup(demand_dsm_12)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_13)_:
+1 SinkDsmBlock_DSMup(demand_dsm_13)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_14)_:
+1 SinkDsmBlock_DSMup(demand_dsm_14)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_15)_:
+1 SinkDsmBlock_DSMup(demand_dsm_15)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_16)_:
+1 SinkDsmBlock_DSMup(demand_dsm_16)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_17)_:
+1 SinkDsmBlock_DSMup(demand_dsm_17)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_18)_:
+1 SinkDsmBlock_DSMup(demand_dsm_18)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_19)_:
+1 SinkDsmBlock_DSMup(demand_dsm_19)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_20)_:
+1 SinkDsmBlock_DSMup(demand_dsm_20)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_21)_:
+1 SinkDsmBlock_DSMup(demand_dsm_21)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_22)_:
+1 SinkDsmBlock_DSMup(demand_dsm_22)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_23)_:
+1 SinkDsmBlock_DSMup(demand_dsm_23)
<= 50

c_u_SinkDsmBlock_dsmup_constraint(demand_dsm_24)_:
+1 SinkDsmBlock_DSMup(demand_dsm_24)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_0)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_0)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_0)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_1)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_1)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_2)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_1_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_2)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_3)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_2_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_3)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_4)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_3_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_4)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_5)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_4_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_5)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_6)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_5_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_6)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_7)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_6_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_7)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_8)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_7_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_8)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_9)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_9)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_10)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_10)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_11)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_11)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_12)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_11_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_12)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_13)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_12_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_13)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_14)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_13_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_14)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_15)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_14_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_15)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_16)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_15_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_16)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_17)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_16_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_17)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_18)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_17_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_18)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_19)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_18_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_19)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_20)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_19_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_20)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_21)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_20_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_21)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_22)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_21_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_22)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_23)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_22_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_23)
<= 50

c_u_SinkDsmBlock_dsmdo_constraint(demand_dsm_24)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_23_24)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_24)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_0)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_0)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_0)
+1 SinkDsmBlock_DSMup(demand_dsm_0)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_1)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_0_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_1_1)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_1)
+1 SinkDsmBlock_DSMup(demand_dsm_1)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_2)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_1_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_2_2)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_2)
+1 SinkDsmBlock_DSMup(demand_dsm_2)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_3)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_2_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_3_3)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_3)
+1 SinkDsmBlock_DSMup(demand_dsm_3)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_4)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_3_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_4_4)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_4)
+1 SinkDsmBlock_DSMup(demand_dsm_4)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_5)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_4_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_5_5)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_5)
+1 SinkDsmBlock_DSMup(demand_dsm_5)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_6)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_5_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_6_6)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_6)
+1 SinkDsmBlock_DSMup(demand_dsm_6)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_7)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_6_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_7_7)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_7)
+1 SinkDsmBlock_DSMup(demand_dsm_7)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_8)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_7_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_8)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_8)
+1 SinkDsmBlock_DSMup(demand_dsm_8)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_9)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_8_9)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_9)
+1 SinkDsmBlock_DSMup(demand_dsm_9)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_10)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_10)
+1 SinkDsmBlock_DSMdo(demand_dsm_9_10)
+1 SinkDsmBlock_DSMup(demand_dsm_10)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_11)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_10_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_11_11)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_11)
+1 SinkDsmBlock_DSMup(demand_dsm_11)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_12)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_11_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_12_12)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_12)
+1 SinkDsmBlock_DSMup(demand_dsm_12)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_13)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_12_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_13_13)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_13)
+1 SinkDsmBlock_DSMup(demand_dsm_13)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_14)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_13_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_14_14)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_14)
+1 SinkDsmBlock_DSMup(demand_dsm_14)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_15)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_14_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_15_15)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_15)
+1 SinkDsmBlock_DSMup(demand_dsm_15)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_16)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_15_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_16_16)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_16)
+1 SinkDsmBlock_DSMup(demand_dsm_16)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_17)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_16_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_17_17)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_17)
+1 SinkDsmBlock_DSMup(demand_dsm_17)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_18)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_17_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_18_18)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_18)
+1 SinkDsmBlock_DSMup(demand_dsm_18)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_19)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_18_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_19_19)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_19)
+1 SinkDsmBlock_DSMup(demand_dsm_19)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_20)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_19_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_20_20)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_20)
+1 SinkDsmBlock_DSMup(demand_dsm_20)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_21)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_20_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_21_21)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_21)
+1 SinkDsmBlock_DSMup(demand_dsm_21)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_22)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_21_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_22_22)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_22)
+1 SinkDsmBlock_DSMup(demand_dsm_22)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_23)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_22_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_23_23)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_23)
+1 SinkDsmBlock_DSMup(demand_dsm_23)
<= 50

c_u_SinkDsmBlock_C2_constraint(demand_dsm_24)_:
+1 SinkDsmBlock_DSMdo(demand_dsm_23_24)
+1 SinkDsmBlock_DSMdo(demand_dsm_24_24)
+1 SinkDsmBlock_DSMup(demand_dsm_24)
<= 50

c_e_ONE_VAR_CONSTANT: 
ONE_VAR_CONSTANT = 1.0

bounds
   0 <= flow(bus_coal_1_pp_coal_1_0) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_1) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_2) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_3) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_4) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_5) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_6) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_7) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_8) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_9) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_10) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_11) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_12) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_13) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_14) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_15) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_16) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_17) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_18) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_19) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_20) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_21) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_22) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_23) <= +inf
   0 <= flow(bus_coal_1_pp_coal_1_24) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_0) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_1) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_2) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_3) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_4) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_5) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_6) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_7) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_8) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_9) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_10) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_11) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_12) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_13) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_14) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_15) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_16) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_17) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_18) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_19) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_20) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_21) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_22) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_23) <= +inf
   0 <= flow(bus_coal_2_pp_coal_2_24) <= +inf
   0 <= flow(bus_elec_demand_dsm_0) <= +inf
   0 <= flow(bus_elec_demand_dsm_1) <= +inf
   0 <= flow(bus_elec_demand_dsm_2) <= +inf
   0 <= flow(bus_elec_demand_dsm_3) <= +inf
   0 <= flow(bus_elec_demand_dsm_4) <= +inf
   0 <= flow(bus_elec_demand_dsm_5) <= +inf
   0 <= flow(bus_elec_demand_dsm_6) <= +inf
   0 <= flow(bus_elec_demand_dsm_7) <= +inf
   0 <= flow(bus_elec_demand_dsm_8) <= +inf
   0 <= flow(bus_elec_demand_dsm_9) <= +inf
   0 <= flow(bus_elec_demand_dsm_10) <= +inf
   0 <= flow(bus_elec_demand_dsm_11) <= +inf
   0 <= flow(bus_elec_demand_dsm_12) <= +inf
   0 <= flow(bus_elec_demand_dsm_13) <= +inf
   0 <= flow(bus_elec_demand_dsm_14) <= +inf
   0 <= flow(bus_elec_demand_dsm_15) <= +inf
   0 <= flow(bus_elec_demand_dsm_16) <= +inf
   0 <= flow(bus_elec_demand_dsm_17) <= +inf
   0 <= flow(bus_elec_demand_dsm_18) <= +inf
   0 <= flow(bus_elec_demand_dsm_19) <= +inf
   0 <= flow(bus_elec_demand_dsm_20) <= +inf
   0 <= flow(bus_elec_demand_dsm_21) <= +inf
   0 <= flow(bus_elec_demand_dsm_22) <= +inf
   0 <= flow(bus_elec_demand_dsm_23) <= +inf
   0 <= flow(bus_elec_demand_dsm_24) <= +inf
   0 <= flow(bus_elec_excess_el_0) <= +inf
   0 <= flow(bus_elec_excess_el_1) <= +inf
   0 <= flow(bus_elec_excess_el_2) <= +inf
   0 <= flow(bus_elec_excess_el_3) <= +inf
   0 <= flow(bus_elec_excess_el_4) <= +inf
   0 <= flow(bus_elec_excess_el_5) <= +inf
   0 <= flow(bus_elec_excess_el_6) <= +inf
   0 <= flow(bus_elec_excess_el_7) <= +inf
   0 <= flow(bus_elec_excess_el_8) <= +inf
   0 <= flow(bus_elec_excess_el_9) <= +inf
   0 <= flow(bus_elec_excess_el_10) <= +inf
   0 <= flow(bus_elec_excess_el_11) <= +inf
   0 <= flow(bus_elec_excess_el_12) <= +inf
   0 <= flow(bus_elec_excess_el_13) <= +inf
   0 <= flow(bus_elec_excess_el_14) <= +inf
   0 <= flow(bus_elec_excess_el_15) <= +inf
   0 <= flow(bus_elec_excess_el_16) <= +inf
   0 <= flow(bus_elec_excess_el_17) <= +inf
   0 <= flow(bus_elec_excess_el_18) <= +inf
   0 <= flow(bus_elec_excess_el_19) <= +inf
   0 <= flow(bus_elec_excess_el_20) <= +inf
   0 <= flow(bus_elec_excess_el_21) <= +inf
   0 <= flow(bus_elec_excess_el_22) <= +inf
   0 <= flow(bus_elec_excess_el_23) <= +inf
   0 <= flow(bus_elec_excess_el_24) <= +inf
   0 <= flow(pp_coal_1_bus_elec_0) <= +inf
   0 <= flow(pp_coal_1_bus_elec_1) <= +inf
   0 <= flow(pp_coal_1_bus_elec_2) <= +inf
   0 <= flow(pp_coal_1_bus_elec_3) <= +inf
   0 <= flow(pp_coal_1_bus_elec_4) <= +inf
   0 <= flow(pp_coal_1_bus_elec_5) <= +inf
   0 <= flow(pp_coal_1_bus_elec_6) <= +inf
   0 <= flow(pp_coal_1_bus_elec_7) <= +inf
   0 <= flow(pp_coal_1_bus_elec_8) <= +inf
   0 <= flow(pp_coal_1_bus_elec_9) <= +inf
   0 <= flow(pp_coal_1_bus_elec_10) <= +inf
   0 <= flow(pp_coal_1_bus_elec_11) <= +inf
   0 <= flow(pp_coal_1_bus_elec_12) <= +inf
   0 <= flow(pp_coal_1_bus_elec_13) <= +inf
   0 <= flow(pp_coal_1_bus_elec_14) <= +inf
   0 <= flow(pp_coal_1_bus_elec_15) <= +inf
   0 <= flow(pp_coal_1_bus_elec_16) <= +inf
   0 <= flow(pp_coal_1_bus_elec_17) <= +inf
   0 <= flow(pp_coal_1_bus_elec_18) <= +inf
   0 <= flow(pp_coal_1_bus_elec_19) <= +inf
   0 <= flow(pp_coal_1_bus_elec_20) <= +inf
   0 <= flow(pp_coal_1_bus_elec_21) <= +inf
   0 <= flow(pp_coal_1_bus_elec_22) <= +inf
   0 <= flow(pp_coal_1_bus_elec_23) <= +inf
   0 <= flow(pp_coal_1_bus_elec_24) <= +inf
   0 <= flow(pp_coal_2_bus_elec_0) <= +inf
   0 <= flow(pp_coal_2_bus_elec_1) <= +inf
   0 <= flow(pp_coal_2_bus_elec_2) <= +inf
   0 <= flow(pp_coal_2_bus_elec_3) <= +inf
   0 <= flow(pp_coal_2_bus_elec_4) <= +inf
   0 <= flow(pp_coal_2_bus_elec_5) <= +inf
   0 <= flow(pp_coal_2_bus_elec_6) <= +inf
   0 <= flow(pp_coal_2_bus_elec_7) <= +inf
   0 <= flow(pp_coal_2_bus_elec_8) <= +inf
   0 <= flow(pp_coal_2_bus_elec_9) <= +inf
   0 <= flow(pp_coal_2_bus_elec_10) <= +inf
   0 <= flow(pp_coal_2_bus_elec_11) <= +inf
   0 <= flow(pp_coal_2_bus_elec_12) <= +inf
   0 <= flow(pp_coal_2_bus_elec_13) <= +inf
   0 <= flow(pp_coal_2_bus_elec_14) <= +inf
   0 <= flow(pp_coal_2_bus_elec_15) <= +inf
   0 <= flow(pp_coal_2_bus_elec_16) <= +inf
   0 <= flow(pp_coal_2_bus_elec_17) <= +inf
   0 <= flow(pp_coal_2_bus_elec_18) <= +inf
   0 <= flow(pp_coal_2_bus_elec_19) <= +inf
   0 <= flow(pp_coal_2_bus_elec_20) <= +inf
   0 <= flow(pp_coal_2_bus_elec_21) <= +inf
   0 <= flow(pp_coal_2_bus_elec_22) <= +inf
   0 <= flow(pp_coal_2_bus_elec_23) <= +inf
   0 <= flow(pp_coal_2_bus_elec_24) <= +inf
   0 <= flow(shortage_el_bus_elec_0) <= +inf
   0 <= flow(shortage_el_bus_elec_1) <= +inf
   0 <= flow(shortage_el_bus_elec_2) <= +inf
   0 <= flow(shortage_el_bus_elec_3) <= +inf
   0 <= flow(shortage_el_bus_elec_4) <= +inf
   0 <= flow(shortage_el_bus_elec_5) <= +inf
   0 <= flow(shortage_el_bus_elec_6) <= +inf
   0 <= flow(shortage_el_bus_elec_7) <= +inf
   0 <= flow(shortage_el_bus_elec_8) <= +inf
   0 <= flow(shortage_el_bus_elec_9) <= +inf
   0 <= flow(shortage_el_bus_elec_10) <= +inf
   0 <= flow(shortage_el_bus_elec_11) <= +inf
   0 <= flow(shortage_el_bus_elec_12) <= +inf
   0 <= flow(shortage_el_bus_elec_13) <= +inf
   0 <= flow(shortage_el_bus_elec_14) <= +inf
   0 <= flow(shortage_el_bus_elec_15) <= +inf
   0 <= flow(shortage_el_bus_elec_16) <= +inf
   0 <= flow(shortage_el_bus_elec_17) <= +inf
   0 <= flow(shortage_el_bus_elec_18) <= +inf
   0 <= flow(shortage_el_bus_elec_19) <= +inf
   0 <= flow(shortage_el_bus_elec_20) <= +inf
   0 <= flow(shortage_el_bus_elec_21) <= +inf
   0 <= flow(shortage_el_bus_elec_22) <= +inf
   0 <= flow(shortage_el_bus_elec_23) <= +inf
   0 <= flow(shortage_el_bus_elec_24) <= +inf
   0 <= flow(source_coal_p1_bus_coal_1_0) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_1) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_2) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_3) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_4) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_5) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_6) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_7) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_8) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_9) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_10) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_11) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_12) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_13) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_14) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_15) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_16) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_17) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_18) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_19) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_20) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_21) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_22) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_23) <= 100
   0 <= flow(source_coal_p1_bus_coal_1_24) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_0) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_1) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_2) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_3) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_4) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_5) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_6) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_7) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_8) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_9) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_10) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_11) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_12) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_13) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_14) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_15) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_16) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_17) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_18) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_19) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_20) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_21) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_22) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_23) <= 100
   0 <= flow(source_coal_p2_bus_coal_2_24) <= 100
   0 <= SinkDsmBlock_DSMdo(demand_dsm_0_0) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_0_1) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_1_0) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_1_1) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_1_2) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_2_1) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_2_2) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_2_3) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_3_2) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_3_3) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_3_4) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_4_3) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_4_4) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_4_5) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_5_4) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_5_5) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_5_6) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_6_5) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_6_6) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_6_7) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_7_6) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_7_7) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_7_8) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_8_7) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_8_8) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_8_9) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_9_8) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_9_9) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_9_10) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_10_9) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_10_10) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_10_11) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_11_10) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_11_11) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_11_12) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_12_11) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_12_12) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_12_13) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_13_12) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_13_13) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_13_14) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_14_13) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_14_14) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_14_15) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_15_14) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_15_15) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_15_16) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_16_15) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_16_16) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_16_17) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_17_16) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_17_17) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_17_18) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_18_17) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_18_18) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_18_19) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_19_18) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_19_19) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_19_20) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_20_19) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_20_20) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_20_21) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_21_20) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_21_21) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_21_22) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_22_21) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_22_22) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_22_23) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_23_22) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_23_23) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_23_24) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_24_23) <= +inf
   0 <= SinkDsmBlock_DSMdo(demand_dsm_24_24) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_0) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_1) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_2) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_3) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_4) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_5) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_6) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_7) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_8) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_9) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_10) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_11) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_12) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_13) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_14) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_15) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_16) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_17) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_18) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_19) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_20) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_21) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_22) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_23) <= +inf
   0 <= SinkDsmBlock_DSMup(demand_dsm_24) <= +inf
end
