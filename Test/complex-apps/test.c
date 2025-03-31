#pragma GCC push_options
#pragma GCC optimize("O0")

typedef unsigned short uint16_t;
typedef unsigned char uint8_t;
typedef unsigned int uint32_t;

// 硬件寄存器定义 volatile保证从内存中读取数据
volatile uint32_t *vram = (volatile unsigned int *)0xC0000000;
void start()
{
  asm("li\tsp,1024\n\t" // 设置栈指针
      "call main");     // 跳转到main
}

__attribute__((noinline)) void wait(uint32_t cycles)
{
  while (cycles--)
    ;
}

void draw_color_bars()
{
  unsigned int addr = 0;

  // 预定义各种彩色
  const unsigned int colors[8] = {
      0xF00, // 红色
      0x0F0, // 绿色
      0x00F, // 蓝色
      0xFF0, // 黄色
      0xF0F, // 紫色
      0x0FF, // 青色
      0xFFF, // 白色
      0x888  // 灰色
  };

  // 绘制水平彩色条纹
  for (int y = 0; y < 480; y++)
  {
    // 计算颜色索引 - 每60行切换一种颜色
    unsigned int color_idx;

    if (y < 60)
      color_idx = 0; // 红色
    else if (y < 120)
      color_idx = 1; // 绿色
    else if (y < 180)
      color_idx = 2; // 蓝色
    else if (y < 240)
      color_idx = 3; // 黄色
    else if (y < 300)
      color_idx = 4; // 紫色
    else if (y < 360)
      color_idx = 5; // 青色
    else if (y < 420)
      color_idx = 6; // 白色
    else
      color_idx = 7; // 灰色

    // 获取对应颜色
    unsigned int color = colors[color_idx];

    // 绘制一行像素
    for (int x = 0; x < 640; x += 2)
    {
      // 打包两个像素（避免使用位移替代乘法）
      unsigned int pixel_data = color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;
      vram[addr] = pixel_data;
      addr++;
    }
  }
}

void draw_rainbow_diagonal()
{
  unsigned int addr = 0;

  // 彩虹颜色
  const unsigned int rainbow[7] = {
      0xF00, // 红
      0xF80, // 橙
      0xFF0, // 黄
      0x0F0, // 绿
      0x0FF, // 青
      0x00F, // 蓝
      0xF0F  // 紫
  };

  for (int y = 0; y < 480; y++)
  {
    for (int x = 0; x < 640; x += 2)
    {
      // 根据x和y的和来选择颜色，创建对角线图案
      unsigned int sum = (x + y) & 0x1FF; // 限制在0-511范围内
      unsigned int color_idx;

      if (sum < 73)
        color_idx = 0;
      else if (sum < 146)
        color_idx = 1;
      else if (sum < 219)
        color_idx = 2;
      else if (sum < 292)
        color_idx = 3;
      else if (sum < 365)
        color_idx = 4;
      else if (sum < 438)
        color_idx = 5;
      else
        color_idx = 6;

      unsigned int color = rainbow[color_idx];

      // 打包两个像素
      unsigned int pixel_data = color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;

      vram[addr] = pixel_data;
      addr++;
    }
  }
}

void draw_checkerboard() {
  unsigned int addr = 0;
  
  // 黑白两色
  const unsigned int colors[2] = {
      0x000,  // 黑色
      0xFFF   // 白色
  };
  
  // 棋盘格大小 - 使用2的幂次方便用位运算替代除法
  const int square_size = 32;  // 改为32，这样可以用位移替代除法
  const int square_mask = 0x1F;  // 2^5 - 1 = 31，用于计算模运算
  
  for (int y = 0; y < 480; y++) {
    // 计算y所在的棋盘格行数，使用位移替代除法
    int y_block = y >> 5;  // y / 32，相当于y / square_size
    
    for (int x = 0; x < 640; x += 2) {
      // 计算x所在的棋盘格列数，使用位移替代除法
      int x_block = x >> 5;  // x / 32，相当于x / square_size
      
      // 根据棋盘格的奇偶性选择颜色
      unsigned int color_idx = (x_block + y_block) & 1;
      unsigned int color = colors[color_idx];
      
      // 打包两个像素
      unsigned int pixel_data = color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;
      pixel_data = (pixel_data << 4) | color;
      
      vram[addr] = pixel_data;
      addr++;
    }
  }
}

void main()
{
  while (1)
  {
    // 先显示彩色条纹
    draw_color_bars();

    wait(50000000); // 延时一段时间

    // 然后显示彩虹对角线
    draw_rainbow_diagonal();

    wait(50000000); // 延时一段时间

    // 最后显示棋盘格
    draw_checkerboard();

  } // 程序结束后循环
}

#pragma GCC pop_options