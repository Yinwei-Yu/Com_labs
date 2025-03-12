module Branch(
  input [6:0] Op,
  input [2:0] Funct3,
  input [6:0] Funct7,
  input BrLt,
  input Zero,
  output BrUn,
  output [1:0]PCSel
);


//B type
  wire btype = Op[6] & Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //1100011
  wire b_beq = btype & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //beq 000
  wire b_bne = btype & ~Funct3[2] & ~Funct3[1] & Funct3[0];  //bne 001
  wire b_bge = btype & Funct3[2] & ~Funct3[1] & Funct3[0];  //bge 101
  wire b_bgeu = btype & Funct3[2] & Funct3[1] & Funct3[0];  //bgeu 111
  wire b_blt = btype & Funct3[2] & ~Funct3[1] & ~Funct3[0];  //blt 100
  wire b_bltu = btype & Funct3[2] & Funct3[1] & ~Funct3[0];  //bltu 110

  //J type
  wire j_jal = Op[6] & Op[5] & ~Op[4] & Op[3] & Op[2] & Op[1] & Op[0];  //op=1101111
  assign i_jalr= Op[6] & Op[5] & ~Op[4] & ~Op[3] & Op[2] & Op[1] & Op[0] & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //op=1100111 000

  //BrUn
  assign BrUn = b_bltu | b_bgeu;

  //PCSel
  //00 PC=PC+4
  //01 PC=PC+imm
  //10 PC=aluout
  wire PC_B = btype & ((b_beq & Zero) | (b_bne & ~Zero) | (b_blt & BrLt) | (b_bltu & BrLt) | (b_bge & ~BrLt) | (b_bgeu & ~BrLt));
  assign PCSel[0] = PC_B | j_jal;
  assign PCSel[1] = i_jalr;


  endmodule