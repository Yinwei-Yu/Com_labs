module PC (
    input clk,
    input rst,
    input [31:0] NPC,
    input wire PCwr,
    input [5:2] sw_i,
    output reg [31:0] PC
);

  always @(posedge clk, negedge rst)
    //added for final test 2024.12.19
    //choose the test code init address
    //PC initialization
    if (!rst) begin
      case (sw_i)
        4'b0000: PC <= 32'h0000_0000;  //beq
        4'b0001: PC <= 32'h0000_0080;  //bne
        4'b0010: PC <= 32'h0000_0100;  //blt
        4'b0011: PC <= 32'h0000_0180;  //bge
        4'b0100: PC <= 32'h0000_0200;  //bltu
        4'b0101: PC <= 32'h0000_0280;  //bgeu
        4'b0110: PC <= 32'h0000_0300;  //jal
        4'b0111: PC <= 32'h0000_037c;  //jalr   
        4'b1000: PC <= 32'h0000_03f0;  //sll
        4'b1001: PC <= 32'h0000_0410;  //srl 
        4'b1010: PC <= 32'h0000_0430;  //sra 
        default: PC <= 32'h0000_0000;
      endcase
      //          PC <= 32'h0000_0000;
    end else if (PCwr == 1'b1)  //sw_i[1]= 0
      PC <= NPC;
    else
      PC <= PC;

endmodule
