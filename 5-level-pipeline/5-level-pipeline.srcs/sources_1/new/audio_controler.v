module audio_controller (
    input         clk,           // 系统时钟
    input         rst,           // 复位信号
    
    // 控制参数
    input         play_enable,   // 播放使能
    input  [31:0] sample_rate_div, // 时钟分频值
    input  [31:0] audio_start,   // 起始地址
    input  [31:0] audio_length,  // 音频长度(样本数)
    
    // 与音频存储器接口
    output reg [16:0] ram_addr,  // 当前读取地址
    input  [7:0] ram_data,      // 音频数据
    
    // DAC输出
    output [7:0] audio_out      // 输出到PWM的音频数据
);
    reg [31:0] sample_counter = 0;
    reg [31:0] addr_offset = 0;
    reg playing = 0;
    
    // 采样控制逻辑
    always @(posedge clk) begin
        if (rst) begin
            sample_counter <= 0;
            addr_offset <= 0;
            playing <= 0;
            ram_addr <= audio_start[16:0];
        end
        else begin
            if (play_enable && !playing)
                playing <= 1;
            else if (!play_enable)
                playing <= 0;
                
            if (playing) begin
                if (sample_counter >= sample_rate_div - 1) begin
                    sample_counter <= 0;
                    
                    // 更新地址
                    if (addr_offset < audio_length - 1)
                        addr_offset <= addr_offset + 1;
                    else
                        addr_offset <= 0; // 循环播放
                        
                    ram_addr <= audio_start[16:0] + addr_offset;
                end
                else begin
                    sample_counter <= sample_counter + 1;
                end
            end
        end
    end
    
    assign audio_out = playing ? ram_data : 8'h80; // 不播放时输出中点电平
endmodule