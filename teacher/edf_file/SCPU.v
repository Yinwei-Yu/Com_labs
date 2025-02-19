// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Tue Jun 20 18:23:52 2023
// Host        : LAPTOP-E4IJ843E running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub C:/Users/user/Desktop/projects/edf_file/SCPU.v
// Design      : SCPU
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module SCPU(clk, reset, MIO_ready, inst_in, Data_in, mem_w, 
  PC_out, Addr_out, Data_out, dm_ctrl, CPU_MIO, INT)
/* synthesis syn_black_box black_box_pad_pin="clk,reset,MIO_ready,inst_in[31:0],Data_in[31:0],mem_w,PC_out[31:0],Addr_out[31:0],Data_out[31:0],dm_ctrl[2:0],CPU_MIO,INT" */;
  input clk;
  input reset;
  input MIO_ready;
  input [31:0]inst_in;
  input [31:0]Data_in;
  output mem_w;
  output [31:0]PC_out;
  output [31:0]Addr_out;
  output [31:0]Data_out;
  output [2:0]dm_ctrl;
  output CPU_MIO;
  input INT;
endmodule
