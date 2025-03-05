module ALU (
    input signed [31:0] A,
    B,
    input [4:0] ALUop,
    output reg signed [31:0] ALUout,
    output reg Zero
);
  `define ALUOp_nop 5'b00000
  `define ALUOp_lui 5'b00001
  `define ALUOp_add 5'b00011
  `define ALUOp_sub 5'b00100
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
      `ALUOp_nop: ALUout <= A + B;
      `ALUOp_lui: ALUout <= B;
      `ALUOp_add: ALUout <= A + B;
      `ALUOp_sub: ALUout <= A - B;
      `ALUOp_slt: ALUout <= A < B ? 1 : 0;
      `ALUOp_sltu: ALUout <= $unsigned(A) < $unsigned(B) ? 1 : 0;
      `ALUOp_xor: ALUout <= A ^ B;
      `ALUOp_or: ALUout <= A | B;
      `ALUOp_and: ALUout <= A & B;
      `ALUOp_sll: ALUout <= A << B[4:0];
      `ALUOp_srl: ALUout <= A >> B[4:0];
      `ALUOp_sra: ALUout <= A >>> B[4:0];
      default: ALUout <= 32'b0;
    endcase
    Zero = ALUout == 0 ? 1 : 0;
  end

endmodule
