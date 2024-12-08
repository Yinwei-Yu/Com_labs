addi x1,x0,5 #x1=5

andi x2,x1,0x1 #x2=5&1=1

ori x3,x1,0x1 #x3=5|1=5

xori x4,x1,0x1 #x4=5^1=4

slli x5,x1,1 #x5=5<<1=10

srli x6,x1,1 #x6=5>>1=2
lui x1,0x80000
srai x7,x1,1 #x7=0x80000>>1=0xc0000

slti x8,x2,1 #x8=1<1=0

sltiu x9,x2,1 #x9=1<1=0


