// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Tue Jun 20 11:12:44 2023
// Host        : LAPTOP-E4IJ843E running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub C:/Users/user/Desktop/projects/edf_file/dm_controller.v
// Design      : dm_controller
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module dm_controller(mem_w, Addr_in, Data_write, dm_ctrl, 
  Data_read_from_dm, Data_read, Data_write_to_dm, wea_mem)
/* synthesis syn_black_box black_box_pad_pin="mem_w,Addr_in[31:0],Data_write[31:0],dm_ctrl[2:0],Data_read_from_dm[31:0],Data_read[31:0],Data_write_to_dm[31:0],wea_mem[3:0]" */;
  input mem_w;
  input [31:0]Addr_in;
  input [31:0]Data_write;
  input [2:0]dm_ctrl;
  input [31:0]Data_read_from_dm;
  output [31:0]Data_read;
  output [31:0]Data_write_to_dm;
  output [3:0]wea_mem;
endmodule
