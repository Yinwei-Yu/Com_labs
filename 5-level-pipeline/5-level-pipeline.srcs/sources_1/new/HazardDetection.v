module HazardDetection(
    input        ID_EX_MemRead,
    input [4:0]  EX_rd,
    input [4:0]  ID_rs1,
    input [4:0]  ID_rs2,
    output       loadUseHazard
);

// 使用连续赋值实现组合逻辑
assign loadUseHazard = (ID_EX_MemRead && 
                       ((EX_rd == ID_rs1) || (EX_rd == ID_rs2)) && 
                       (EX_rd != 5'b0)) ? 1'b1 : 1'b0;

endmodule