`timescale 1ns / 1ps


module top (
    input clk,
    input rstn,
    input [15:0] sw_i,
    input [4:0] btn_i,
    output [7:0] disp_seg_o,
    output [7:0] disp_an_o,
    output [13:0] VGA
);

  wire rst = !rstn;

  //Enter
  wire [4:0] BTN_out;
  wire [15:0] SW_out;
  Enter U10_Enter (
      .clk(clk),
      .BTN(btn_i),
      .SW(sw_i),
      .BTN_out(BTN_out),
      .SW_out(SW_out)
  );

  //clk_div
  wire Clk_CPU;
  wire [31:0] clkdiv;
  clk_div U8_clk_div (
      .clk(clk),
      .rst(rst),
      .SW2(SW_out[2]),
      .clkdiv(clkdiv),
      .Clk_CPU(Clk_CPU),
      .clk_25MHz(clk_25MHz)
  );

  //SPIO
  wire EN = GPIOf0000000_we;
  wire [31:0] P_Data = Peripheral_in;
  wire [1:0] counter_set;
  wire [15:0] LED_out;
  wire [15:0] led;
  wire [13:0] GPIOf0;
  SPIO U7_SPIO (
      .clk(!Clk_CPU),
      .rst(rst),
      .EN(EN),
      .P_Data(P_Data),
      .counter_set(counter_set),
      .LED_out(LED_out),
      .led(led),
      .GPIOf0(GPIOf0)
  );

  //Counter_x
  wire clk0 = clkdiv[6];
  wire clk1 = clkdiv[9];
  wire clk2 = clkdiv[11];
  wire [1:0] counter_ch = counter_set;
  wire [31:0] counter_val = Peripheral_in;
  wire counter_we;

  wire counter0_OUT;
  wire counter1_OUT;
  wire counter2_OUT;
  wire [31:0] counter_out;
  Counter_x U9_Counter_x (
      .clk(!Clk_CPU),
      .rst(rst),
      .clk0(clk0),
      .clk1(clk1),
      .clk2(clk2),
      .counter_we(counter_we),
      .counter_val(counter_val),
      .counter_ch(counter_ch),
      .counter0_OUT(counter0_OUT),
      .counter1_OUT(counter1_OUT),
      .counter2_OUT(counter2_OUT),
      .counter_out(counter_out)
  );

  //SCPU
  wire [31:0] Data_in = Data_read;
  wire INT = counter0_OUT;
  wire MIO_ready;
  wire CPU_MIO = MIO_ready;
  wire [31:0] inst_in = data;

  wire [31:0] Addr_out;
  wire [31:0] Data_out;
  wire [31:0] PC_out;
  wire [2:0] dm_ctrl;
  wire mem_w;
  my_SCPU U1_SCPU (
      .clk(Clk_CPU),
      .rst(rst),
      .MIO_ready(MIO_ready),
      .instr(inst_in),
      .Data_in(Data_in),
      .mem_w(mem_w),
      .PC_out(PC_out),
      .Addr_out(Addr_out),
      .Data_out(Data_out),
      .dm_ctrl(dm_ctrl),
      .CPU_MIO(CPU_MIO),
      .INT(INT)
  );

  //ROM_D
  wire [9:0] addr = PC_out[11:2];
  wire [31:0] data;
  ROM_D U2_ROMD (
      .a  (addr),
      .spo(data)
  );

  //dm_controller
  wire [31:0] Addr_in = Addr_out;
  wire [31:0] Data_read_from_dm = Cpu_data4bus;
  wire [31:0] Data_write = ram_data_in;
  wire [31:0] Data_read;
  wire [31:0] Data_write_to_dm;
  wire [3:0] wea_mem;
  wire [31:0] douta;
  //如需下板,将括号内/**/注释内容和非注释内容反过来
  //如需调试,保持现状
  my_dm_controller U3_dm_controller (
      .mem_w(mem_w),
      .Addr_in(Addr_in),
      .Data_write(  /*Data_out*/ Data_write),
      .dm_ctrl(dm_ctrl),
      .Data_read_from_dm(  /*douta*/ Data_read_from_dm),
      .Data_read(Data_read),
      .Data_write_to_dm(Data_write_to_dm),
      .wea_mem(wea_mem)
  );

  //RAM_B
  wire [9:0] addra = ram_addr;
  wire clka = !clk;  //mind this
  wire [31:0] dina = Data_write_to_dm;
  wire [3:0] wea = wea_mem;

  RAM_B U4_RAM_B (
      .addra(  /*Addr_out*/ addra),
      .clka (clka),
      .dina (dina),
      .wea  (wea),
      .douta(douta)
  );

  //MIO_BUS
  wire [4:0] BTN = BTN_out;
  wire [31:0] Cpu_data2bus = Data_out;
  wire [15:0] SW = SW_out;
  wire [31:0] addr_bus = Addr_out;
  wire counter0_out = counter0_OUT;
  wire counter1_out = counter1_OUT;
  wire counter2_out = counter2_OUT;
  wire [15:0] led_out = LED_out;
  wire [31:0] ram_data_out = douta;

  wire data_ram_we;
  wire [31:0] Cpu_data4bus;
  wire GPIOe0000000_we;
  wire GPIOf0000000_we;
  wire [31:0] Peripheral_in;
  wire [9:0] ram_addr;
  wire [31:0] ram_data_in;

  // 显存信号
  wire [15:0] vram_out;  // 显存读出的数据
  wire [11:0] vram_in;  // 写入显存的数据
  wire [17:0] vram_addr;  // 访问显存的地址
  wire vram_we;  // 写显存使能


  my_MIO_BUS U4_MIO_BUS (
      .clk(clk),
      .rst(rst),
      .BTN(BTN),
      .SW(SW),
      .PC(PC_out),
      .mem_w(mem_w),
      .Cpu_data2bus(Cpu_data2bus),
      .addr_bus(addr_bus),
      .ram_data_out(ram_data_out),
      .led_out(led_out),
      .counter_out(counter_out),
      .counter0_out(counter0_out),
      .counter1_out(counter1_out),
      .counter2_out(counter2_out),
      .Cpu_data4bus(Cpu_data4bus),
      .ram_data_in(ram_data_in),
      .ram_addr(ram_addr),
      .data_ram_we(data_ram_we),
      .GPIOf0000000_we(GPIOf0000000_we),
      .GPIOe0000000_we(GPIOe0000000_we),
      .counter_we(counter_we),
      .Peripheral_in(Peripheral_in),
      .vram_data_out(vram_out[11:0]),
      .vram_data_in(vram_in),
      .vram_addr(vram_addr),
      .vram_we(vram_we)
  );



  //Multi_8CH32
  wire [63:0] LES = 0;
  wire [2:0] Switch = SW_out[7:5];
  wire [31:0] data0 = Peripheral_in;
  wire [31:0] data1 = {1'b0, 1'b0, PC_out[31:2]};
  wire [31:0] data2 = data;
  wire [31:0] data3 = 0;
  wire [31:0] data4 = Addr_out;
  wire [31:0] data5 = Data_out;
  wire [31:0] data6 = Cpu_data4bus;
  wire [31:0] data7 = PC_out;
  wire [63:0] point_in = {clkdiv[31:0], clkdiv[31:0]};

  wire [31:0] Disp_num;
  wire [7:0] LE_out;
  wire [7:0] point_out;
  Multi_8CH32 U5_Multi_8CH32 (
      .clk(!Clk_CPU),
      .rst(rst),
      .EN(GPIOe0000000_we),
      .Switch(Switch),
      .point_in(point_in),
      .LES(~64'h00000000),
      .data0(data0),
      .data1(data1),
      .data2(data2),
      .data3(data3),
      .data4(data4),
      .data5(data5),
      .data6(data6),
      .data7(data7),
      .point_out(point_out),
      .LE_out(LE_out),
      .Disp_num(Disp_num)
  );

  //SSeg7
  SSeg7 U6_SSeg7 (
      .clk(clk),
      .rst(rst),
      .SW0(SW_out[0]),
      .flash(clkdiv[10]),
      .Hexs(Disp_num),
      .point(point_out),
      .LES(LE_out),
      .seg_an(disp_an_o),
      .seg_sout(disp_seg_o)
  );


  wire [15:0] Pixel;
  wire [8:0] row;
  wire [8:0] col;
  wire [17:0] vram_vga_addr = (row * 400 + col) % 262144;  //送给显存的地址
  vga_display_memory U_VRAM (
      // CPU端口 (端口A)
      .clka (clk),              // CPU时钟
      .wea  (vram_we),          // 显存写使能
      .addra(vram_addr),        // CPU操作显存地址
      .dina ({4'b0, vram_in}),  // 显存写入数据
      .douta(vram_out),         // 显存读出数据
      //显存端口
      .clkb (clk),
      .web  (1'b0),             //只读
      .addrb(vram_vga_addr),    //vga扫描地址
      .dinb (16'b0),            //不需要写入
      .doutb(Pixel)             //向vga输出的像素
  );


  wire [3:0] Red;
  wire [3:0] Green;
  wire [3:0] Blue;
  wire Hsync;
  wire Vsync;
  assign VGA = {Vsync, Hsync, Blue, Green, Red};

  VGAIO U_VGAIO (
      .clk(clk),
      .rst(rst),
      .Pixel(Pixel[11:0]),
      .row(row),
      .col(col),
      .R(Red),
      .G(Green),
      .B(Blue),
      .HSYNC(Hsync),
      .VSYNC(Vsync),
      .VRAMA(),
      .rdn()
  );


endmodule
