# RISC-V控制冒险全指令测试程序
# 目标：验证所有分支/跳转指令的流水线行为（含数据冒险处理）

# ----------------- 初始化阶段 -----------------
# 初始化寄存器（混合正负值）
addi x1, x0, 5        # x1 = 5（正数）
addi x2, x0, -3       # x2 = -3（负数）
lui  x3, 0xFFFFF      # x3 = 0xFFFFF000（高位为1）
addi x3, x3, 0x7FF    # x3 = 0xFFFFF7FF（大负数）
addi x4, x0, 0x123   # x4 = 0x123（无符号大值）

# ----------------- 测试1：beq/bne基础分支 -----------------
test_beq:
beq  x1, x1, beq_pass  # 必跳转（x1==x1）
addi x5, x0, 1         # 错误指令（应被清空）
beq_pass:
lui x5,0xBE51    # x5 = 0xBE51（标记beq通过）

test_bne:
bne  x1, x2, bne_pass  # 必跳转（5≠-3）
addi x6, x0, 1         # 错误指令（应被清空）
bne_pass:
lui x6,0x6E62    # x6 = 0x6E62（标记bne通过）

# ----------------- 测试2：有符号比较分支 -----------------
test_blt:
blt  x2, x1, blt_pass  # -3 < 5 → 跳转
addi x7, x0, 1         # 错误指令
blt_pass:
lui x7,0xB174    # x7 = 0xB174

test_bge:
addi x8, x0, 10
bge  x1, x8, fail  # 5 < 10 → 不跳转
lui x8,0xB6E     # x8 = 0xB6E（标记bge正确不跳转）

# ----------------- 测试3：无符号比较分支 -----------------
test_bltu:
bltu x3, x4, bltu_pass # 0xFFFFF7FF < 0x1234 → 无符号false → 不跳转
addi x9, x0, 0xB1      # 应执行（标记bltu正确不跳转）
jal  x0, bltu_end
bltu_pass:
addi x9, x0, 1         # 错误路径
bltu_end:

test_bgeu:
bgeu x3, x4, bgeu_pass # 0xFFFFF7FF> 0x1234 → 无符号true → 跳转
addi x10, x0, 1        # 错误指令
bgeu_pass:
lui x10,0x6E75   # x10 = 0x6E75

# ----------------- 测试4：jal/jalr跳转 -----------------
test_jal:
jal  x11, jal_target   # 跳转并保存返回地址到x11
addi x12, x0, 1        # 错误指令（应被清空）
jal_target:
lui x12,0x7A4C   # x12 = 0x7A4C（标记jal通过）

test_jalr:
addi x13, x0, jalr_back
jalr x14, x13,0       # 跳转到jalr_back，返回地址存x14
addi x15, x0, 1        # 错误指令
jalr_back:
lui x15,0x7A12   # x15 = 0x7A12（标记jalr通过）

# ----------------- 测试5：混合数据依赖分支 -----------------
# 构造前递依赖链
addi x16, x0, 8        # x16 = 8
addi x17, x0, 2        # x17 = 2
sub  x18, x16, x17     # x18 = 6（EX阶段结果）
beq  x18, x16, fail    # 6 ≠ 8 → 不跳转（验证前递）
lui x19, 0x1E5F   # x19 = 0x1E5F（标记前递正确）

# ----------------- 测试6：内存加载后分支 -----------------
# 验证MEM阶段数据用于分支
sw   x19, 0(x0)        # [0x0] = 0x1E5F
lw   x20, 0(x0)        # x20 = 0x1E5F
bne  x20, x19, fail    # 0x1E5F == 0x1E5F → 不跳转
lui x21,0xCAFE   # x21 = 0xCAFE（标记加载正确）

# ----------------- 验证区 -----------------
# 最终寄存器状态应满足以下值（HEX）：
# x5: BE51   x6: 6E62   x7: B174   x8: 0B6E
# x9: 00B1   x10:6E75   x12:7A4C   x15:7A12
# x19:1E5F   x21:CAFE

# 终止执行
inf_loop:
jal x0, inf_loop

# 失败处理
fail:
lui x31,0xDEAD   # 错误标记
jal x0, inf_loop