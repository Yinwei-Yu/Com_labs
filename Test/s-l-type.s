addi x1 x0 0	
lui x2,0x18348
addi x2,x2,0x688
sb x2 0(x1)
sh x2 4(x1)
sw x2 8(x1)	
lb x3 0(x1)	
lh x4 4(x1)	
lw x5 8(x1)	
lbu x6 0(x1)
lhu x7 4(x1)