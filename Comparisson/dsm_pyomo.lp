\* Source Pyomo model name=unknown *\

min 
obj:
+10 P1(1)
+10 P1(10)
+10 P1(11)
+10 P1(12)
+10 P1(13)
+10 P1(14)
+10 P1(15)
+10 P1(16)
+10 P1(17)
+10 P1(18)
+10 P1(19)
+10 P1(2)
+10 P1(20)
+10 P1(21)
+10 P1(22)
+10 P1(23)
+10 P1(24)
+10 P1(25)
+10 P1(26)
+10 P1(3)
+10 P1(4)
+10 P1(5)
+10 P1(6)
+10 P1(7)
+10 P1(8)
+10 P1(9)
+20 P2(1)
+20 P2(10)
+20 P2(11)
+20 P2(12)
+20 P2(13)
+20 P2(14)
+20 P2(15)
+20 P2(16)
+20 P2(17)
+20 P2(18)
+20 P2(19)
+20 P2(2)
+20 P2(20)
+20 P2(21)
+20 P2(22)
+20 P2(23)
+20 P2(24)
+20 P2(25)
+20 P2(26)
+20 P2(3)
+20 P2(4)
+20 P2(5)
+20 P2(6)
+20 P2(7)
+20 P2(8)
+20 P2(9)

s.t.

c_u_demandConstraint(1)_:
-1 DSMdo(1_1)
-1 DSMdo(2_1)
+1 DSMup(1)
-1 P1(1)
-1 P2(1)
<= 18

c_u_demandConstraint(2)_:
-1 DSMdo(1_2)
-1 DSMdo(2_2)
-1 DSMdo(3_2)
+1 DSMup(2)
-1 P1(2)
-1 P2(2)
<= 21

c_u_demandConstraint(3)_:
-1 DSMdo(2_3)
-1 DSMdo(3_3)
-1 DSMdo(4_3)
+1 DSMup(3)
-1 P1(3)
-1 P2(3)
<= 42

c_u_demandConstraint(4)_:
-1 DSMdo(3_4)
-1 DSMdo(4_4)
-1 DSMdo(5_4)
+1 DSMup(4)
-1 P1(4)
-1 P2(4)
<= 49

c_u_demandConstraint(5)_:
-1 DSMdo(4_5)
-1 DSMdo(5_5)
-1 DSMdo(6_5)
+1 DSMup(5)
-1 P1(5)
-1 P2(5)
<= -1

c_u_demandConstraint(6)_:
-1 DSMdo(5_6)
-1 DSMdo(6_6)
-1 DSMdo(7_6)
+1 DSMup(6)
-1 P1(6)
-1 P2(6)
<= -60

c_u_demandConstraint(7)_:
-1 DSMdo(6_7)
-1 DSMdo(7_7)
-1 DSMdo(8_7)
+1 DSMup(7)
-1 P1(7)
-1 P2(7)
<= 48

c_u_demandConstraint(8)_:
-1 DSMdo(7_8)
-1 DSMdo(8_8)
-1 DSMdo(9_8)
+1 DSMup(8)
-1 P1(8)
-1 P2(8)
<= -31

c_u_demandConstraint(9)_:
-1 DSMdo(10_9)
-1 DSMdo(8_9)
-1 DSMdo(9_9)
+1 DSMup(9)
-1 P1(9)
-1 P2(9)
<= -21

c_u_demandConstraint(10)_:
-1 DSMdo(10_10)
-1 DSMdo(11_10)
-1 DSMdo(9_10)
+1 DSMup(10)
-1 P1(10)
-1 P2(10)
<= -34

c_u_demandConstraint(11)_:
-1 DSMdo(10_11)
-1 DSMdo(11_11)
-1 DSMdo(12_11)
+1 DSMup(11)
-1 P1(11)
-1 P2(11)
<= -21

c_u_demandConstraint(12)_:
-1 DSMdo(11_12)
-1 DSMdo(12_12)
-1 DSMdo(13_12)
+1 DSMup(12)
-1 P1(12)
-1 P2(12)
<= 20

c_u_demandConstraint(13)_:
-1 DSMdo(12_13)
-1 DSMdo(13_13)
-1 DSMdo(14_13)
+1 DSMup(13)
-1 P1(13)
-1 P2(13)
<= 52

c_u_demandConstraint(14)_:
-1 DSMdo(13_14)
-1 DSMdo(14_14)
-1 DSMdo(15_14)
+1 DSMup(14)
-1 P1(14)
-1 P2(14)
<= 26

c_u_demandConstraint(15)_:
-1 DSMdo(14_15)
-1 DSMdo(15_15)
-1 DSMdo(16_15)
+1 DSMup(15)
-1 P1(15)
-1 P2(15)
<= 8

c_u_demandConstraint(16)_:
-1 DSMdo(15_16)
-1 DSMdo(16_16)
-1 DSMdo(17_16)
+1 DSMup(16)
-1 P1(16)
-1 P2(16)
<= 33

c_u_demandConstraint(17)_:
-1 DSMdo(16_17)
-1 DSMdo(17_17)
-1 DSMdo(18_17)
+1 DSMup(17)
-1 P1(17)
-1 P2(17)
<= 13

c_u_demandConstraint(18)_:
-1 DSMdo(17_18)
-1 DSMdo(18_18)
-1 DSMdo(19_18)
+1 DSMup(18)
-1 P1(18)
-1 P2(18)
<= -23

c_u_demandConstraint(19)_:
-1 DSMdo(18_19)
-1 DSMdo(19_19)
-1 DSMdo(20_19)
+1 DSMup(19)
-1 P1(19)
-1 P2(19)
<= -30

c_u_demandConstraint(20)_:
-1 DSMdo(19_20)
-1 DSMdo(20_20)
-1 DSMdo(21_20)
+1 DSMup(20)
-1 P1(20)
-1 P2(20)
<= -36

c_u_demandConstraint(21)_:
-1 DSMdo(20_21)
-1 DSMdo(21_21)
-1 DSMdo(22_21)
+1 DSMup(21)
-1 P1(21)
-1 P2(21)
<= 32

c_u_demandConstraint(22)_:
-1 DSMdo(21_22)
-1 DSMdo(22_22)
-1 DSMdo(23_22)
+1 DSMup(22)
-1 P1(22)
-1 P2(22)
<= 12

c_u_demandConstraint(23)_:
-1 DSMdo(22_23)
-1 DSMdo(23_23)
-1 DSMdo(24_23)
+1 DSMup(23)
-1 P1(23)
-1 P2(23)
<= -16

c_u_demandConstraint(24)_:
-1 DSMdo(23_24)
-1 DSMdo(24_24)
-1 DSMdo(25_24)
+1 DSMup(24)
-1 P1(24)
-1 P2(24)
<= -10

c_u_demandConstraint(25)_:
-1 DSMdo(24_25)
-1 DSMdo(25_25)
-1 DSMdo(26_25)
+1 DSMup(25)
-1 P1(25)
-1 P2(25)
<= -73

c_u_demandConstraint(26)_:
-1 DSMdo(25_26)
-1 DSMdo(26_26)
+1 DSMup(26)
-1 P1(26)
-1 P2(26)
<= -77

c_e_dsmupdoConstraint(1)_:
+1 DSMdo(1_1)
+1 DSMdo(1_2)
-1 DSMup(1)
= 0

c_e_dsmupdoConstraint(2)_:
+1 DSMdo(2_1)
+1 DSMdo(2_2)
+1 DSMdo(2_3)
-1 DSMup(2)
= 0

c_e_dsmupdoConstraint(3)_:
+1 DSMdo(3_2)
+1 DSMdo(3_3)
+1 DSMdo(3_4)
-1 DSMup(3)
= 0

c_e_dsmupdoConstraint(4)_:
+1 DSMdo(4_3)
+1 DSMdo(4_4)
+1 DSMdo(4_5)
-1 DSMup(4)
= 0

c_e_dsmupdoConstraint(5)_:
+1 DSMdo(5_4)
+1 DSMdo(5_5)
+1 DSMdo(5_6)
-1 DSMup(5)
= 0

c_e_dsmupdoConstraint(6)_:
+1 DSMdo(6_5)
+1 DSMdo(6_6)
+1 DSMdo(6_7)
-1 DSMup(6)
= 0

c_e_dsmupdoConstraint(7)_:
+1 DSMdo(7_6)
+1 DSMdo(7_7)
+1 DSMdo(7_8)
-1 DSMup(7)
= 0

c_e_dsmupdoConstraint(8)_:
+1 DSMdo(8_7)
+1 DSMdo(8_8)
+1 DSMdo(8_9)
-1 DSMup(8)
= 0

c_e_dsmupdoConstraint(9)_:
+1 DSMdo(9_10)
+1 DSMdo(9_8)
+1 DSMdo(9_9)
-1 DSMup(9)
= 0

c_e_dsmupdoConstraint(10)_:
+1 DSMdo(10_10)
+1 DSMdo(10_11)
+1 DSMdo(10_9)
-1 DSMup(10)
= 0

c_e_dsmupdoConstraint(11)_:
+1 DSMdo(11_10)
+1 DSMdo(11_11)
+1 DSMdo(11_12)
-1 DSMup(11)
= 0

c_e_dsmupdoConstraint(12)_:
+1 DSMdo(12_11)
+1 DSMdo(12_12)
+1 DSMdo(12_13)
-1 DSMup(12)
= 0

c_e_dsmupdoConstraint(13)_:
+1 DSMdo(13_12)
+1 DSMdo(13_13)
+1 DSMdo(13_14)
-1 DSMup(13)
= 0

c_e_dsmupdoConstraint(14)_:
+1 DSMdo(14_13)
+1 DSMdo(14_14)
+1 DSMdo(14_15)
-1 DSMup(14)
= 0

c_e_dsmupdoConstraint(15)_:
+1 DSMdo(15_14)
+1 DSMdo(15_15)
+1 DSMdo(15_16)
-1 DSMup(15)
= 0

c_e_dsmupdoConstraint(16)_:
+1 DSMdo(16_15)
+1 DSMdo(16_16)
+1 DSMdo(16_17)
-1 DSMup(16)
= 0

c_e_dsmupdoConstraint(17)_:
+1 DSMdo(17_16)
+1 DSMdo(17_17)
+1 DSMdo(17_18)
-1 DSMup(17)
= 0

c_e_dsmupdoConstraint(18)_:
+1 DSMdo(18_17)
+1 DSMdo(18_18)
+1 DSMdo(18_19)
-1 DSMup(18)
= 0

c_e_dsmupdoConstraint(19)_:
+1 DSMdo(19_18)
+1 DSMdo(19_19)
+1 DSMdo(19_20)
-1 DSMup(19)
= 0

c_e_dsmupdoConstraint(20)_:
+1 DSMdo(20_19)
+1 DSMdo(20_20)
+1 DSMdo(20_21)
-1 DSMup(20)
= 0

c_e_dsmupdoConstraint(21)_:
+1 DSMdo(21_20)
+1 DSMdo(21_21)
+1 DSMdo(21_22)
-1 DSMup(21)
= 0

c_e_dsmupdoConstraint(22)_:
+1 DSMdo(22_21)
+1 DSMdo(22_22)
+1 DSMdo(22_23)
-1 DSMup(22)
= 0

c_e_dsmupdoConstraint(23)_:
+1 DSMdo(23_22)
+1 DSMdo(23_23)
+1 DSMdo(23_24)
-1 DSMup(23)
= 0

c_e_dsmupdoConstraint(24)_:
+1 DSMdo(24_23)
+1 DSMdo(24_24)
+1 DSMdo(24_25)
-1 DSMup(24)
= 0

c_e_dsmupdoConstraint(25)_:
+1 DSMdo(25_24)
+1 DSMdo(25_25)
+1 DSMdo(25_26)
-1 DSMup(25)
= 0

c_e_dsmupdoConstraint(26)_:
+1 DSMdo(26_25)
+1 DSMdo(26_26)
-1 DSMup(26)
= 0

c_u_dsmupConstraint(1)_:
+1 DSMup(1)
<= 50

c_u_dsmupConstraint(2)_:
+1 DSMup(2)
<= 50

c_u_dsmupConstraint(3)_:
+1 DSMup(3)
<= 50

c_u_dsmupConstraint(4)_:
+1 DSMup(4)
<= 50

c_u_dsmupConstraint(5)_:
+1 DSMup(5)
<= 50

c_u_dsmupConstraint(6)_:
+1 DSMup(6)
<= 50

c_u_dsmupConstraint(7)_:
+1 DSMup(7)
<= 50

c_u_dsmupConstraint(8)_:
+1 DSMup(8)
<= 50

c_u_dsmupConstraint(9)_:
+1 DSMup(9)
<= 50

c_u_dsmupConstraint(10)_:
+1 DSMup(10)
<= 50

c_u_dsmupConstraint(11)_:
+1 DSMup(11)
<= 50

c_u_dsmupConstraint(12)_:
+1 DSMup(12)
<= 50

c_u_dsmupConstraint(13)_:
+1 DSMup(13)
<= 50

c_u_dsmupConstraint(14)_:
+1 DSMup(14)
<= 50

c_u_dsmupConstraint(15)_:
+1 DSMup(15)
<= 50

c_u_dsmupConstraint(16)_:
+1 DSMup(16)
<= 50

c_u_dsmupConstraint(17)_:
+1 DSMup(17)
<= 50

c_u_dsmupConstraint(18)_:
+1 DSMup(18)
<= 50

c_u_dsmupConstraint(19)_:
+1 DSMup(19)
<= 50

c_u_dsmupConstraint(20)_:
+1 DSMup(20)
<= 50

c_u_dsmupConstraint(21)_:
+1 DSMup(21)
<= 50

c_u_dsmupConstraint(22)_:
+1 DSMup(22)
<= 50

c_u_dsmupConstraint(23)_:
+1 DSMup(23)
<= 50

c_u_dsmupConstraint(24)_:
+1 DSMup(24)
<= 50

c_u_dsmupConstraint(25)_:
+1 DSMup(25)
<= 50

c_u_dsmupConstraint(26)_:
+1 DSMup(26)
<= 50

c_u_dsmdoConstraint(1)_:
+1 DSMdo(1_1)
+1 DSMdo(2_1)
<= 50

c_u_dsmdoConstraint(2)_:
+1 DSMdo(1_2)
+1 DSMdo(2_2)
+1 DSMdo(3_2)
<= 50

c_u_dsmdoConstraint(3)_:
+1 DSMdo(2_3)
+1 DSMdo(3_3)
+1 DSMdo(4_3)
<= 50

c_u_dsmdoConstraint(4)_:
+1 DSMdo(3_4)
+1 DSMdo(4_4)
+1 DSMdo(5_4)
<= 50

c_u_dsmdoConstraint(5)_:
+1 DSMdo(4_5)
+1 DSMdo(5_5)
+1 DSMdo(6_5)
<= 50

c_u_dsmdoConstraint(6)_:
+1 DSMdo(5_6)
+1 DSMdo(6_6)
+1 DSMdo(7_6)
<= 50

c_u_dsmdoConstraint(7)_:
+1 DSMdo(6_7)
+1 DSMdo(7_7)
+1 DSMdo(8_7)
<= 50

c_u_dsmdoConstraint(8)_:
+1 DSMdo(7_8)
+1 DSMdo(8_8)
+1 DSMdo(9_8)
<= 50

c_u_dsmdoConstraint(9)_:
+1 DSMdo(10_9)
+1 DSMdo(8_9)
+1 DSMdo(9_9)
<= 50

c_u_dsmdoConstraint(10)_:
+1 DSMdo(10_10)
+1 DSMdo(11_10)
+1 DSMdo(9_10)
<= 50

c_u_dsmdoConstraint(11)_:
+1 DSMdo(10_11)
+1 DSMdo(11_11)
+1 DSMdo(12_11)
<= 50

c_u_dsmdoConstraint(12)_:
+1 DSMdo(11_12)
+1 DSMdo(12_12)
+1 DSMdo(13_12)
<= 50

c_u_dsmdoConstraint(13)_:
+1 DSMdo(12_13)
+1 DSMdo(13_13)
+1 DSMdo(14_13)
<= 50

c_u_dsmdoConstraint(14)_:
+1 DSMdo(13_14)
+1 DSMdo(14_14)
+1 DSMdo(15_14)
<= 50

c_u_dsmdoConstraint(15)_:
+1 DSMdo(14_15)
+1 DSMdo(15_15)
+1 DSMdo(16_15)
<= 50

c_u_dsmdoConstraint(16)_:
+1 DSMdo(15_16)
+1 DSMdo(16_16)
+1 DSMdo(17_16)
<= 50

c_u_dsmdoConstraint(17)_:
+1 DSMdo(16_17)
+1 DSMdo(17_17)
+1 DSMdo(18_17)
<= 50

c_u_dsmdoConstraint(18)_:
+1 DSMdo(17_18)
+1 DSMdo(18_18)
+1 DSMdo(19_18)
<= 50

c_u_dsmdoConstraint(19)_:
+1 DSMdo(18_19)
+1 DSMdo(19_19)
+1 DSMdo(20_19)
<= 50

c_u_dsmdoConstraint(20)_:
+1 DSMdo(19_20)
+1 DSMdo(20_20)
+1 DSMdo(21_20)
<= 50

c_u_dsmdoConstraint(21)_:
+1 DSMdo(20_21)
+1 DSMdo(21_21)
+1 DSMdo(22_21)
<= 50

c_u_dsmdoConstraint(22)_:
+1 DSMdo(21_22)
+1 DSMdo(22_22)
+1 DSMdo(23_22)
<= 50

c_u_dsmdoConstraint(23)_:
+1 DSMdo(22_23)
+1 DSMdo(23_23)
+1 DSMdo(24_23)
<= 50

c_u_dsmdoConstraint(24)_:
+1 DSMdo(23_24)
+1 DSMdo(24_24)
+1 DSMdo(25_24)
<= 50

c_u_dsmdoConstraint(25)_:
+1 DSMdo(24_25)
+1 DSMdo(25_25)
+1 DSMdo(26_25)
<= 50

c_u_dsmdoConstraint(26)_:
+1 DSMdo(25_26)
+1 DSMdo(26_26)
<= 50

c_u_C2Constraint(1)_:
+1 DSMdo(1_1)
+1 DSMdo(2_1)
+1 DSMup(1)
<= 50

c_u_C2Constraint(2)_:
+1 DSMdo(1_2)
+1 DSMdo(2_2)
+1 DSMdo(3_2)
+1 DSMup(2)
<= 50

c_u_C2Constraint(3)_:
+1 DSMdo(2_3)
+1 DSMdo(3_3)
+1 DSMdo(4_3)
+1 DSMup(3)
<= 50

c_u_C2Constraint(4)_:
+1 DSMdo(3_4)
+1 DSMdo(4_4)
+1 DSMdo(5_4)
+1 DSMup(4)
<= 50

c_u_C2Constraint(5)_:
+1 DSMdo(4_5)
+1 DSMdo(5_5)
+1 DSMdo(6_5)
+1 DSMup(5)
<= 50

c_u_C2Constraint(6)_:
+1 DSMdo(5_6)
+1 DSMdo(6_6)
+1 DSMdo(7_6)
+1 DSMup(6)
<= 50

c_u_C2Constraint(7)_:
+1 DSMdo(6_7)
+1 DSMdo(7_7)
+1 DSMdo(8_7)
+1 DSMup(7)
<= 50

c_u_C2Constraint(8)_:
+1 DSMdo(7_8)
+1 DSMdo(8_8)
+1 DSMdo(9_8)
+1 DSMup(8)
<= 50

c_u_C2Constraint(9)_:
+1 DSMdo(10_9)
+1 DSMdo(8_9)
+1 DSMdo(9_9)
+1 DSMup(9)
<= 50

c_u_C2Constraint(10)_:
+1 DSMdo(10_10)
+1 DSMdo(11_10)
+1 DSMdo(9_10)
+1 DSMup(10)
<= 50

c_u_C2Constraint(11)_:
+1 DSMdo(10_11)
+1 DSMdo(11_11)
+1 DSMdo(12_11)
+1 DSMup(11)
<= 50

c_u_C2Constraint(12)_:
+1 DSMdo(11_12)
+1 DSMdo(12_12)
+1 DSMdo(13_12)
+1 DSMup(12)
<= 50

c_u_C2Constraint(13)_:
+1 DSMdo(12_13)
+1 DSMdo(13_13)
+1 DSMdo(14_13)
+1 DSMup(13)
<= 50

c_u_C2Constraint(14)_:
+1 DSMdo(13_14)
+1 DSMdo(14_14)
+1 DSMdo(15_14)
+1 DSMup(14)
<= 50

c_u_C2Constraint(15)_:
+1 DSMdo(14_15)
+1 DSMdo(15_15)
+1 DSMdo(16_15)
+1 DSMup(15)
<= 50

c_u_C2Constraint(16)_:
+1 DSMdo(15_16)
+1 DSMdo(16_16)
+1 DSMdo(17_16)
+1 DSMup(16)
<= 50

c_u_C2Constraint(17)_:
+1 DSMdo(16_17)
+1 DSMdo(17_17)
+1 DSMdo(18_17)
+1 DSMup(17)
<= 50

c_u_C2Constraint(18)_:
+1 DSMdo(17_18)
+1 DSMdo(18_18)
+1 DSMdo(19_18)
+1 DSMup(18)
<= 50

c_u_C2Constraint(19)_:
+1 DSMdo(18_19)
+1 DSMdo(19_19)
+1 DSMdo(20_19)
+1 DSMup(19)
<= 50

c_u_C2Constraint(20)_:
+1 DSMdo(19_20)
+1 DSMdo(20_20)
+1 DSMdo(21_20)
+1 DSMup(20)
<= 50

c_u_C2Constraint(21)_:
+1 DSMdo(20_21)
+1 DSMdo(21_21)
+1 DSMdo(22_21)
+1 DSMup(21)
<= 50

c_u_C2Constraint(22)_:
+1 DSMdo(21_22)
+1 DSMdo(22_22)
+1 DSMdo(23_22)
+1 DSMup(22)
<= 50

c_u_C2Constraint(23)_:
+1 DSMdo(22_23)
+1 DSMdo(23_23)
+1 DSMdo(24_23)
+1 DSMup(23)
<= 50

c_u_C2Constraint(24)_:
+1 DSMdo(23_24)
+1 DSMdo(24_24)
+1 DSMdo(25_24)
+1 DSMup(24)
<= 50

c_u_C2Constraint(25)_:
+1 DSMdo(24_25)
+1 DSMdo(25_25)
+1 DSMdo(26_25)
+1 DSMup(25)
<= 50

c_u_C2Constraint(26)_:
+1 DSMdo(25_26)
+1 DSMdo(26_26)
+1 DSMup(26)
<= 50

c_u_power1Constraint(1)_:
+1 P1(1)
<= 100

c_u_power1Constraint(2)_:
+1 P1(2)
<= 100

c_u_power1Constraint(3)_:
+1 P1(3)
<= 100

c_u_power1Constraint(4)_:
+1 P1(4)
<= 100

c_u_power1Constraint(5)_:
+1 P1(5)
<= 100

c_u_power1Constraint(6)_:
+1 P1(6)
<= 100

c_u_power1Constraint(7)_:
+1 P1(7)
<= 100

c_u_power1Constraint(8)_:
+1 P1(8)
<= 100

c_u_power1Constraint(9)_:
+1 P1(9)
<= 100

c_u_power1Constraint(10)_:
+1 P1(10)
<= 100

c_u_power1Constraint(11)_:
+1 P1(11)
<= 100

c_u_power1Constraint(12)_:
+1 P1(12)
<= 100

c_u_power1Constraint(13)_:
+1 P1(13)
<= 100

c_u_power1Constraint(14)_:
+1 P1(14)
<= 100

c_u_power1Constraint(15)_:
+1 P1(15)
<= 100

c_u_power1Constraint(16)_:
+1 P1(16)
<= 100

c_u_power1Constraint(17)_:
+1 P1(17)
<= 100

c_u_power1Constraint(18)_:
+1 P1(18)
<= 100

c_u_power1Constraint(19)_:
+1 P1(19)
<= 100

c_u_power1Constraint(20)_:
+1 P1(20)
<= 100

c_u_power1Constraint(21)_:
+1 P1(21)
<= 100

c_u_power1Constraint(22)_:
+1 P1(22)
<= 100

c_u_power1Constraint(23)_:
+1 P1(23)
<= 100

c_u_power1Constraint(24)_:
+1 P1(24)
<= 100

c_u_power1Constraint(25)_:
+1 P1(25)
<= 100

c_u_power1Constraint(26)_:
+1 P1(26)
<= 100

c_u_power2Constraint(1)_:
+1 P2(1)
<= 100

c_u_power2Constraint(2)_:
+1 P2(2)
<= 100

c_u_power2Constraint(3)_:
+1 P2(3)
<= 100

c_u_power2Constraint(4)_:
+1 P2(4)
<= 100

c_u_power2Constraint(5)_:
+1 P2(5)
<= 100

c_u_power2Constraint(6)_:
+1 P2(6)
<= 100

c_u_power2Constraint(7)_:
+1 P2(7)
<= 100

c_u_power2Constraint(8)_:
+1 P2(8)
<= 100

c_u_power2Constraint(9)_:
+1 P2(9)
<= 100

c_u_power2Constraint(10)_:
+1 P2(10)
<= 100

c_u_power2Constraint(11)_:
+1 P2(11)
<= 100

c_u_power2Constraint(12)_:
+1 P2(12)
<= 100

c_u_power2Constraint(13)_:
+1 P2(13)
<= 100

c_u_power2Constraint(14)_:
+1 P2(14)
<= 100

c_u_power2Constraint(15)_:
+1 P2(15)
<= 100

c_u_power2Constraint(16)_:
+1 P2(16)
<= 100

c_u_power2Constraint(17)_:
+1 P2(17)
<= 100

c_u_power2Constraint(18)_:
+1 P2(18)
<= 100

c_u_power2Constraint(19)_:
+1 P2(19)
<= 100

c_u_power2Constraint(20)_:
+1 P2(20)
<= 100

c_u_power2Constraint(21)_:
+1 P2(21)
<= 100

c_u_power2Constraint(22)_:
+1 P2(22)
<= 100

c_u_power2Constraint(23)_:
+1 P2(23)
<= 100

c_u_power2Constraint(24)_:
+1 P2(24)
<= 100

c_u_power2Constraint(25)_:
+1 P2(25)
<= 100

c_u_power2Constraint(26)_:
+1 P2(26)
<= 100

c_e_ONE_VAR_CONSTANT: 
ONE_VAR_CONSTANT = 1.0

bounds
   0 <= DSMdo(1_1) <= +inf
   0 <= DSMdo(1_2) <= +inf
   0 <= DSMdo(2_1) <= +inf
   0 <= DSMdo(2_2) <= +inf
   0 <= DSMdo(2_3) <= +inf
   0 <= DSMdo(3_2) <= +inf
   0 <= DSMdo(3_3) <= +inf
   0 <= DSMdo(3_4) <= +inf
   0 <= DSMdo(4_3) <= +inf
   0 <= DSMdo(4_4) <= +inf
   0 <= DSMdo(4_5) <= +inf
   0 <= DSMdo(5_4) <= +inf
   0 <= DSMdo(5_5) <= +inf
   0 <= DSMdo(5_6) <= +inf
   0 <= DSMdo(6_5) <= +inf
   0 <= DSMdo(6_6) <= +inf
   0 <= DSMdo(6_7) <= +inf
   0 <= DSMdo(7_6) <= +inf
   0 <= DSMdo(7_7) <= +inf
   0 <= DSMdo(7_8) <= +inf
   0 <= DSMdo(8_7) <= +inf
   0 <= DSMdo(8_8) <= +inf
   0 <= DSMdo(8_9) <= +inf
   0 <= DSMdo(9_8) <= +inf
   0 <= DSMdo(9_9) <= +inf
   0 <= DSMdo(9_10) <= +inf
   0 <= DSMdo(10_9) <= +inf
   0 <= DSMdo(10_10) <= +inf
   0 <= DSMdo(10_11) <= +inf
   0 <= DSMdo(11_10) <= +inf
   0 <= DSMdo(11_11) <= +inf
   0 <= DSMdo(11_12) <= +inf
   0 <= DSMdo(12_11) <= +inf
   0 <= DSMdo(12_12) <= +inf
   0 <= DSMdo(12_13) <= +inf
   0 <= DSMdo(13_12) <= +inf
   0 <= DSMdo(13_13) <= +inf
   0 <= DSMdo(13_14) <= +inf
   0 <= DSMdo(14_13) <= +inf
   0 <= DSMdo(14_14) <= +inf
   0 <= DSMdo(14_15) <= +inf
   0 <= DSMdo(15_14) <= +inf
   0 <= DSMdo(15_15) <= +inf
   0 <= DSMdo(15_16) <= +inf
   0 <= DSMdo(16_15) <= +inf
   0 <= DSMdo(16_16) <= +inf
   0 <= DSMdo(16_17) <= +inf
   0 <= DSMdo(17_16) <= +inf
   0 <= DSMdo(17_17) <= +inf
   0 <= DSMdo(17_18) <= +inf
   0 <= DSMdo(18_17) <= +inf
   0 <= DSMdo(18_18) <= +inf
   0 <= DSMdo(18_19) <= +inf
   0 <= DSMdo(19_18) <= +inf
   0 <= DSMdo(19_19) <= +inf
   0 <= DSMdo(19_20) <= +inf
   0 <= DSMdo(20_19) <= +inf
   0 <= DSMdo(20_20) <= +inf
   0 <= DSMdo(20_21) <= +inf
   0 <= DSMdo(21_20) <= +inf
   0 <= DSMdo(21_21) <= +inf
   0 <= DSMdo(21_22) <= +inf
   0 <= DSMdo(22_21) <= +inf
   0 <= DSMdo(22_22) <= +inf
   0 <= DSMdo(22_23) <= +inf
   0 <= DSMdo(23_22) <= +inf
   0 <= DSMdo(23_23) <= +inf
   0 <= DSMdo(23_24) <= +inf
   0 <= DSMdo(24_23) <= +inf
   0 <= DSMdo(24_24) <= +inf
   0 <= DSMdo(24_25) <= +inf
   0 <= DSMdo(25_24) <= +inf
   0 <= DSMdo(25_25) <= +inf
   0 <= DSMdo(25_26) <= +inf
   0 <= DSMdo(26_25) <= +inf
   0 <= DSMdo(26_26) <= +inf
   0 <= DSMup(1) <= +inf
   0 <= DSMup(2) <= +inf
   0 <= DSMup(3) <= +inf
   0 <= DSMup(4) <= +inf
   0 <= DSMup(5) <= +inf
   0 <= DSMup(6) <= +inf
   0 <= DSMup(7) <= +inf
   0 <= DSMup(8) <= +inf
   0 <= DSMup(9) <= +inf
   0 <= DSMup(10) <= +inf
   0 <= DSMup(11) <= +inf
   0 <= DSMup(12) <= +inf
   0 <= DSMup(13) <= +inf
   0 <= DSMup(14) <= +inf
   0 <= DSMup(15) <= +inf
   0 <= DSMup(16) <= +inf
   0 <= DSMup(17) <= +inf
   0 <= DSMup(18) <= +inf
   0 <= DSMup(19) <= +inf
   0 <= DSMup(20) <= +inf
   0 <= DSMup(21) <= +inf
   0 <= DSMup(22) <= +inf
   0 <= DSMup(23) <= +inf
   0 <= DSMup(24) <= +inf
   0 <= DSMup(25) <= +inf
   0 <= DSMup(26) <= +inf
   0 <= P1(1) <= +inf
   0 <= P1(2) <= +inf
   0 <= P1(3) <= +inf
   0 <= P1(4) <= +inf
   0 <= P1(5) <= +inf
   0 <= P1(6) <= +inf
   0 <= P1(7) <= +inf
   0 <= P1(8) <= +inf
   0 <= P1(9) <= +inf
   0 <= P1(10) <= +inf
   0 <= P1(11) <= +inf
   0 <= P1(12) <= +inf
   0 <= P1(13) <= +inf
   0 <= P1(14) <= +inf
   0 <= P1(15) <= +inf
   0 <= P1(16) <= +inf
   0 <= P1(17) <= +inf
   0 <= P1(18) <= +inf
   0 <= P1(19) <= +inf
   0 <= P1(20) <= +inf
   0 <= P1(21) <= +inf
   0 <= P1(22) <= +inf
   0 <= P1(23) <= +inf
   0 <= P1(24) <= +inf
   0 <= P1(25) <= +inf
   0 <= P1(26) <= +inf
   0 <= P2(1) <= +inf
   0 <= P2(2) <= +inf
   0 <= P2(3) <= +inf
   0 <= P2(4) <= +inf
   0 <= P2(5) <= +inf
   0 <= P2(6) <= +inf
   0 <= P2(7) <= +inf
   0 <= P2(8) <= +inf
   0 <= P2(9) <= +inf
   0 <= P2(10) <= +inf
   0 <= P2(11) <= +inf
   0 <= P2(12) <= +inf
   0 <= P2(13) <= +inf
   0 <= P2(14) <= +inf
   0 <= P2(15) <= +inf
   0 <= P2(16) <= +inf
   0 <= P2(17) <= +inf
   0 <= P2(18) <= +inf
   0 <= P2(19) <= +inf
   0 <= P2(20) <= +inf
   0 <= P2(21) <= +inf
   0 <= P2(22) <= +inf
   0 <= P2(23) <= +inf
   0 <= P2(24) <= +inf
   0 <= P2(25) <= +inf
   0 <= P2(26) <= +inf
end
