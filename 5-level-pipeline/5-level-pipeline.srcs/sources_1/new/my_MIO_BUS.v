module MIO_BUS (
    input clk,
    input rst,
    input [4:0] BTN,  // 按钮
    input [15:0] SW,  // 开关
    input [31:0] PC,
    input mem_w,  // 写内存使能
    input [31:0] Cpu_data2bus,  //data from CPU
    input [31:0] addr_bus,  // 地址总线
    input [31:0] ram_data_out,  // ram输出数据
    input [15:0] led_out,
    input [31:0] counter_out,  //计数器输出
    input counter0_out,  //通道0计数结束输出，来自计数器外设
    input counter1_out,  //通道1计数结束输出，来自计数器外设
    input counter2_out,  //通道2计数结束输出，来自计数器外设
    output reg [31:0] Cpu_data4bus,//data write to CPU
    output reg [31:0] ram_data_in,//from CPU write to Memory
    output reg [9:0] ram_addr,//Memory Address signals
    output reg data_ram_we,//RAM读写控制，连接到RAM
    output reg GPIOf0000000_we,//设备一LED写信号
    output reg GPIOe0000000_we,//设备二7段数码管写信号
    output reg counter_we,//记数器写信号，连接到U10
    output reg [31:0] Peripheral_in//外部设备写数据总线，连接所有写设备
);

always @ ( * ) begin
    Cpu_data4bus = 0;
    ram_data_in = 0;
    ram_addr = 0;
    data_ram_we = 0;
    GPIOf0000000_we = 0;
    GPIOe0000000_we = 0;
    counter_we = 0;
    Peripheral_in = 0;
    case (addr_bus[31:28])
        4'b1111:begin // sw and button Address F0000000~FFFFFFFF
            GPIOe0000000_we = mem_w;
            Peripheral_in = Cpu_data2bus; // 直接把cpu总线数据写到外设
            data_ram_we=0;
            Cpu_data4bus = {11'b00000000000,BTN,SW};//将按钮和开关数据写回CPU
        end
        //4'b1110:begin // Seg7 Address E0000000~EFFFFFFF
            
        //end
        default: begin
            Cpu_data4bus = ram_data_out;//常规地址数据就是RAM数据
            ram_data_in = Cpu_data2bus;//写回RAM数据就是CPU数据
            ram_addr = addr_bus[11:2];//4字节对齐
            data_ram_we = mem_w;
        end
    endcase
end

endmodule
