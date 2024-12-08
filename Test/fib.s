jal x0,main # 1 1 2 3 5 8 13
fib:
    addi sp,sp,-16
    sw x1,0(sp) # 保存返回地址
    sw x10,4(sp) # 保存参数n
    #lw x11,4(sp) # 加载参数n到x11
    
    beq x10,x0,zero # n==0 return 0
    addi x5,x0,1
    beq x10,x5,one # n==1 return 1
    
    lw x11,4(sp)
    addi x11,x11,-1 # n = n -1
    add x10,x0,x11
    jal x1,fib # call fib(n-1)
    sw x10,8(sp) # 保存fib(n-1) 的结果到栈中
    lw x11,4(sp) # 重新加载x10
    addi x11,x11,-2 # n = n - 2
    add x10,x0,x11
    jal x1,fib # call fib(n-2)
    lw x5,8(sp) # 取出fib（n-1）
    add x10,x10,x5 # 相加
    lw x1,0(sp)
    addi sp,sp,16 # 恢复堆栈
    jalr x0,x1,0
    
zero:
    addi x10,x0,0
    lw x1,0(sp) # 恢复返回地址
    addi sp,sp,16
    jalr x0,x1,0
    
one:
    addi x10,x0,1
    lw x1,0(sp)
    addi sp,sp,16
    jalr x0,x1,0
    
main:
    addi x10,x0,4 # main
    addi sp,x0,128
    jal x1,fib