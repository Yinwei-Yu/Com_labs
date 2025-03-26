`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:51 08/22/2014 
// Design Name: 
// Module Name:    PS2_IO 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PS2IO(input io_read_clk,
				  input clk,
				  input rst,
				  inout PS2C,
				  inout PS2D,
				  input RD,
				  output[7:0]testkey,

				  output reg[31:0]Scancode,
				  output wire[7:0]key,
				  output PS2Ready
				 );
				 
reg[1:0] get_RD;
wire rdn;	
wire [7:0]ps2_key;
wire PS2Ready;
	assign testkey = ps2_key;
	
	always @(posedge clk or posedge rst)
		if(rst)get_RD <= 0; 
		else get_RD <= {get_RD[0],RD};
		
	assign rdn = ~get_RD[1] | get_RD[0] | ~PS2Ready;	//get_RD=10,rdn=0
	
	always @(posedge clk or posedge rst)
		if(rst)begin  Scancode <= 0; end		//rdn <= 1;
		else if(get_RD==2'b01 && PS2Ready)
			  begin Scancode <= {Scancode[23:0],ps2_key};		//TEST		
//					  rdn <= 0;			//RD | ~PS2Ready;							//cancel key_ready
			  end else Scancode <= Scancode;

	assign key =(RD && PS2Ready)? ps2_key : 8'haa;		// Scancode[7:0] ; 

//	ps2_kbd
	PS2KB			 ps2_kbd(.clk(clk),
								.rst(rst),
								.PS2C(PS2C),
								.PS2D(PS2D),
								.rdn(rdn),
								.data(ps2_key), 
								.ready(PS2Ready)
//								.overflow()
								);

endmodule
