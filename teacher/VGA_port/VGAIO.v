module VGAIO (
    input             clk,
    input             rst,    //100MHz时钟
    input      [11:0] Pixel,  //图形显示像素输入：RRRR_GGGG_BBBB
    output     [ 8:0] row,    // pixel ram row address, 480 lines
    output     [ 8:0] col,    // pixel ram col address, 640 pixels
    output     [ 3:0] R,
    G,
    B,
    output reg        HSYNC,
    VSYNC,
    output     [12:0] VRAMA,  //文本显示缓冲地址
    output            rdn     //VAM地址
);

  wire [11:0] pixel_in = Pixel[11:0];
  wire h_sync;
  wire v_sync;
  wire read ;
  reg [3:0] red, green, blue;
  reg [15:0] VRAM_BUF;

  reg [ 2:0] VGACLK;
  always @(posedge clk) VGACLK <= VGACLK + 1;  //同步时钟分频

  //调用显示扫描同步模块：vga_core		
  VGA_Scan VScans (
      .clk   (VGACLK[1]),  //25MHz						
      .rst   (rst),
      .row   (row),        //像素行坐标
      .col   (col),        //像素列坐标
      .Active(read),       //视频有效
      .HSYNC (h_sync),     //行扫描同步
      .VSYNC (v_sync)      //列扫描同步
  );

  //vga signals输出
  always @(posedge VGACLK[1]) begin
    HSYNC <= h_sync;  // horizontal synchronization
    VSYNC <= v_sync;  // vertical   synchronization
    red     <= read ? pixel_in[3:0] : 4'h0;  // 4-bit red
    green     <= read ? pixel_in[7:4] : 4'h0;  // 4-bit green
    blue     <= read ? pixel_in[11:8] : 4'h0;  // 4-bit blue
  end
	assign R = red;
	assign G = green;
	assign B = blue;
endmodule
