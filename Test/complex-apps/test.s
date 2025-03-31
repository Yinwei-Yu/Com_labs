
test:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <start>:
   0:	ff010113          	addi	sp,sp,-16
   4:	00112623          	sw	ra,12(sp)
   8:	00812423          	sw	s0,8(sp)
   c:	01010413          	addi	s0,sp,16
  10:	40000113          	li	sp,1024
  14:	058000ef          	jal	6c <main>
  18:	00000013          	nop
  1c:	00c12083          	lw	ra,12(sp)
  20:	00812403          	lw	s0,8(sp)
  24:	01010113          	addi	sp,sp,16
  28:	00008067          	ret

0000002c <wait>:
  2c:	fe010113          	addi	sp,sp,-32
  30:	00112e23          	sw	ra,28(sp)
  34:	00812c23          	sw	s0,24(sp)
  38:	02010413          	addi	s0,sp,32
  3c:	fea42623          	sw	a0,-20(s0)
  40:	00000013          	nop
  44:	fec42783          	lw	a5,-20(s0)
  48:	fff78713          	addi	a4,a5,-1
  4c:	fee42623          	sw	a4,-20(s0)
  50:	fe079ae3          	bnez	a5,44 <wait+0x18>
  54:	00000013          	nop
  58:	00000013          	nop
  5c:	01c12083          	lw	ra,28(sp)
  60:	01812403          	lw	s0,24(sp)
  64:	02010113          	addi	sp,sp,32
  68:	00008067          	ret

0000006c <main>:
  6c:	fe010113          	addi	sp,sp,-32
  70:	00112e23          	sw	ra,28(sp)
  74:	00812c23          	sw	s0,24(sp)
  78:	02010413          	addi	s0,sp,32
  7c:	f00007b7          	lui	a5,0xf0000
  80:	0007d783          	lhu	a5,0(a5) # f0000000 <__global_pointer$+0xefffe58c>
  84:	fef41723          	sh	a5,-18(s0)
  88:	fee45783          	lhu	a5,-18(s0)
  8c:	0037f793          	andi	a5,a5,3
  90:	00100713          	li	a4,1
  94:	00e78863          	beq	a5,a4,a4 <main+0x38>
  98:	00200713          	li	a4,2
  9c:	00e78863          	beq	a5,a4,ac <main+0x40>
  a0:	0140006f          	j	b4 <main+0x48>
  a4:	028000ef          	jal	cc <display_love>
  a8:	0200006f          	j	c8 <main+0x5c>
  ac:	134000ef          	jal	1e0 <display_fib>
  b0:	0180006f          	j	c8 <main+0x5c>
  b4:	e00007b7          	lui	a5,0xe0000
  b8:	c7c0c737          	lui	a4,0xc7c0c
  bc:	18670713          	addi	a4,a4,390 # c7c0c186 <__global_pointer$+0xc7c0a712>
  c0:	00e7a023          	sw	a4,0(a5) # e0000000 <__global_pointer$+0xdfffe58c>
  c4:	00000013          	nop
  c8:	fb5ff06f          	j	7c <main+0x10>

000000cc <display_love>:
  cc:	ff010113          	addi	sp,sp,-16
  d0:	00112623          	sw	ra,12(sp)
  d4:	00812423          	sw	s0,8(sp)
  d8:	01010413          	addi	s0,sp,16
  dc:	0540006f          	j	130 <display_love+0x64>
  e0:	e00007b7          	lui	a5,0xe0000
  e4:	ff900713          	li	a4,-7
  e8:	00e7a023          	sw	a4,0(a5) # e0000000 <__global_pointer$+0xdfffe58c>
  ec:	002dc7b7          	lui	a5,0x2dc
  f0:	6c078513          	addi	a0,a5,1728 # 2dc6c0 <__global_pointer$+0x2dac4c>
  f4:	f39ff0ef          	jal	2c <wait>
  f8:	e00007b7          	lui	a5,0xe0000
  fc:	c7c0c737          	lui	a4,0xc7c0c
 100:	18670713          	addi	a4,a4,390 # c7c0c186 <__global_pointer$+0xc7c0a712>
 104:	00e7a023          	sw	a4,0(a5) # e0000000 <__global_pointer$+0xdfffe58c>
 108:	002dc7b7          	lui	a5,0x2dc
 10c:	6c078513          	addi	a0,a5,1728 # 2dc6c0 <__global_pointer$+0x2dac4c>
 110:	f1dff0ef          	jal	2c <wait>
 114:	e00007b7          	lui	a5,0xe0000
 118:	ff91c737          	lui	a4,0xff91c
 11c:	0c170713          	addi	a4,a4,193 # ff91c0c1 <__global_pointer$+0xff91a64d>
 120:	00e7a023          	sw	a4,0(a5) # e0000000 <__global_pointer$+0xdfffe58c>
 124:	002dc7b7          	lui	a5,0x2dc
 128:	6c078513          	addi	a0,a5,1728 # 2dc6c0 <__global_pointer$+0x2dac4c>
 12c:	f01ff0ef          	jal	2c <wait>
 130:	f00007b7          	lui	a5,0xf0000
 134:	0007d783          	lhu	a5,0(a5) # f0000000 <__global_pointer$+0xefffe58c>
 138:	01079793          	slli	a5,a5,0x10
 13c:	0107d793          	srli	a5,a5,0x10
 140:	0037f713          	andi	a4,a5,3
 144:	00100793          	li	a5,1
 148:	f8f70ce3          	beq	a4,a5,e0 <display_love+0x14>
 14c:	00000013          	nop
 150:	00000013          	nop
 154:	00c12083          	lw	ra,12(sp)
 158:	00812403          	lw	s0,8(sp)
 15c:	01010113          	addi	sp,sp,16
 160:	00008067          	ret

00000164 <calculate_fib>:
 164:	fd010113          	addi	sp,sp,-48
 168:	02112623          	sw	ra,44(sp)
 16c:	02812423          	sw	s0,40(sp)
 170:	03010413          	addi	s0,sp,48
 174:	00050793          	mv	a5,a0
 178:	fcf40fa3          	sb	a5,-33(s0)
 17c:	fe042623          	sw	zero,-20(s0)
 180:	00100793          	li	a5,1
 184:	fef42423          	sw	a5,-24(s0)
 188:	fe0403a3          	sb	zero,-25(s0)
 18c:	0300006f          	j	1bc <calculate_fib+0x58>
 190:	fec42703          	lw	a4,-20(s0)
 194:	fe842783          	lw	a5,-24(s0)
 198:	00f707b3          	add	a5,a4,a5
 19c:	fef42023          	sw	a5,-32(s0)
 1a0:	fe842783          	lw	a5,-24(s0)
 1a4:	fef42623          	sw	a5,-20(s0)
 1a8:	fe042783          	lw	a5,-32(s0)
 1ac:	fef42423          	sw	a5,-24(s0)
 1b0:	fe744783          	lbu	a5,-25(s0)
 1b4:	00178793          	addi	a5,a5,1
 1b8:	fef403a3          	sb	a5,-25(s0)
 1bc:	fe744703          	lbu	a4,-25(s0)
 1c0:	fdf44783          	lbu	a5,-33(s0)
 1c4:	fcf766e3          	bltu	a4,a5,190 <calculate_fib+0x2c>
 1c8:	fec42783          	lw	a5,-20(s0)
 1cc:	00078513          	mv	a0,a5
 1d0:	02c12083          	lw	ra,44(sp)
 1d4:	02812403          	lw	s0,40(sp)
 1d8:	03010113          	addi	sp,sp,48
 1dc:	00008067          	ret

000001e0 <display_fib>:
 1e0:	fe010113          	addi	sp,sp,-32
 1e4:	00112e23          	sw	ra,28(sp)
 1e8:	00812c23          	sw	s0,24(sp)
 1ec:	00912a23          	sw	s1,20(sp)
 1f0:	02010413          	addi	s0,sp,32
 1f4:	0480006f          	j	23c <display_fib+0x5c>
 1f8:	f00007b7          	lui	a5,0xf0000
 1fc:	0007d783          	lhu	a5,0(a5) # f0000000 <__global_pointer$+0xefffe58c>
 200:	01079793          	slli	a5,a5,0x10
 204:	0107d793          	srli	a5,a5,0x10
 208:	0087d793          	srli	a5,a5,0x8
 20c:	01079793          	slli	a5,a5,0x10
 210:	0107d793          	srli	a5,a5,0x10
 214:	fef407a3          	sb	a5,-17(s0)
 218:	e00004b7          	lui	s1,0xe0000
 21c:	fef44783          	lbu	a5,-17(s0)
 220:	00078513          	mv	a0,a5
 224:	f41ff0ef          	jal	164 <calculate_fib>
 228:	00050793          	mv	a5,a0
 22c:	00f4a023          	sw	a5,0(s1) # e0000000 <__global_pointer$+0xdfffe58c>
 230:	003d17b7          	lui	a5,0x3d1
 234:	90078513          	addi	a0,a5,-1792 # 3d0900 <__global_pointer$+0x3cee8c>
 238:	df5ff0ef          	jal	2c <wait>
 23c:	f00007b7          	lui	a5,0xf0000
 240:	0007d783          	lhu	a5,0(a5) # f0000000 <__global_pointer$+0xefffe58c>
 244:	01079793          	slli	a5,a5,0x10
 248:	0107d793          	srli	a5,a5,0x10
 24c:	0037f713          	andi	a4,a5,3
 250:	00200793          	li	a5,2
 254:	faf702e3          	beq	a4,a5,1f8 <display_fib+0x18>
 258:	00000013          	nop
 25c:	00000013          	nop
 260:	01c12083          	lw	ra,28(sp)
 264:	01812403          	lw	s0,24(sp)
 268:	01412483          	lw	s1,20(sp)
 26c:	02010113          	addi	sp,sp,32
 270:	00008067          	ret
