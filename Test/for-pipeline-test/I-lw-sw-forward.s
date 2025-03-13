# Load/Store指令前递测试程序（含符号扩展、多宽度操作）
# 由于未实现阻塞,这里显式添加了nop指令
# 初始化内存和寄存器
addi x1, x0, 0x100        # x1 = 内存基地址0x100
lui x2,0x1234A
addi x2,x2,0x5e6
addi x2,x2,0x5e7 # x2 = 1234abcd
addi x3, x0, 0xFFFFFEDC   # x3 = 测试数据2（负值）
sw   x2, 0(x1)            # [0x100] = 0x1234ABCD
sh   x3, 4(x1)            # [0x104] = 0xFEDC（半字存储）
sb   x3, 8(x1)            # [0x108] = 0xDC（字节存储）

# ================= 测试场景1：基本前递 =================
# 测试链：SW->LW->ADD（MEM→EX前递）
lw   x4, 0(x1)            # x4 = 0x1234ABCD
nop
addi x5, x4, 0x100        # x5 = 0x1234ABCD + 0x100 = 0x1234ABDD（需要LW数据前递） stall

# ================= 测试场景2：符号扩展 =================
# 测试链：SH->LH->SRAI（符号扩展前递）
lh   x6, 4(x1)            # x6 = 0xFFFFFEDC（有符号半字加载）
lhu  x7, 4(x1)            # x7 = 0x0000FEDC（无符号半字加载）
srai x8, x6, 4            # x8 = 0xFFFFFEDC >> 4 = 0xFFFFFED（验证符号扩展）

# ================= 测试场景3：字节加载前递 =================
lb   x9, 8(x1)            # x9 = 0xFFFFFFDC（有符号字节加载）
lbu  x10, 8(x1)           # x10= 0x000000DC（无符号字节加载）
nop
add  x11, x9, x10         # x11= 0xFFFFFFDC + 0xDC = 0xFFFFFFB8（混合符号类型前递）

# ================= 测试场景4：多层前递 =================
# 测试链：SB->LB->SLLI->SW（EX→EX + MEM→EX前递）
slli x12, x9, 8           # x12= 0xFFDC0000（需要前递lb结果）
sw   x12, 12(x1)          # [0x10C] = 0xFFDC0000
lw   x13, 12(x1)          # x13= 0xFFDC0000
nop
andi x14, x13, 0xFF       # x14= 0x00000000（需要前递lw结果）

# 预期内存状态：
# 0x100: 0x1234ABCD
# 0x104: 0xFEDC
# 0x108: 0xDC
# 0x10C: 0xFFDC0000
# 0x110: 0x00000010

lw x17,0(x1)
lw x18,4(x1)
lw x19,8(x1)
lw x20,0xc(x1)
lw x21,0x10(x1)