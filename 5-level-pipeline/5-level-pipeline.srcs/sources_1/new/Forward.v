module Forward(
  input MEM_RegWrite,
  input [4:0] MEM_rd,
  input WB_RegWrite,
  input [4:0] WB_rd,
  input [4:0] EX_rs1,
  input [4:0] EX_rs2,
  output reg [1:0] forwardA,
  output reg [1:0] forwardB
);

`define FORWARD_REG 2'b00//正常情况从寄存器读取
`define FORWARD_ALU 2'b01//从ALU读取
`define FORWARD_DM 2'b10//从DM读取

always @(*)begin
  if(MEM_RegWrite&& (MEM_rd != 0) && (MEM_rd == EX_rs1))begin//从ALU读取的条件
    forwardA = `FORWARD_ALU;
  end
  else if(WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rs1))begin//从DM读取的条件
    forwardA = `FORWARD_DM;
  end
  else begin
    forwardA = `FORWARD_REG;
  end
end

always @(*)begin
  if(MEM_RegWrite && (MEM_rd != 0) && (MEM_rd == EX_rs2))begin//从ALU读取的条件
    forwardB = `FORWARD_ALU;
  end
  else if(WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rs2))begin//从DM读取的条件
    forwardB = `FORWARD_DM;
  end
  else begin
    forwardB = `FORWARD_REG;
  end
end
  

endmodule