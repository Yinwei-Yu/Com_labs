module ALU (
    input signed [31:0] A,
    B,
    input [4:0] ALUop,
    output reg signed [31:0] C,
    output reg Zero
);
  `define ADD 5'b00001
  `define SUB 5'b00000

  always @(*) begin
    case (ALUop)
      `ADD: C <= A + B;
      `SUB: C <= A - B;
      default: C <= 0;
    endcase
    Zero = C == 0 ? 1 : 0;
  end

endmodule
