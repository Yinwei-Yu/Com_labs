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

void display_love();
void display_fib();

void draw_test_pattern() {
    unsigned int addr = 0;
    // 绘制水平彩色条纹
    for (int y = 0; y < 480; y++) {
        unsigned int color = ((y / 40) % 8) * 0x111;  // 生成不同颜色
        for (int x = 0; x < 640; x += 2) {  // 每次写入两个像素(32位)
            // 打包两个12位像素到一个32位字
            unsigned int pixel_data = (color << 16) | color;
            vram[addr++] = pixel_data;
        }
    }
}

void main()
{
  draw_test_pattern();
    while(1);  // 程序结束后循环
}


#pragma GCC pop_options