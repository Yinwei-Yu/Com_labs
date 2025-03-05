
// testbench for simulation
module top_tb ();

  reg clk, rstn;
  reg [15:0]sw_i;
  wire [7:0] disp_seg_o;
  wire [7:0] disp_an_o;
  wire [4:0] btn_i;


  // instantiation of sccomp    
  top U_TOP (
      .clk(clk),
      .rstn(rstn),
      .sw_i(sw_i),
      .btn_i(btn_i),
      .disp_seg_o(disp_seg_o),
      .disp_an_o(disp_an_o)
  );

  always begin
    clk = 1'b0;
    #5 clk = 1'b1;
    #5;
  end

  initial begin
    // Initialize inputs
    rstn = 1'b0;  // Apply reset
    sw_i = 16'b0000_0000_00_0000_00;  // Initialize switch input to 0
    #5 rstn = 1'b1;  // Deassert reset
    // Finish simulation after some time
    #3000;
  end

endmodule
