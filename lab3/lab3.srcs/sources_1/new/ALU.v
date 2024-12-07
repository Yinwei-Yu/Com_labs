module ALU (
    input signed [31:0] A,
    B,
    input [4:0] ALUop,
    output reg signed [31:0] ALUout,
    output reg Zero
);
  `define ALUOp_nop 5'b00000
  `define ALUOp_lui 5'b00001
  `define ALUOp_auipc 5'b00010
  `define ALUOp_add 5'b00011
  `define ALUOp_sub 5'b00100
  `define ALUOp_bne 5'b00101
  `define ALUOp_blt 5'b00110
  `define ALUOp_bge 5'b00111
  `define ALUOp_bltu 5'b01000
  `define ALUOp_bgeu 5'b01001
  `define ALUOp_slt 5'b01010
  `define ALUOp_sltu 5'b01011
  `define ALUOp_xor 5'b01100
  `define ALUOp_or 5'b01101
  `define ALUOp_and 5'b01110
  `define ALUOp_sll 5'b01111
  `define ALUOp_srl 5'b10000
  `define ALUOp_sra 5'b10001

  always @(*) begin
    case (ALUop)
      `ALUOp_add: ALUout <= A + B;
      `ALUOp_sub: ALUout <= A - B;
      default: ALUout <= 0;
    endcase
    Zero = ALUout == 0 ? 1 : 0;
  end

endmodule
