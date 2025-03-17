# RISC-V Assembly Code for 5-stage Pipeline CPU Testing

# Initialize registers with known values
addi x1, x0, 1          # x1 = 1
addi x2, x0, 2          # x2 = 2
addi x3, x0, 3          # x3 = 3
addi x4, x0, 4          # x4 = 4

# Test R-type instructions
add x5, x1, x2          # x5 = x1 + x2 = 1 + 2 = 3
sub x6, x3, x1          # x6 = x3 - x1 = 3 - 1 = 2
or x7, x2, x3           # x7 = x2 | x3 = 2 | 3 = 3
and x8, x1, x4          # x8 = x1 & x4 = 1 & 4 = 0
xor x9, x2, x4          # x9 = x2 ^ x4 = 2 ^ 4 = 6
sll x10, x3, x1         # x10 = x3 << x1 = 3 << 1 = 6
lui x4,0x80000
srl x11, x4, x1         # x11 = x4 >> x1 = 4 >> 1 = 0x40000
sra x12, x4, x1         # x12 = x4 >> x1 (arithmetic) = 4 >> 1 = 0xc000
slt x13, x1, x2         # x13 = (x1 < x2) ? 1 : 0 = 1
sltu x14, x2, x1        # x14 = (x2 < x1) unsigned ? 1 : 0 = 0

# Test U-type instructions
lui x15, 0x12345        # x15 = 0x12345000
auipc x16, 0x6789       # x16 = PC + 0x6789000 =(PC  as 40) x16=0x6789040

# Test S-type instructions (store)
sw x5, 0(x0)            # Store x5 (3) at address 0
sh x6, 4(x0)            # Store lower half of x6 (2) at address 4
sb x7, 8(x0)            # Store lowest byte of x7 (3) at address 8

# Test I-type instructions (load, also used for forwarding)
lw x17, 0(x0)           # x17 = 3 (load from address 0)
lh x18, 4(x0)           # x18 = 2 (load halfword from address 4)
lb x19, 8(x0)           # x19 = 3 (load byte from address 8)

# Test forwarding: EX-EX
add x20, x5, x6         # x20 = x5 + x6 = 3 + 2 = 5
add x21, x20, x7        # x21 = x20 + x7 = 5 + 3 = 8 (EX-EX forwarding)

# Test forwarding: MEM-EX
lw x22, 0(x0)           # x22 = 3 (load from address 0)
add x23, x22, x1        # x23 = x22 + x1 = 3 + 1 = 4 (MEM-EX forwarding)

# Test forwarding: lw and bne combined
lw x24, 0(x0)           # x24 = 3 (load from address 0)
beq x24, x5, skip       # x24 == x5 (3 == 3), so branch
addi x25, x0, 1         # x25 = 1 (should not execute)
skip:
addi x25, x0, 2         # x25 = 2 (executes)

# Test branch prediction error and stalling
# Assume predictor predicts taken, but branch not taken
beq x1, x2, taken       # x1 != x2 (1 != 2), branch not taken
addi x27, x0, 3         # x27 = 3 (should execute)
j end_taken             # Skip taken section
taken:
addi x28, x0, 4         # x28 = 4 (should not execute if branch correct)
end_taken:

# Verify results by storing expected values in registers
# Set x31 as test status: 1 = pass, 0 = fail
addi x31, x0, 1         # Assume pass initially

# Check R-type results (simplified: non-zero means computed)
addi x1,x0,3
beq x5, x1, check1      # x5 should be 3
jal fail
check1:
addi x1,x0,2
beq x6, x1, check2      # x6 should be 2
jal fail
check2:
addi x1,x0,3
beq x7, x1, check3      # x7 should be 3
jal fail
check3:
beq x8, x0, check4      # x8 should be 0
j fail
check4:
addi x1,x0,6
beq x9, x1, check5      # x9 should be 6
jal fail
check5:
addi x1,x0,6
beq x10, x1, check6     # x10 should be 6
jal fail
check6:
lui x1,0x40000
beq x11, x1, check7     # x11 should be 2
jal fail
check7:
lui x1,0xc0000
beq x12, x1, check8     # x12 should be 2
jal fail
check8:
addi x1,x0,1
beq x13, x1, check9     # x13 should be 1
jal fail
check9:
beq x14, x0, check10    # x14 should be 0
jal fail
check10:

# Check load/store (S-type and I-type)
bne x17, x5, fail       # x17 should be 3 (matches x5)
bne x18, x6, fail       # x18 should be 2 (matches x6)
bne x19, x7, fail       # x19 should be 3 (matches x7)

# Check forwarding results
addi x8, x0, 5          # Temp: x8 = 5 for comparison
bne x20, x8, fail       # x20 should be 5
addi x8, x0, 8          # Temp: x8 = 8
bne x21, x8, fail       # x21 should be 8
addi x8, x0, 4          # Temp: x8 = 4
bne x23, x8, fail       # x23 should be 4
addi x8, x0, 2          # Temp: x8 = 1
bne x25, x8, fail       # x25 should be 1 (lw-bne forwarding)

# Check branch prediction result
beq x27, x0, fail        # x27 should be 3 (non-zero), branch not taken
beq x0,x0,end

fail:
addi x31, x0, 0         # Test failed, set x31 = 0

end:
# End of test, x31 indicates pass (1) or fail (0)
addi x1,x0,666