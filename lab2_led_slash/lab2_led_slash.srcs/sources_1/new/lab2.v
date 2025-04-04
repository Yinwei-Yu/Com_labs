`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/17 20:11:19
// Design Name: 
// Module Name: lab2
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



module lab2 (
    input clk,
    input rstn,
    input [15:0] sw_i,
    output [15:0] led_o
);
  parameter div_num = 24;
  reg [15:0] led_tmp;
  reg ledset_flag;
  wire clk_div2;
  wire clk_div29;

  //clk_div2
  reg clk_div2_tmp;
  always @(posedge clk or negedge rstn) begin
    if (!rstn) clk_div2_tmp <= 1'b0;
    else clk_div2_tmp <= ~clk_div2_tmp;
  end
  assign clk_div2 = clk_div2_tmp;

  //clk_div29
  reg [31:0] clk_cnt;
  always @(posedge clk or negedge rstn) begin
    if (!rstn) clk_cnt <= 32'b0;
    else clk_cnt <= clk_cnt + 1;
  end
  assign clk_div29 = clk_cnt[div_num];

  //led splash
  always @(posedge clk_div29 or negedge rstn) begin
    if (!rstn) begin
      led_tmp <= 16'b0;
      ledset_flag <= 1'b1;
    end else if ((ledset_flag == 1'b1) && (sw_i[4:1] == 4'b1010)) begin
      led_tmp = 16'b1000_0000_0000_0000;
      ledset_flag = 1'b0;
    end else if (sw_i[4:1] == 4'b1010) begin
      led_tmp = {led_tmp[14:0], led_tmp[15]};
    end else begin
      led_tmp = 16'b0000_0000_0000_0000;
      ledset_flag = 1'b1;
    end
  end
  assign led_o[15:0] = led_tmp;
endmodule
