module Ctrl (
    input [6:0] Op,
    input [2:0] Funct3,
    input [6:0] Funct7,
    input Zero,  //Zero Flag
    output RegWrite,  //Register Write
    output MemWrite,  //Memory Write
    output [5:0] EXTOp,  //Extend Operation
    output [4:0] ALUOp,  //ALU Operation
    output ALUSrc,  //ALU Source
    output [2:0] DMType,  //Data Memory Type
    output [1:0] WDSel  //Memory Write Data Select
);

  //R type
  wire i_add;
  wire i_sub;
  wire rtype = ~Op[6] & Op[5] & Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];
  assign i_add=rtype&~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // add 0000000 000
  assign i_sub=rtype&~Funct7[6]&Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // sub 0100000 000


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


  //S type
  wire stype = ~Op[6] & Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & Op[1] & Op[0];  //0100011
  wire i_sb = stype & ~Funct3[2] & ~Funct3[1] & ~Funct3[0];
  wire i_sh = stype && ~Funct3[2] & ~Funct3[1] & Funct3[0];
  wire i_sw = stype & ~Funct3[2] & Funct3[1] & ~Funct3[0];  // sw 010

  //signal
  assign RegWrite = rtype | itype_r | itype_l;  // register write
  assign MemWrite = stype;  // memory write
  assign ALUSrc = itype_r | stype | itype_l;  // ALU B is from instruction immediate
  //mem2reg=wdsel ,WDSel_FromALU 2'b00  WDSel_FromMEM 2'b01
  assign WDSel[0] = itype_l;  //if is load then select from memory 1
  assign WDSel[1] = 1'b0;

  // `define ALUOp_nop 5'b00000
  // `define ALUOp_lui 5'b00001
  // `define ALUOp_auipc 5'b00010
  // `define ALUOp_add 5'b00011
  // `define ALUOp_sub 5'b00100
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
  assign ALUOp[0] = i_add | i_addi | stype | itype_l;
  assign ALUOp[1] = i_add | i_addi | stype | itype_l;
  assign ALUOp[4:2] = 3'b0;


  // `define EXT_CTRL_ITYPE_SHAMT 6'b100000
  // `define EXT_CTRL_ITYPE 6'b010000
  // `define EXT_CTRL_STYPE 6'b001000
  // `define EXT_CTRL_BTYPE 6'b000100
  // `define EXT_CTRL_UTYPE 6'b000010
  // `define EXT_CTRL_JTYPE 6'b000001
  
  //assign EXTOp[5] = i_slli | i_srai | i_srli;
  assign EXTOp[5] = 0;
  assign EXTOp[4] = (itype_l | itype_r);  //& ~i_slli & ~i_srai & ~i_srli;
  assign EXTOp[3] = stype;
  assign EXTOp[2] = 0;
  //assign EXTOp[2] = sbtype;
  //assign EXTOp[1] = i_lui | i_auipc;
  assign EXTOp[1] = 0;
  //assign EXTOp[0] = i_jal;
  assign EXTOp[0] = 0;

  // dm_word 3'b000
  //dm_halfword 3'b001
  //dm_halfword_unsigned 3'b010
  //dm_byte 3'b011
  //dm_byte_unsigned 3'b100
  assign DMType[2] = i_lbu;
  assign DMType[1] = i_lb | i_sb | i_lhu;
  assign DMType[0] = i_lh | i_sh | i_lb | i_sb;

endmodule
