module open_drain_pwm_dac (
    input         clk,       // 系统时钟
    input         rst,
    input  [15:0] audio_in,  // 16位音频输入
    output        pwm_out    // 开漏PWM输出
);
    reg [15:0] counter = 0;
    wire pwm_active;
    
    // 生成PWM信号
    always @(posedge clk) begin
        if (rst)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    
    // 生成常规PWM信号
    assign pwm_active = (counter < audio_in);
    
    // 开漏输出: 当pwm_active为0时驱动为低电平，否则为高阻态
    // 使用三态缓冲器实现开漏输出
    assign pwm_out = pwm_active ? 1'bz : 1'b0;
endmodule