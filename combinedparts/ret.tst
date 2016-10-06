JUMP late
LOAD s0, s0
LOAD s0, s0
retk: LOAD&RETURN s0, 01
OUTPUT sF, 00
retz: ADD s6, s6
RETURN Z
late: CALL Z, retk
OUTPUT s0, 00
ADD s6, 01
CALL NZ, retz
OUTPUT s6, 00
CALL Z, retz
OUTPUT s6, 00
RETURN Z
death: JUMP death