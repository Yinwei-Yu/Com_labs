addi x1,x0,5
addi x2,x0,4

add x3,x1,x2 #x3=5+4=9
sub x4,x1,x2 #x4=5-4=1
sub x5,x2,x1 #x5=4-5=-1

and x6,x1,x2 #x6=5&4=4
or x7,x1,x2 #x7=5|4=5
xor x8,x1,x2 #x8=5^4=1
sll x9,x1,x2 #x9=5<<4=80
lui x10,0x80000
srl x11,x10,x2 #x11=0x80000>>4=0x8000
sra x12,x10,x2 #x12=0x80000>>4=0xf8000

addi x1,x0,-1
addi x2,x0,1
slt x13,x1,x2 #x13=-1<1=1
sltu x14,x1,x2 #x14=-1<1=0




