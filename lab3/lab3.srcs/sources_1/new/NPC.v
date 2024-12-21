//module for the next pc
module NPC (
    input clk,
    input rst,
    input [15:0] sw_i,
    input [31:0] PC,
    input [31:0] PCSel,
    input [31:0] immout,
    input [31:0] ALUout,
    input [31:0] instr,
    output reg [31:0] NPC
);

  always @(negedge clk or negedge rst)begin
    if(!rst)begin
      NPC = 32'h0000_0000;
    end
    else if (sw_i[1] == 1'b0) begin
      if (PCSel == 2'b00) begin
        NPC = PC + 4;
      end else if (PCSel == 2'b01) begin
        NPC = PC + immout;
      end else if (PCSel == 2'b10) begin
        NPC = ALUout;
      end else begin
        NPC = PC + 4;
      end
    end
    else
      NPC = PC;
  end
endmodule
