
test:     file format elf32-littleriscv


Disassembly of section .text:

00000020 <start>:
  20:	ff010113          	addi	sp,sp,-16
  24:	00112623          	sw	ra,12(sp)
  28:	00812423          	sw	s0,8(sp)
  2c:	01010413          	addi	s0,sp,16
  30:	40000113          	li	sp,1024
  34:	548000ef          	jal	57c <main>
  38:	00000013          	nop
  3c:	00c12083          	lw	ra,12(sp)
  40:	00812403          	lw	s0,8(sp)
  44:	01010113          	addi	sp,sp,16
  48:	00008067          	ret

0000004c <wait>:
  4c:	fe010113          	addi	sp,sp,-32
  50:	00112e23          	sw	ra,28(sp)
  54:	00812c23          	sw	s0,24(sp)
  58:	02010413          	addi	s0,sp,32
  5c:	fea42623          	sw	a0,-20(s0)
  60:	00000013          	nop
  64:	fec42783          	lw	a5,-20(s0)
  68:	fff78713          	addi	a4,a5,-1
  6c:	fee42623          	sw	a4,-20(s0)
  70:	fe079ae3          	bnez	a5,64 <wait+0x18>
  74:	00000013          	nop
  78:	00000013          	nop
  7c:	01c12083          	lw	ra,28(sp)
  80:	01812403          	lw	s0,24(sp)
  84:	02010113          	addi	sp,sp,32
  88:	00008067          	ret

0000008c <draw_color_bars>:
  8c:	fb010113          	addi	sp,sp,-80
  90:	04112623          	sw	ra,76(sp)
  94:	04812423          	sw	s0,72(sp)
  98:	05010413          	addi	s0,sp,80
  9c:	fe042623          	sw	zero,-20(s0)
  a0:	5b400793          	li	a5,1460
  a4:	0007a883          	lw	a7,0(a5)
  a8:	0047a803          	lw	a6,4(a5)
  ac:	0087a503          	lw	a0,8(a5)
  b0:	00c7a583          	lw	a1,12(a5)
  b4:	0107a603          	lw	a2,16(a5)
  b8:	0147a683          	lw	a3,20(a5)
  bc:	0187a703          	lw	a4,24(a5)
  c0:	01c7a783          	lw	a5,28(a5)
  c4:	fb142c23          	sw	a7,-72(s0)
  c8:	fb042e23          	sw	a6,-68(s0)
  cc:	fca42023          	sw	a0,-64(s0)
  d0:	fcb42223          	sw	a1,-60(s0)
  d4:	fcc42423          	sw	a2,-56(s0)
  d8:	fcd42623          	sw	a3,-52(s0)
  dc:	fce42823          	sw	a4,-48(s0)
  e0:	fcf42a23          	sw	a5,-44(s0)
  e4:	fe042423          	sw	zero,-24(s0)
  e8:	1600006f          	j	248 <draw_color_bars+0x1bc>
  ec:	fe842703          	lw	a4,-24(s0)
  f0:	03b00793          	li	a5,59
  f4:	00e7c663          	blt	a5,a4,100 <draw_color_bars+0x74>
  f8:	fe042223          	sw	zero,-28(s0)
  fc:	09c0006f          	j	198 <draw_color_bars+0x10c>
 100:	fe842703          	lw	a4,-24(s0)
 104:	07700793          	li	a5,119
 108:	00e7c863          	blt	a5,a4,118 <draw_color_bars+0x8c>
 10c:	00100793          	li	a5,1
 110:	fef42223          	sw	a5,-28(s0)
 114:	0840006f          	j	198 <draw_color_bars+0x10c>
 118:	fe842703          	lw	a4,-24(s0)
 11c:	0b300793          	li	a5,179
 120:	00e7c863          	blt	a5,a4,130 <draw_color_bars+0xa4>
 124:	00200793          	li	a5,2
 128:	fef42223          	sw	a5,-28(s0)
 12c:	06c0006f          	j	198 <draw_color_bars+0x10c>
 130:	fe842703          	lw	a4,-24(s0)
 134:	0ef00793          	li	a5,239
 138:	00e7c863          	blt	a5,a4,148 <draw_color_bars+0xbc>
 13c:	00300793          	li	a5,3
 140:	fef42223          	sw	a5,-28(s0)
 144:	0540006f          	j	198 <draw_color_bars+0x10c>
 148:	fe842703          	lw	a4,-24(s0)
 14c:	12b00793          	li	a5,299
 150:	00e7c863          	blt	a5,a4,160 <draw_color_bars+0xd4>
 154:	00400793          	li	a5,4
 158:	fef42223          	sw	a5,-28(s0)
 15c:	03c0006f          	j	198 <draw_color_bars+0x10c>
 160:	fe842703          	lw	a4,-24(s0)
 164:	16700793          	li	a5,359
 168:	00e7c863          	blt	a5,a4,178 <draw_color_bars+0xec>
 16c:	00500793          	li	a5,5
 170:	fef42223          	sw	a5,-28(s0)
 174:	0240006f          	j	198 <draw_color_bars+0x10c>
 178:	fe842703          	lw	a4,-24(s0)
 17c:	1a300793          	li	a5,419
 180:	00e7c863          	blt	a5,a4,190 <draw_color_bars+0x104>
 184:	00600793          	li	a5,6
 188:	fef42223          	sw	a5,-28(s0)
 18c:	00c0006f          	j	198 <draw_color_bars+0x10c>
 190:	00700793          	li	a5,7
 194:	fef42223          	sw	a5,-28(s0)
 198:	fe442703          	lw	a4,-28(s0)
 19c:	fb840793          	addi	a5,s0,-72
 1a0:	00271713          	slli	a4,a4,0x2
 1a4:	00f707b3          	add	a5,a4,a5
 1a8:	0007a783          	lw	a5,0(a5)
 1ac:	fcf42e23          	sw	a5,-36(s0)
 1b0:	fe042023          	sw	zero,-32(s0)
 1b4:	07c0006f          	j	230 <draw_color_bars+0x1a4>
 1b8:	fdc42783          	lw	a5,-36(s0)
 1bc:	fcf42c23          	sw	a5,-40(s0)
 1c0:	fd842783          	lw	a5,-40(s0)
 1c4:	00479793          	slli	a5,a5,0x4
 1c8:	fdc42703          	lw	a4,-36(s0)
 1cc:	00f767b3          	or	a5,a4,a5
 1d0:	fcf42c23          	sw	a5,-40(s0)
 1d4:	fd842783          	lw	a5,-40(s0)
 1d8:	00479793          	slli	a5,a5,0x4
 1dc:	fdc42703          	lw	a4,-36(s0)
 1e0:	00f767b3          	or	a5,a4,a5
 1e4:	fcf42c23          	sw	a5,-40(s0)
 1e8:	fd842783          	lw	a5,-40(s0)
 1ec:	00479793          	slli	a5,a5,0x4
 1f0:	fdc42703          	lw	a4,-36(s0)
 1f4:	00f767b3          	or	a5,a4,a5
 1f8:	fcf42c23          	sw	a5,-40(s0)
 1fc:	000017b7          	lui	a5,0x1
 200:	5f07a703          	lw	a4,1520(a5) # 15f0 <vram>
 204:	fec42783          	lw	a5,-20(s0)
 208:	00279793          	slli	a5,a5,0x2
 20c:	00f707b3          	add	a5,a4,a5
 210:	fd842703          	lw	a4,-40(s0)
 214:	00e7a023          	sw	a4,0(a5)
 218:	fec42783          	lw	a5,-20(s0)
 21c:	00178793          	addi	a5,a5,1
 220:	fef42623          	sw	a5,-20(s0)
 224:	fe042783          	lw	a5,-32(s0)
 228:	00278793          	addi	a5,a5,2
 22c:	fef42023          	sw	a5,-32(s0)
 230:	fe042703          	lw	a4,-32(s0)
 234:	27f00793          	li	a5,639
 238:	f8e7d0e3          	bge	a5,a4,1b8 <draw_color_bars+0x12c>
 23c:	fe842783          	lw	a5,-24(s0)
 240:	00178793          	addi	a5,a5,1
 244:	fef42423          	sw	a5,-24(s0)
 248:	fe842703          	lw	a4,-24(s0)
 24c:	1df00793          	li	a5,479
 250:	e8e7dee3          	bge	a5,a4,ec <draw_color_bars+0x60>
 254:	00000013          	nop
 258:	00000013          	nop
 25c:	04c12083          	lw	ra,76(sp)
 260:	04812403          	lw	s0,72(sp)
 264:	05010113          	addi	sp,sp,80
 268:	00008067          	ret

0000026c <draw_rainbow_diagonal>:
 26c:	fb010113          	addi	sp,sp,-80
 270:	04112623          	sw	ra,76(sp)
 274:	04812423          	sw	s0,72(sp)
 278:	05010413          	addi	s0,sp,80
 27c:	fe042623          	sw	zero,-20(s0)
 280:	5d400793          	li	a5,1492
 284:	0007a803          	lw	a6,0(a5)
 288:	0047a503          	lw	a0,4(a5)
 28c:	0087a583          	lw	a1,8(a5)
 290:	00c7a603          	lw	a2,12(a5)
 294:	0107a683          	lw	a3,16(a5)
 298:	0147a703          	lw	a4,20(a5)
 29c:	0187a783          	lw	a5,24(a5)
 2a0:	fb042c23          	sw	a6,-72(s0)
 2a4:	faa42e23          	sw	a0,-68(s0)
 2a8:	fcb42023          	sw	a1,-64(s0)
 2ac:	fcc42223          	sw	a2,-60(s0)
 2b0:	fcd42423          	sw	a3,-56(s0)
 2b4:	fce42623          	sw	a4,-52(s0)
 2b8:	fcf42823          	sw	a5,-48(s0)
 2bc:	fe042423          	sw	zero,-24(s0)
 2c0:	15c0006f          	j	41c <draw_rainbow_diagonal+0x1b0>
 2c4:	fe042223          	sw	zero,-28(s0)
 2c8:	13c0006f          	j	404 <draw_rainbow_diagonal+0x198>
 2cc:	fe442703          	lw	a4,-28(s0)
 2d0:	fe842783          	lw	a5,-24(s0)
 2d4:	00f707b3          	add	a5,a4,a5
 2d8:	1ff7f793          	andi	a5,a5,511
 2dc:	fcf42e23          	sw	a5,-36(s0)
 2e0:	fdc42703          	lw	a4,-36(s0)
 2e4:	04800793          	li	a5,72
 2e8:	00e7e663          	bltu	a5,a4,2f4 <draw_rainbow_diagonal+0x88>
 2ec:	fe042023          	sw	zero,-32(s0)
 2f0:	0840006f          	j	374 <draw_rainbow_diagonal+0x108>
 2f4:	fdc42703          	lw	a4,-36(s0)
 2f8:	09100793          	li	a5,145
 2fc:	00e7e863          	bltu	a5,a4,30c <draw_rainbow_diagonal+0xa0>
 300:	00100793          	li	a5,1
 304:	fef42023          	sw	a5,-32(s0)
 308:	06c0006f          	j	374 <draw_rainbow_diagonal+0x108>
 30c:	fdc42703          	lw	a4,-36(s0)
 310:	0da00793          	li	a5,218
 314:	00e7e863          	bltu	a5,a4,324 <draw_rainbow_diagonal+0xb8>
 318:	00200793          	li	a5,2
 31c:	fef42023          	sw	a5,-32(s0)
 320:	0540006f          	j	374 <draw_rainbow_diagonal+0x108>
 324:	fdc42703          	lw	a4,-36(s0)
 328:	12300793          	li	a5,291
 32c:	00e7e863          	bltu	a5,a4,33c <draw_rainbow_diagonal+0xd0>
 330:	00300793          	li	a5,3
 334:	fef42023          	sw	a5,-32(s0)
 338:	03c0006f          	j	374 <draw_rainbow_diagonal+0x108>
 33c:	fdc42703          	lw	a4,-36(s0)
 340:	16c00793          	li	a5,364
 344:	00e7e863          	bltu	a5,a4,354 <draw_rainbow_diagonal+0xe8>
 348:	00400793          	li	a5,4
 34c:	fef42023          	sw	a5,-32(s0)
 350:	0240006f          	j	374 <draw_rainbow_diagonal+0x108>
 354:	fdc42703          	lw	a4,-36(s0)
 358:	1b500793          	li	a5,437
 35c:	00e7e863          	bltu	a5,a4,36c <draw_rainbow_diagonal+0x100>
 360:	00500793          	li	a5,5
 364:	fef42023          	sw	a5,-32(s0)
 368:	00c0006f          	j	374 <draw_rainbow_diagonal+0x108>
 36c:	00600793          	li	a5,6
 370:	fef42023          	sw	a5,-32(s0)
 374:	fe042703          	lw	a4,-32(s0)
 378:	fb840793          	addi	a5,s0,-72
 37c:	00271713          	slli	a4,a4,0x2
 380:	00f707b3          	add	a5,a4,a5
 384:	0007a783          	lw	a5,0(a5)
 388:	fcf42c23          	sw	a5,-40(s0)
 38c:	fd842783          	lw	a5,-40(s0)
 390:	fcf42a23          	sw	a5,-44(s0)
 394:	fd442783          	lw	a5,-44(s0)
 398:	00479793          	slli	a5,a5,0x4
 39c:	fd842703          	lw	a4,-40(s0)
 3a0:	00f767b3          	or	a5,a4,a5
 3a4:	fcf42a23          	sw	a5,-44(s0)
 3a8:	fd442783          	lw	a5,-44(s0)
 3ac:	00479793          	slli	a5,a5,0x4
 3b0:	fd842703          	lw	a4,-40(s0)
 3b4:	00f767b3          	or	a5,a4,a5
 3b8:	fcf42a23          	sw	a5,-44(s0)
 3bc:	fd442783          	lw	a5,-44(s0)
 3c0:	00479793          	slli	a5,a5,0x4
 3c4:	fd842703          	lw	a4,-40(s0)
 3c8:	00f767b3          	or	a5,a4,a5
 3cc:	fcf42a23          	sw	a5,-44(s0)
 3d0:	000017b7          	lui	a5,0x1
 3d4:	5f07a703          	lw	a4,1520(a5) # 15f0 <vram>
 3d8:	fec42783          	lw	a5,-20(s0)
 3dc:	00279793          	slli	a5,a5,0x2
 3e0:	00f707b3          	add	a5,a4,a5
 3e4:	fd442703          	lw	a4,-44(s0)
 3e8:	00e7a023          	sw	a4,0(a5)
 3ec:	fec42783          	lw	a5,-20(s0)
 3f0:	00178793          	addi	a5,a5,1
 3f4:	fef42623          	sw	a5,-20(s0)
 3f8:	fe442783          	lw	a5,-28(s0)
 3fc:	00278793          	addi	a5,a5,2
 400:	fef42223          	sw	a5,-28(s0)
 404:	fe442703          	lw	a4,-28(s0)
 408:	27f00793          	li	a5,639
 40c:	ece7d0e3          	bge	a5,a4,2cc <draw_rainbow_diagonal+0x60>
 410:	fe842783          	lw	a5,-24(s0)
 414:	00178793          	addi	a5,a5,1
 418:	fef42423          	sw	a5,-24(s0)
 41c:	fe842703          	lw	a4,-24(s0)
 420:	1df00793          	li	a5,479
 424:	eae7d0e3          	bge	a5,a4,2c4 <draw_rainbow_diagonal+0x58>
 428:	00000013          	nop
 42c:	00000013          	nop
 430:	04c12083          	lw	ra,76(sp)
 434:	04812403          	lw	s0,72(sp)
 438:	05010113          	addi	sp,sp,80
 43c:	00008067          	ret

00000440 <draw_checkerboard>:
 440:	fc010113          	addi	sp,sp,-64
 444:	02112e23          	sw	ra,60(sp)
 448:	02812c23          	sw	s0,56(sp)
 44c:	04010413          	addi	s0,sp,64
 450:	fe042623          	sw	zero,-20(s0)
 454:	fc042023          	sw	zero,-64(s0)
 458:	000017b7          	lui	a5,0x1
 45c:	fff78793          	addi	a5,a5,-1 # fff <main+0xa83>
 460:	fcf42223          	sw	a5,-60(s0)
 464:	02000793          	li	a5,32
 468:	fef42023          	sw	a5,-32(s0)
 46c:	01f00793          	li	a5,31
 470:	fcf42e23          	sw	a5,-36(s0)
 474:	fe042423          	sw	zero,-24(s0)
 478:	0e00006f          	j	558 <draw_checkerboard+0x118>
 47c:	fe842783          	lw	a5,-24(s0)
 480:	4057d793          	srai	a5,a5,0x5
 484:	fcf42c23          	sw	a5,-40(s0)
 488:	fe042223          	sw	zero,-28(s0)
 48c:	0b40006f          	j	540 <draw_checkerboard+0x100>
 490:	fe442783          	lw	a5,-28(s0)
 494:	4057d793          	srai	a5,a5,0x5
 498:	fcf42a23          	sw	a5,-44(s0)
 49c:	fd442703          	lw	a4,-44(s0)
 4a0:	fd842783          	lw	a5,-40(s0)
 4a4:	00f707b3          	add	a5,a4,a5
 4a8:	0017f793          	andi	a5,a5,1
 4ac:	fcf42823          	sw	a5,-48(s0)
 4b0:	fd042703          	lw	a4,-48(s0)
 4b4:	fc040793          	addi	a5,s0,-64
 4b8:	00271713          	slli	a4,a4,0x2
 4bc:	00f707b3          	add	a5,a4,a5
 4c0:	0007a783          	lw	a5,0(a5)
 4c4:	fcf42623          	sw	a5,-52(s0)
 4c8:	fcc42783          	lw	a5,-52(s0)
 4cc:	fcf42423          	sw	a5,-56(s0)
 4d0:	fc842783          	lw	a5,-56(s0)
 4d4:	00479793          	slli	a5,a5,0x4
 4d8:	fcc42703          	lw	a4,-52(s0)
 4dc:	00f767b3          	or	a5,a4,a5
 4e0:	fcf42423          	sw	a5,-56(s0)
 4e4:	fc842783          	lw	a5,-56(s0)
 4e8:	00479793          	slli	a5,a5,0x4
 4ec:	fcc42703          	lw	a4,-52(s0)
 4f0:	00f767b3          	or	a5,a4,a5
 4f4:	fcf42423          	sw	a5,-56(s0)
 4f8:	fc842783          	lw	a5,-56(s0)
 4fc:	00479793          	slli	a5,a5,0x4
 500:	fcc42703          	lw	a4,-52(s0)
 504:	00f767b3          	or	a5,a4,a5
 508:	fcf42423          	sw	a5,-56(s0)
 50c:	000017b7          	lui	a5,0x1
 510:	5f07a703          	lw	a4,1520(a5) # 15f0 <vram>
 514:	fec42783          	lw	a5,-20(s0)
 518:	00279793          	slli	a5,a5,0x2
 51c:	00f707b3          	add	a5,a4,a5
 520:	fc842703          	lw	a4,-56(s0)
 524:	00e7a023          	sw	a4,0(a5)
 528:	fec42783          	lw	a5,-20(s0)
 52c:	00178793          	addi	a5,a5,1
 530:	fef42623          	sw	a5,-20(s0)
 534:	fe442783          	lw	a5,-28(s0)
 538:	00278793          	addi	a5,a5,2
 53c:	fef42223          	sw	a5,-28(s0)
 540:	fe442703          	lw	a4,-28(s0)
 544:	27f00793          	li	a5,639
 548:	f4e7d4e3          	bge	a5,a4,490 <draw_checkerboard+0x50>
 54c:	fe842783          	lw	a5,-24(s0)
 550:	00178793          	addi	a5,a5,1
 554:	fef42423          	sw	a5,-24(s0)
 558:	fe842703          	lw	a4,-24(s0)
 55c:	1df00793          	li	a5,479
 560:	f0e7dee3          	bge	a5,a4,47c <draw_checkerboard+0x3c>
 564:	00000013          	nop
 568:	00000013          	nop
 56c:	03c12083          	lw	ra,60(sp)
 570:	03812403          	lw	s0,56(sp)
 574:	04010113          	addi	sp,sp,64
 578:	00008067          	ret

0000057c <main>:
 57c:	ff010113          	addi	sp,sp,-16
 580:	00112623          	sw	ra,12(sp)
 584:	00812423          	sw	s0,8(sp)
 588:	01010413          	addi	s0,sp,16
 58c:	b01ff0ef          	jal	8c <draw_color_bars>
 590:	02faf7b7          	lui	a5,0x2faf
 594:	08078513          	addi	a0,a5,128 # 2faf080 <__global_pointer$+0x2fad290>
 598:	ab5ff0ef          	jal	4c <wait>
 59c:	cd1ff0ef          	jal	26c <draw_rainbow_diagonal>
 5a0:	02faf7b7          	lui	a5,0x2faf
 5a4:	08078513          	addi	a0,a5,128 # 2faf080 <__global_pointer$+0x2fad290>
 5a8:	aa5ff0ef          	jal	4c <wait>
 5ac:	e95ff0ef          	jal	440 <draw_checkerboard>
 5b0:	fddff06f          	j	58c <main+0x10>
