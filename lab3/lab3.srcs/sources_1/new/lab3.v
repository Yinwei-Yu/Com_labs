`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/17 21:11:44
// Design Name: 
// Module Name: lab3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab3 (
    input clk,
    input rstn,
    input [15:0] sw_i,
    output [7:0] disp_seg_o,
    output [7:0] disp_an_o
);
  reg [31:0] clkdiv;
  wire clk_cpu;

  always @(posedge clk or negedge rstn) begin
    if (!rstn) clkdiv <= 0;
    else clkdiv <= clkdiv + 1'b1;
  end
  assign clk_cpu = (sw_i[15]) ? clkdiv[27] : clkdiv[25];

  reg [63:0] display_data;

  reg [ 5:0] led_data_addr;
  reg [63:0] led_disp_data;
  parameter LED_DATA_NUM = 10;

  reg [63:0] LED_DATA[10:0];
  initial begin
    LED_DATA[0]  = 64'hfffffffefefefefe;
    LED_DATA[1]  = 64'hfffefefefefeffff;
    LED_DATA[2]  = 64'hdefefefeffffffff;
    LED_DATA[3]  = 64'hcefefeffffffffff;
    LED_DATA[4]  = 64'hc2ffffffffffffff;
    LED_DATA[5]  = 64'hc1feffffffffffff;
    LED_DATA[6]  = 64'hf1fcffffffffffff;
    LED_DATA[7]  = 64'hfdf8f7ffffffffff;
    LED_DATA[8]  = 64'hfff8f3ffffffffff;
    LED_DATA[9]  = 64'hfffbf1feffffffff;
    LED_DATA[10] = 64'hfffff9f8ffffffff;
  end

  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      led_data_addr <= 6'b0;
      led_disp_data = 64'b1;
    end else if (sw_i[0] == 1'b1) begin
      if (led_data_addr == LED_DATA_NUM) begin
        led_data_addr = 6'b0;
        led_disp_data = 64'b1;
      end
      led_disp_data = LED_DATA[led_data_addr];
      led_data_addr = led_data_addr + 1'b1;
    end else led_data_addr = led_data_addr;
  end

  reg [31:0] rom_addr;
  parameter ROM_MAX = 12;
  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      rom_addr = 32'b0;
    end else begin
      if (rom_addr == ROM_MAX) begin
        rom_addr = 32'b0;
      end else begin
        rom_addr = rom_addr + 1'b1;
      end
    end
  end


  wire [31:0] instr;
  reg  [31:0] reg_data;
  reg  [31:0] alu_disp_data;
  reg  [31:0] dmem_data;

  //choose display source data

  always @(sw_i) begin
    if (sw_i[0] == 0) begin
      case (sw_i[14:11])
        4'b1000: display_data = instr;
        4'b0100: display_data = reg_data;
        4'b0010: display_data = alu_disp_data;
        4'b0001: display_data = dmem_data;
        default: display_data = instr;
      endcase
    end else begin
      display_data = led_disp_data;
    end
  end

  dist_mem_gen_0 u_IM (
      .a  (rom_addr),
      .spo(instr)
  );

  seg7x16 u_seg7x16 (
      .clk(clk),
      .rstn(rstn),
      .i_data(display_data),
      .disp_mode(sw_i[0]),
      .o_seg(disp_seg_o),
      .o_sel(disp_an_o)
  );


endmodule
