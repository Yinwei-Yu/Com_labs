module RF (
    input clk,
    input rst,
    input RFWr,
    input [15:0] sw_i,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
);

  reg [31:0] rf[31:0];




  integer i;
  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        rf[i] <= i;
      end
    end else begin
      if (RFWr && (!sw_i[1])) begin
        rf[A3] <= WD;
      end
    end
  end

  assign RD1 = rf[A1];
  assign RD2 = rf[A2];

endmodule
