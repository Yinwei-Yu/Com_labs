addi x1,x0,10
addi x2,x0,10
addi x3,x0,20

addi x4,x0,-1

#beq
beq x1,x2,equal
addi x5,x0,0 # x5=1
equback:

#bne
bne x1,x3,nonequal
addi x6,x0,0 # x6 =2
nonequalback:

#blt
blt x3,x1,Less 
addi x7,x0,3 # x7=3
bltback:

#bltu
bltu x1,x4,bltu
addi x8,x0,0 # x8=4
jal x1,END
bltuback:

#bge
bge x3,x1,bge
addi x9,x0,0 # x9=5
bgeback:

#bgeu
bgeu x1,x4,bgeu
addi x10,x0,6 # x10=6
bgeuback:

jal x0,END

############################################
#accessing the labels
#beq
equal:
addi x5,x0,1
jal x0,equback

#bne
nonequal:
addi x6,x0,2
jal x0,nonequalback

#blt
Less:
addi x7,x0,0
jal x0,bltback

#bltu
bltu:
addi x8,x0,4
jal x0,bltuback

#bge
bge:
addi x9,x0,5
jal x0,bgeback

#bgeu
bgeu:
addi x10,x0,0
jal x0,bgeuback

END: