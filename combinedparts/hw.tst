fail: ADD s0, s0
HWBUILD s1
OUTPUT s1, 00
JUMP C, death
JUMP NC, fail
death: JUMP death