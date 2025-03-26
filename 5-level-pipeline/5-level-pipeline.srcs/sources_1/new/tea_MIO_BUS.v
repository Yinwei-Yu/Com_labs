module tea_MIO_BUS(input clk,
                              input rst,
                              input[4:0]BTN, // 按钮
                              input[15:0]SW, // 开关
                              input[31:0]PC,
                              input mem_w, // 写内存使能
                              input[31:0]Cpu_data2bus,//data from CPU
                              input[31:0]addr_bus, // 地址总线
                              input[31:0]ram_data_out, // ram输出数据
                              input[15:0]led_out,
                              input[31:0]counter_out, //计数器输出
                              input counter0_out, //通道0计数结束输出，来自计数器外设
                              input counter1_out, //通道1计数结束输出，来自计数器外设
                              input counter2_out, //通道2计数结束输出，来自计数器外设
                              
                              input [7:0] SFR_Data_out,
                              input [7:0] keyboard_data,
                              
                              output reg[31:0]Cpu_data4bus,//write to CPU
                              output reg[31:0]ram_data_in,//from CPU write to Memory
                              output reg[10:0]ram_addr,//Memory Address signals
                              output reg data_ram_we,//RAM读写控制，连接到RAM
                              output reg GPIOf0000000_we,//设备一LED写信号
                              output reg GPIOe0000000_we,//设备二7段写信号，连接到U5
                              
                              output reg [15:0] VRAM_data_in,
                              output reg [8:0] VRAM_addr,
                              output reg VRAM_we,
                              
                              output reg [7:0] BACK_GRAM_data_in,
                              output reg [8:0] BACK_GRAM_addr,
                              output reg BACK_GRAM_we,
                              
                              output reg [7:0] FORE_GRAM_data_in,
                              output reg [8:0] FORE_GRAM_addr,
                              output reg FORE_GRAM_we,
                              //output reg [7:0] keyboard_data_out,
                              output reg keyboard_rdn,
                              
                              output reg [7:0] SFR_Data_in,
                              output reg [2:0] SFR_Addr,
                              output reg SFR_we,
                              
                              output reg counter_we,//记数器写信号，连接到U10
                              output reg[31:0]Peripheral_in//外部设备写数据总线，连接所有写设备
                              );
      always @(*) begin
                  Cpu_data4bus = 0;
                  ram_data_in = 0;
                  ram_addr = 0;
                  data_ram_we = 0;
                  VRAM_data_in = 0;
                  VRAM_addr = 0;
                  VRAM_we = 0;
                  GPIOf0000000_we = 0;
                  GPIOe0000000_we = 0;
                  counter_we = 0;
                  Peripheral_in = 0;
                  SFR_we = 0;
                  SFR_Data_in = 0;
                  SFR_Addr = 0;
                  //keyboard_data_out = 0;
                  keyboard_rdn = 1;
                  BACK_GRAM_data_in = 0;
                  BACK_GRAM_addr = 0;
                  BACK_GRAM_we = 0;
                  FORE_GRAM_data_in = 0;
                  FORE_GRAM_addr = 0;
                  FORE_GRAM_we = 0;
                  case (addr_bus[31:28])
                        4'b1111: begin // GPIO Address F0000000~FFFFFFFF
                              case(addr_bus[3:0])
                                    4'b0100: begin
                            Cpu_data4bus = {counter0_out, counter1_out, counter2_out, led_out[12:0], SW};
                                          data_ram_we = 0;
                                          counter_we = mem_w;
                                          Peripheral_in = Cpu_data2bus;
                                    end
                                    4'b0000: begin
                                          Cpu_data4bus = {counter0_out, counter1_out, counter2_out, led_out[12:0], SW};// {14'b00000000000000,led_out,2'b00};
                                          data_ram_we = 0;
                                          GPIOf0000000_we = mem_w;
                                          Peripheral_in = Cpu_data2bus; // {GPIOf0[13:0],LED,counter_set}
                                    end
                                    4'b1000: begin //keyboard
                                        Cpu_data4bus = {24'b0, keyboard_data};
                                        keyboard_rdn = 0;
                                    end
                                    default:begin
                                       Cpu_data4bus = {14'b00000000000000,led_out,2'b00};
                           data_ram_we = 0;
                           GPIOf0000000_we = mem_w;
                           Peripheral_in = Cpu_data2bus; // {GPIOf0[13:0],LED,counter_set}
                         end
                              endcase
                        end
                        4'b1110: begin // Seg7 E0000000~EFFFFFFF // BTN & SW
                              GPIOe0000000_we = mem_w;
                              Peripheral_in = Cpu_data2bus;
//                    Peripheral_in = PC;
                              data_ram_we = 0;
                              Cpu_data4bus = {11'b00000000000,BTN,SW};
                        end
                        4'b1100: begin //VRAM
                            VRAM_we = mem_w;
                            VRAM_data_in = Cpu_data2bus[15:0];
                            VRAM_addr = addr_bus[9:1];
                            Cpu_data4bus = 32'b0;
                        end
                        4'b1000: begin//BACK_GRAM
                            BACK_GRAM_we = mem_w;
                            BACK_GRAM_data_in = Cpu_data2bus[7:0];
                            BACK_GRAM_addr = addr_bus[8:0];
                            Cpu_data4bus = 32'b0;
                        end
                        4'b0010: begin//FORE_GRAM
                            FORE_GRAM_we = mem_w;
                            FORE_GRAM_data_in = Cpu_data2bus[7:0];
                            FORE_GRAM_addr = addr_bus[8:0];
                            Cpu_data4bus = 32'b0;
                        end
                        4'b0001: begin //SFR
                            SFR_we = mem_w;
                            SFR_Data_in = Cpu_data2bus[7:0];
                            SFR_Addr = addr_bus[2:0];
                            Cpu_data4bus = {24'b0, SFR_Data_out};
                        end
                        default: begin
                              Cpu_data4bus = ram_data_out;
                              ram_data_in = Cpu_data2bus;
                              ram_addr = addr_bus[12:2];
                              data_ram_we = mem_w;
                        end
                  endcase
            end
                                                                                          
endmodule