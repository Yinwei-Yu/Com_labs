module DM (
    input clk,
    input DMWr,
    input [5:0] addr,
    input [31:0] din,
    input [2:0] DMType,
    input [15:0] sw_i,
    output reg [31:0] dout

);

  //macro define
  `define dm_word 3'b000
  `define dm_halfword 3'b001
  `define dm_halfword_unsigned 3'b010
  `define dm_byte 3'b011
  `define dm_byte_unsigned 3'b100

  reg [7:0] dmem[127:0];

  //initial dmem to index
  integer i;
  initial begin
    for (i = 0; i < 128; i = i + 1) begin
      dmem[i] = 0;
    end
  end

  always @(posedge clk) begin
    if (DMWr == 1 && sw_i[1] == 0) begin
      case (DMType)
        `dm_byte: dmem[addr] <= din[7:0];
        `dm_byte_unsigned: dmem[addr] <= din[7:0];
        `dm_halfword: begin
          dmem[addr]   <= din[7:0];
          dmem[addr+1] <= din[15:8];
        end
        `dm_halfword_unsigned: begin
          dmem[addr]   <= din[7:0];
          dmem[addr+1] <= din[15:8];
        end
        `dm_word: begin
          dmem[addr]   <= din[7:0];
          dmem[addr+1] <= din[15:8];
          dmem[addr+2] <= din[23:16];
          dmem[addr+3] <= din[31:24];
        end
        default: dmem[addr] <= 0;
      endcase
    end
  end

  always @(*) begin
    case (DMType)
      `dm_byte: dout = {{24{dmem[addr][7]}}, dmem[addr][7:0]};
      `dm_byte_unsigned: dout = {24'b0, dmem[addr][7:0]};
      `dm_halfword: dout = {{16{dmem[addr+1][7]}}, dmem[addr+1][7:0], dmem[addr][7:0]};
      `dm_halfword_unsigned: dout = {16'b0, dmem[addr+1][7:0], dmem[addr][7:0]};
      `dm_word: dout = {dmem[addr+3][7:0], dmem[addr+2][7:0], dmem[addr+1][7:0], dmem[addr][7:0]};
      default: dout = 32'hFFFFFFFF;
    endcase
  end

endmodule
