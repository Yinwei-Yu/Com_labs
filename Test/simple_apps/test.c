#pragma GCC push_options
#pragma GCC optimize("O0")

typedef unsigned short uint16_t;
typedef unsigned char uint8_t;
typedef unsigned int uint32_t;

// 硬件寄存器定义 volatile保证从内存中读取数据
#define SW_REG (*(volatile uint16_t *)0xF0000000)      // 16位开关
#define DISPLAY_REG (*(volatile uint32_t *)0xE0000000) // 显示设备

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

void main()
{
  while (1)
  {
    const uint16_t sw_val = SW_REG; // 读取16位开关状态

    // 模式判断
    switch (sw_val & 0x0003)
    {            // 取低2位控制模式
    case 0x0001: // 0b01
      display_love();
      break;
    case 0x0002: // 0b10
      display_fib();
      break;
    default:                    // 其他情况显示默认内容
      DISPLAY_REG = 0xC7C0C186; // 显示"LOVE"
      break;
    }
  }
}

// 实时检测开关变化的显示函数
void display_love()
{
  while ((SW_REG & 0x0003) == 0x0001)
  {                           // 持续检查模式
    DISPLAY_REG = 0xFFFFFFF9; // I
    wait(3000000);
    DISPLAY_REG = 0xC7C0C186; // LOVE
    wait(3000000);
    DISPLAY_REG = 0xFF91C0C1; // YOU
    wait(3000000);
  }
}

// 迭代法计算斐波那契 加快速度
uint32_t calculate_fib(uint8_t n)
{
  uint32_t a = 0, b = 1;
  for (uint8_t i = 0; i < n; ++i)
  {
    uint32_t tmp = a + b;
    a = b;
    b = tmp;
  }
  return a;
}

void display_fib()
{
  while ((SW_REG & 0x0003) == 0x0002)
  {
    const uint8_t n = (SW_REG >> 8) & 0xFF; // 取高8位作为输入
    DISPLAY_REG = calculate_fib(n);
    wait(4000000);
  }
}

#pragma GCC pop_options