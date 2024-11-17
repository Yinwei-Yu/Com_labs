`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/17 20:34:35
// Design Name: 
// Module Name: lab2_tb
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


module lab2_tb ();
  reg clk, rstn;
  reg  [15:0] sw_i;
  wire [15:0] led_o;
  integer foutput, count;

  //instance
  lab2 u_test (
      .clk  (clk),
      .rstn (rstn),
      .sw_i (sw_i),
      .led_o(led_o)
  );

  //initial,rstn produce
  initial begin
    count = 0;
    clk   = 1;
    rstn  = 1;
    sw_i  = 16'b0000_0000_0001_0100;
    //foutput=$fopen("output.txt");
    #1;
    rstn = 0;
    #20;
    rstn = 1;
  end

  //clk produce
  always begin
    #1 clk = ~clk;
    if (clk == 1'b1) begin
      $display("led_o\t %b", led_o);
      $display("count: %h", count);
      count = count + 1;
    end else if (count > 1000) begin
      //$fclose(foutput);
      $stop;
    end else count = count;
  end
endmodule
