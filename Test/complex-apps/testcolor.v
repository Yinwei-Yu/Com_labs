module test_pattern(
    input [8:0] row,
    input [9:0] col,
    output reg [11:0] pixel_out
);
    always @(*) begin
        if (col < 80)
            pixel_out = 12'hF00;      // 红色
        else if (col < 160)
            pixel_out = 12'h0F0;      // 绿色
        else if (col < 240)
            pixel_out = 12'h00F;      // 蓝色
        else if (col < 320)
            pixel_out = 12'hFF0;      // 黄色
        else if (col < 400)
            pixel_out = 12'h0FF;      // 青色
        else if (col < 480)
            pixel_out = 12'hF0F;      // 紫色
        else if (col < 560)
            pixel_out = 12'hFFF;      // 白色
        else
            pixel_out = 12'h888;      // 灰色
    end
endmodule