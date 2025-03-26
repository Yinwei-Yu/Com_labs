`timescale 1ns / 1ps

module   PS2KB(input  clk, rst,					// clock and reset (active low)
					inout  PS2C, PS2D, 				// ps2 signals from keyboard
					input  rdn,               		// read (active low) signal from cpu
					output reg [7:0] data,        // keyboard code
					output reg ready         		// queue (fifo) state
					);

localparam Idle = 2'b00, Rece = 2'b01, Even = 2'b10, Stop = 2'b11;

reg [9:0] PS2_shift = 10'b1000000000;						//接收移位寄存器
reg [1:0]state = 0;												//状态变量
reg [1:0]Fall_Clk;   											// for detecting the falling-edge of a frame
reg Coen=0, Doen=0, PS2Cio, PS2Dio, PS2Co=0,PS2Do=0;
initial begin
Coen=0;
Doen=0;
PS2Co=0;
PS2Do=0;
end

//Tri-state Buffet
	assign PS2C = Coen? PS2Co : 1'bz;
	assign PS2D = Doen? PS2Do : 1'bz;

/*	assign PS2C = PS2Cio;
	assign PS2D = PS2Dio;
	
	
	always @*begin
		if(Coen) PS2Cio = PS2Co; else PS2Co = 1'bz;
		if(Doen) PS2Dio = PS2Do; else PS2Do = 1'bz;
	end
*/	 
	always @ (posedge clk) begin 					  		// this is a common method to
        Fall_Clk <= {Fall_Clk[0],PS2C};    			// detect
	end                                               // falling-edge
	
	always @ (posedge clk) begin
		if(rst)begin
		  PS2_shift <= 10'b1000000000;						//移位寄存器初始化
		  state <= Idle;
		  ready	<= 0;				
		end else begin
		  if (!rdn && ready) ready <= 0; 
		  else ready <= ready ;
		  
		  case(state)
			Idle: begin
			  PS2_shift <= 10'b1000000000;						//移位寄存器初始化
			     if((Fall_Clk == 2'b10) && (!PS2D))		//检测停止位
				   state <= Rece;
				else	state <= Idle;				
			end

			Rece: begin
				if(Fall_Clk == 2'b10)begin							//时钟下降沿，采样PS2D
			  	  if(PS2_shift[0] && PS2D)begin 			//接收到停止位
					ready <= {^ PS2_shift [9:1]}; 				//odd prity有效，数据有效
					data <= PS2_shift [8:1];						//扫描码送数据缓冲器
					state	 <= Idle;				  					//结束一帧数据接收
			  	  end else begin
					PS2_shift <= {PS2D, PS2_shift[9:1]};	//右移送入寄存器，低位在前
					state <= Rece;										//继续Rece状态接收下一位
			  	  end
				end else state <= Rece;								//继续Rece状态接收下一位
				  
			end
			
		  endcase
		end
	end
	 
endmodule
