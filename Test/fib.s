# 1 1 2 3 5 8 13 21 34 55 89
jal x1, main     # 跳转到main，x0无法保存返回地址，应改为jal x1, main [[7]]

fib:
    addi sp, sp, -16
    sw x1, 0(sp)     # 保存返回地址
    sw x10, 4(sp)    # 保存参数n
    lw x11, 4(sp)    # 取消注释：加载参数n到x11
    
    beq x10, x0, zero # n=0时返回0
    addi x5, x0, 1
    beq x10, x5, one # n=1时返回1
    
    lw x11, 4(sp)    # 重新加载原始n值
    addi x11, x11, -1 # n = n-1
    add x10, x0, x11
    jal x1, fib      # 调用fib(n-1)
    sw x10, 8(sp)    # 保存fib(n-1)结果
    
    lw x11, 4(sp)    # 重新加载原始n值
    addi x11, x11, -2 # n = n-2
    add x10, x0, x11
    jal x1, fib      # 调用fib(n-2)
    
    lw x5, 8(sp)     # 取出fib(n-1)
    add x10, x10, x5 # 计算fib(n-1)+fib(n-2)
    
    lw x1, 0(sp)     # 恢复返回地址
    addi sp, sp, 16  # 释放栈空间
    jalr x0, x1, 0   # 返回调用者

zero:
    addi x10, x0, 0
    lw x1, 0(sp)
    addi sp, sp, 16
    jalr x0, x1, 0

one:
    addi x10, x0, 1
    lw x1, 0(sp)
    addi sp, sp, 16
    jalr x0, x1, 0

main:
    addi x10, x0, 10 # 测试参数n=4
    lui sp, 0x1000     # 修正栈指针初始化值 [[6]]
    jal x1, fib       # 调用fib函数