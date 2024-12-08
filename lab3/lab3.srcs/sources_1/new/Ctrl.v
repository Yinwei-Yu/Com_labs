module Ctrl (
    input [6:0] Op,
    input [2:0] Funct3,
    input [6:0] Funct7,
    input Zero,  //Zero Flag
    input BrLt,  //Branch Less Than
    output BrUn,  //Branch Unsigned
    output RegWrite,  //Register Write
    output MemWrite,  //Memory Write
    output [5:0] EXTOp,  //Extend Operation
    output [4:0] ALUOp,  //ALU Operation
    output ASel,  //ALU A Source
    output BSel,  //ALU B Source
    output [2:0] DMType,  //Data Memory Type
    output [1:0] WDSel,  //Memory Write Data Select
    output [1:0] PCSel  //PC Select
);

  //R type
  wire rtype = ~Op[6] & Op[5] & Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //rtype op 0110011
  wire r_add=rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // add 0000000 000
  wire r_sub=rtype&~Funct7[6]&Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // sub 0100000 000
  wire r_and=rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&Funct3[2]&Funct3[1]&Funct3[0]; // and 0000000 111
  wire r_or = rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&Funct3[2]&Funct3[1]&~Funct3[0]; // or 0000000 110
  wire r_xor =rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&Funct3[2]&~Funct3[1]&~Funct3[0]; // xor 0000000 100
  wire r_sll =rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&Funct3[0]; // sll 0000000 001
  wire r_srl =rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&Funct3[2]&~Funct3[1]&Funct3[0]; // srl 0000000 101
  wire r_sra =rtype&~Funct7[6]&Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&Funct3[2]&~Funct3[1]&Funct3[0]; // sra 0100000 101
  wire r_slt =rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&Funct3[1]&~Funct3[0]; // slt 0000000 010
  wire r_sltu=rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&Funct3[1]&Funct3[0]; // sltu 0000000 011
  wire r_mul = rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // mul 0000001 000
  wire r_mulh= rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&Funct7[0]&~Funct3[2]&~Funct3[1]&Funct3[0]; // mulh 0000001 001
  wire r_mulhu =rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&Funct7[0]&~Funct3[2]&Funct3[1]&Funct3[0]; // mulhu 0000001 011

  //I type
  //load
  wire itype_l = ~Op[6] & ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //0000011
  wire i_lb = itype_l & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //lb 000
  wire i_lbu = itype_l & Funct3[2] & ~Funct3[1] & ~Funct3[0];  //lbu 100
  wire i_lh = itype_l & ~Funct3[2] & ~Funct3[1] & Funct3[0];  //lh 001
  wire i_lhu = itype_l & Funct3[2] & ~Funct3[1] & Funct3[0];  //lhu 101
  wire i_lw = itype_l & ~Funct3[2] & Funct3[1] & ~Funct3[0];  //lw 010
  //i
  wire itype_r = ~Op[6] & ~Op[5] & Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //0010011
  wire i_addi = itype_r & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  // addi 000 func3
  wire i_andi = itype_r & Funct3[2] & Funct3[1] & Funct3[0];  // andi 111
  wire i_ori = itype_r & Funct3[2] & Funct3[1] & ~Funct3[0];  // ori 110
  wire i_xori = itype_r & Funct3[2] & ~Funct3[1] & ~Funct3[0];  // xori 100
  wire i_slli = itype_r & (Funct7[6:0] == 0 ? 1 : 0) & (Funct3[2:0] == 1 ? 1 : 0);  //0000000 001
  wire i_srli = itype_r & (Funct7[6:0] == 0 ? 1 : 0) & (Funct3[2:0] == 5 ? 1 : 0);  //0000000 101
  wire i_srai = itype_r & (Funct7[6:0] == 32 ? 1 : 0) & (Funct3[2:0] == 5 ? 1 : 0);  //0100000 101
  wire i_slti = itype_r & ~Funct3[2] & Funct3[1] & ~Funct3[0];  // slti 010
  wire i_sltiu = itype_r & ~Funct3[2] & Funct3[1] & Funct3[0];  // sltiu 011

  //B type
  wire btype = Op[6] & Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //1100011
  wire b_beq = btype & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //beq 000
  wire b_bne = btype & ~Funct3[2] & ~Funct3[1] & Funct3[0];  //bne 001
  wire b_bge = btype & Funct3[2] & ~Funct3[1] & Funct3[0];  //bge 101
  wire b_bgeu = btype & Funct3[2] & Funct3[1] & Funct3[0];  //bgeu 111
  wire b_blt = btype & Funct3[2] & ~Funct3[1] & ~Funct3[0];  //blt 100
  wire b_bltu = btype & Funct3[2] & Funct3[1] & ~Funct3[0];  //bltu 110

  //S type
  wire stype = ~Op[6] & Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //0100011
  wire s_sb = stype & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //sb 000
  wire s_sh = stype && ~Funct3[2] & ~Funct3[1] & Funct3[0];  //sh 001
  wire s_sw = stype & ~Funct3[2] & Funct3[1] & ~Funct3[0];  // sw 010

  //J type
  wire j_jal = Op[6] & Op[5] & ~Op[4] & Op[3] & Op[2] & Op[1] & Op[0];  //op=1101111
  wire i_jalr= Op[6] & Op[5] & ~Op[4] & ~Op[3] & Op[2] & Op[1] & Op[0] & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];  //op=1100111 000

  //U type
  wire u_auipc = ~Op[6] & ~Op[5] & Op[4] & ~Op[3] & Op[2] & Op[1] & Op[0];  //op=0010111
  wire u_lui = ~Op[6] & Op[5] & Op[4] & ~Op[3] & Op[2] & Op[1] & Op[0];  //op=0110111



  //signal
  assign RegWrite = rtype | itype_r | itype_l | u_auipc | u_lui | i_jalr | j_jal;  // register write
  assign MemWrite = stype;  // memory write
  assign ASel = u_auipc;  // ALU A is from register or PC 
  assign BSel = itype_l | itype_r | u_auipc | stype | i_jalr;  // ALU B is from instruction immediate


  // `define WDSel_FromALU 2'b00
  // `define WDSel_FromMEM 2'b01
  // `define WDSel_FromPC 2'b10
  // `define WDSel_FromImm 2'b11
  assign WDSel[0] = itype_l | u_lui;  //if is load then select from memory 1
  assign WDSel[1] = i_jalr | j_jal | u_lui;  //if is rtype or itype_r or u_auipc or i_jalr or j_jal then select from alu 2

  // `define ALUOp_nop 5'b00000
  // `define ALUOp_lui 5'b00001
  // `define ALUOp_auipc 5'b00010
  // `define ALUOp_add 5'b00011 //stype itype_l jalr  
  // `define ALUOp_sub 5'b00100
  // `define ALUOp_beq 5'b00101
  // `define ALUOp_bne 5'b00101
  // `define ALUOp_blt 5'b00110
  // `define ALUOp_bge 5'b00111
  // `define ALUOp_bltu 5'b01000
  // `define ALUOp_bgeu 5'b01001
  // `define ALUOp_slt 5'b01010
  // `define ALUOp_sltu 5'b01011
  // `define ALUOp_xor 5'b01100
  // `define ALUOp_or 5'b01101
  // `define ALUOp_and 5'b01110
  // `define ALUOp_sll 5'b01111
  // `define ALUOp_srl 5'b10000
  // `define ALUOp_sra 5'b10001
  assign ALUOp[0] = u_lui|b_beq | b_bne |b_bge|b_bgeu|r_sltu|i_ori|r_or|i_slli|r_sll|i_srai|r_sra|r_add | i_addi | stype | itype_l;
  assign ALUOp[1] = u_auipc|b_blt|b_bge|i_slti|r_slt|r_sltu|i_sltiu|i_andi|r_and|i_slli|r_sll|r_add | i_addi | stype | itype_l;
  assign ALUOp[2]=r_sub|b_beq| b_bne|b_blt|b_bge|r_xor|i_xori|i_ori|r_or|i_andi|r_and|i_slli|r_sll;
  assign ALUOp[3]=b_bltu|b_bgeu|i_slti|r_slt|r_sltu|i_sltiu|i_xori|r_xor|i_ori|r_or|i_andi|r_and|i_slli|r_sll;
  assign ALUOp[4] = i_srli | r_srl | i_srai | r_sra;

  // `define EXT_CTRL_ITYPE_SHAMT 6'b100000
  // `define EXT_CTRL_ITYPE 6'b010000
  // `define EXT_CTRL_STYPE 6'b001000
  // `define EXT_CTRL_BTYPE 6'b000100
  // `define EXT_CTRL_UTYPE 6'b000010
  // `define EXT_CTRL_JTYPE 6'b000001

  assign EXTOp[5] = i_slli | i_srai | i_srli;
  assign EXTOp[4] = itype_l | itype_r & ~i_slli & ~i_srai & ~i_srli;
  assign EXTOp[3] = stype;
  assign EXTOp[2] = btype;
  assign EXTOp[1] = u_lui | u_auipc;
  assign EXTOp[0] = j_jal;

  //dm_word 3'b000
  //dm_halfword 3'b001
  //dm_halfword_unsigned 3'b010
  //dm_byte 3'b011
  //dm_byte_unsigned 3'b100
  assign DMType[2] = i_lbu;
  assign DMType[1] = i_lb | s_sb | i_lhu;
  assign DMType[0] = i_lh | s_sh | i_lb | s_sb;

  //BrUn
  assign BrUn = b_bltu | b_bgeu;

  //PCSel
  //PCSel 2'b00: PC = PC + 4;
  //PCSel 2'b01: PC = PC+immout;
  //PCSel 2'b10: PC = ALUout
  wire PC_B = btype & ((b_beq & Zero) | (b_bne & ~Zero) | (b_blt & BrLt) | (b_bltu & BrLt) | (b_bge & ~BrLt) | (b_bgeu & ~BrLt));
  assign PCSel[0] = PC_B | j_jal;
  assign PCSel[1] = i_jalr;

endmodule
