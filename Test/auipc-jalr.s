addi x10,x0,1
addi x11,x0,2
jal x1,PLUS
addi x12,x0,-1 # x12=-1
jal x1,END
PLUS:
add x10,x10,x11 # x10=3
jalr x0,0(x1)
END: