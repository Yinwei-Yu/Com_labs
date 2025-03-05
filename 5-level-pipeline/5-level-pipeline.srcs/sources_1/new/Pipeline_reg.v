module Pipeline_reg #(
    parameter WIDTH = 200
) (
    input clk,
    input rst,
    input write_enable,
    input flush,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 0;
    end else if (write_enable) begin
      if (flush) begin
        data_out <= 0;
      end else begin
        data_out <= data_in;
      end
    end
  end

endmodule
