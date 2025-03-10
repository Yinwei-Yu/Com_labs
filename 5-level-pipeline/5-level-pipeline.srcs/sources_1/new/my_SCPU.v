module my_SCPU (
    input clk,
    input rst,
    input MIO_ready,
    input [31:0] instr,  //inst_in,instruction
    input [31:0] Data_in,
    output mem_w,
    output [31:0] PC_out,
    output [31:0] Addr_out,
    output [31:0] Data_out,
    output [2:0] dm_ctrl,
    output CPU_MIO,
    input INT
);

  /////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////

  //Instruction Fetch IF阶段

  //PC update
  reg [31:0] PC;
  wire [1:0] PCSel;
  wire i_jalr;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      PC <= 0;
    end else begin
      if (PCSel == 2'b00) begin
        PC <= PC + 4;
      end else if (PCSel == 2'b01) begin
        PC <= PC + immout;
      end else if (PCSel == 2'b10) begin
        PC <= (i_jalr) ? (ALUout & 32'hFFFFFFFE) : ALUout;
      end else begin
        PC <= PC + 4;
      end
    end
  end

  assign PC_out = PC;

  //IF/ID regs
  assign write_enable=1;
  assign flush=0;
  wire [63:0] IF_ID_data_in;
  wire [63:0] IF_ID_data_out;

  assign IF_ID_data_in[31:0]  = instr;  //31-0位为指令
  assign IF_ID_data_in[63:32] = PC;  //63-32位为PC

  Pipeline_reg #(
      .WIDTH(64)
  ) IF_ID (
      clk,
      rst,
      write_enable,
      flush,
      IF_ID_data_in,
      IF_ID_data_out
  );

  ////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////

  //instuction decode ID阶段

  wire [6:0] Op;
  wire [4:0] rd_addr;
  wire [6:0] Funct7;
  wire [2:0] Funct3;
  wire [4:0] rs1_addr;
  wire [4:0] rs2_addr;

  wire [31:0] ID_instr = IF_ID_data_out[31:0];
  wire [31:0] ID_PC = IF_ID_data_out[63:32];

  assign Op = ID_instr[6:0];
  assign rd_addr = ID_instr[11:7];
  assign Funct3 = ID_instr[14:12];
  assign rs1_addr = ID_instr[19:15];
  assign rs2_addr = ID_instr[24:20];
  assign Funct7 = ID_instr[31:25];


  //EXT imm extend unit
  wire [ 5:0] EXTOp;
  wire [31:0] immout;

  EXT u_ext (
      .iimm_shamt(ID_instr[24:20]),
      .iimm(ID_instr[31:20]),
      .simm({ID_instr[31:25], ID_instr[11:7]}),
      .bimm({ID_instr[31], ID_instr[7], ID_instr[30:25], ID_instr[11:8]}),
      .uimm(ID_instr[31:12]),
      .jimm({ID_instr[31], ID_instr[19:12], ID_instr[20], ID_instr[30:21]}),
      .EXTOp(EXTOp),
      .immout(immout)
  );


  // RF
  wire RegWrite;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  reg [31:0] WD;
  wire [31:0] RD1;
  wire [31:0] RD2;
  wire [1:0] WDSel;

  assign rs1 = rs1_addr;
  assign rs2 = rs2_addr;
  assign rd  = MEM_WB_data_out[11:7];

  `define WDSel_FromALU 2'b00
  `define WDSel_FromMEM 2'b01
  `define WDSel_FromPC 2'b10
  `define WDSel_FromImm 2'b11

  //Write Data to reg select
  always @(*) begin
    case (MEM_WDsel)
      `WDSel_FromALU: WD = ALU_data_into_reg;
      `WDSel_FromMEM: WD = DM_data_into_reg;
      `WDSel_FromPC:  WD = PC_for_reg + 4;
      `WDSel_FromImm: WD = immout;
    endcase
  end

  wire RegWrite_MEM_out = MEM_WB_data_out[96];  //RegWrite
  RF u_rf (
      .clk (clk),
      .rst (rst),
      .RFWr(RegWrite_MEM_out),
      .A1  (rs1),
      .A2  (rs2),
      .A3  (rd),
      .WD  (WD),
      .RD1 (RD1),
      .RD2 (RD2)
  );

  wire BrUn;
  wire BrLt = BrUn ? (RD1 < RD2) : ($signed(RD1) < $signed(RD2));  //less than for blt bltu bge bgeu
  wire zero = RD1 == RD2 ? 1'b1 : 1'b0;
  wire [4:0] ALUop;
  wire ASel;
  wire BSel;
  //wire PCSel;
  wire DMType;

  //Control Unit
  Ctrl u_ctrl (
      .Op(Op),
      .Funct3(Funct3),
      .Funct7(Funct7),
      .Zero(Zero),
      .BrLt(BrLt),
      .BrUn(BrUn),
      .RegWrite(RegWrite),
      .MemWrite(DMWr),
      .EXTOp(EXTOp),
      .ALUOp(ALUop),
      .ASel(ASel),
      .BSel(BSel),
      .DMType(DMType),
      .WDSel(WDSel),
      .PCSel(PCSel),
      .i_jalr(i_jalr)
  );


  //ID/EX regs
  wire [176:0] ID_EX_data_in;
  wire [176:0] ID_EX_data_out;

  assign ID_EX_data_in[31:0] = ID_instr;  //31-0位为指令
  assign ID_EX_data_in[63:32] = ID_PC;  //63-32位为PC
  assign ID_EX_data_in[95:64] = RD1;  //95-64位为rs1读出的数据
  assign ID_EX_data_in[127:96] = RD2;  //127-66位为rs2读出的数据
  assign ID_EX_data_in[159:128] = immout;  //159-128位为立即数
  //控制信号 传递
  assign ID_EX_data_in[160] = RegWrite;  //160位为RegWrite
  assign ID_EX_data_in[161] = DMWr;  //161位为DMWr
  assign ID_EX_data_in[163:162] = PCSel;  //163-162位为PCSel
  assign ID_EX_data_in[165:164] = WDSel;  //165-164位为WDSel
  assign ID_EX_data_in[166] = ASel;  //166位为ASel 1bit 
  assign ID_EX_data_in[167] = BSel;  //167位为BSel 1bit
  assign ID_EX_data_in[172:168] = ALUop;  //172-168位为ALUop 5bit
  assign ID_EX_data_in[175:173] = DMType;  //175-173位为DMType 3bit
  assign ID_EX_data_in[176] = i_jalr;  //176位为i_jalr 1bit


  Pipeline_reg #(
      .WIDTH(177)
  ) ID_EX (
      clk,
      rst,
      write_enable,
      flush,
      ID_EX_data_in,
      ID_EX_data_out
  );


  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  //EX阶段 

  wire [31:0]EX_instr = ID_EX_data_out[31:0];  //指令
  wire [31:0] EX_RD1= ID_EX_data_out[95:64];  //rs1数据
  wire [31:0] EX_RD2= ID_EX_data_out[127:96];  //rs2数据
  wire [31:0] EX_immout= ID_EX_data_out[159:128];  //立即数
  wire [63:32]EX_PC = ID_EX_data_out[63:32];  //PC
  //控制信号 传递
  wire EX_RegWrite = ID_EX_data_out[160];  //RegWrite
  wire EX_DMWr = ID_EX_data_out[161];  //DMWr
  wire [4:0]EX_ALUop = ID_EX_data_out[172:168];  //ALUop
  wire EX_ASel = ID_EX_data_out[166];  //ASel
  wire EX_BSel = ID_EX_data_out[167];  //BSel
  wire [1:0]EX_PCSel = ID_EX_data_out[163:162];  //PCSel
  wire [2:0] EX_DMType= ID_EX_data_out[175:173];  //DMType

  //ALU
  reg [31:0] A;
  reg [31:0] B;
  wire [31:0] ALUout;

  wire MEM_RegWrite = EX_MEM_data_out[96];  //RegWrite 
  wire [4:0] MEM_rd = EX_MEM_data_out[11:7];  //rd
  wire [4:0] WB_rd = MEM_WB_data_out[11:7];  //rd
  wire [4:0] EX_rs1 = ID_EX_data_out[19:15];  //rs1
  wire [4:0] EX_rs2 = ID_EX_data_out[24:20];  //rs2
  wire [1:0] forwardA;
  wire [1:0] forwardB;

  Forward u_forward (
      .MEM_RegWrite(MEM_RegWrite),
      .MEM_rd(MEM_rd),
      .WB_RegWrite(RegWrite_MEM_out),
      .WB_rd(MEM_rd),
      .EX_rs1(EX_rs1),
      .EX_rs2(EX_rs2),
      .forwardA(forwardA),
      .forwardB(forwardB)
  );

  wire [31:0]EX_Data_2 = (EX_BSel) ? EX_immout : EX_RD2;//选择ALU的第一个输入数据
  wire [31:0]EX_Data_1 = (EX_ASel) ? EX_PC : EX_RD1;//第二个

  always@(*)begin
    case(forwardA)
      2'b00: A = EX_Data_1;
      2'b01: A = MEM_ALUout;
      2'b10: A = DM_data_into_reg;
      default: A = EX_Data_1;
    endcase
    case (forwardB)
      2'b00: B = EX_Data_2;
      2'b01: B = MEM_ALUout;
      2'b10: B = DM_data_into_reg;
      default: B=EX_Data_2;
    endcase
  end


  ALU u_alu (
      .A(A),
      .B(B),
      .ALUop(EX_ALUop),
      .ALUout(ALUout),
      .Zero(Zero)
  );

  //EX/MEM regs
  wire [134:0] EX_MEM_data_in;
  wire [134:0] EX_MEM_data_out;

  assign EX_MEM_data_in[31:0] = EX_instr;  //31-0位为指令
  assign EX_MEM_data_in[63:32] = ALUout;  // 63-32位为ALUout
  assign EX_MEM_data_in[95:64] = EX_RD2;  //95-64位为rs2读出的数据
  assign EX_MEM_data_in[96] = EX_RegWrite;  //96位为RegWrite
  assign EX_MEM_data_in[97] = EX_DMWr;  //97位为DMWr
  assign EX_MEM_data_in[100:98] = EX_DMType;  //100-98位为DMType
  assign EX_MEM_data_in[132:101] = EX_PC;  //132-101位为PC
  assign EX_MEM_data_in[134:133] = ID_EX_data_out[165:164];  //134-133位为WDSel

  Pipeline_reg #(
      .WIDTH(135)
  ) EX_MEM (
      clk,
      rst,
      write_enable,
      flush,
      EX_MEM_data_in,
      EX_MEM_data_out
  );

  //////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  //MEM 阶段

  wire [31:0]MEM_instr = EX_MEM_data_out[31:0];  //指令
  wire [63:32] MEM_ALUout= EX_MEM_data_out[63:32];  //ALUout
  wire [31:0]MEM_RD2 = EX_MEM_data_out[95:64];  //rs2数据
  wire MEM_DMWr = EX_MEM_data_out[97];  //DMWr
  wire [2:0]MEM_DMType = EX_MEM_data_out[99:97];  //DMType
  wire [31:0]MEM_PC = EX_MEM_data_out[131:100];  //PC

  //DM
  assign Addr_out = MEM_ALUout;
  assign Data_out = MEM_RD2;
  assign mem_w = MEM_DMWr;
  assign dm_ctrl = MEM_DMType;

  //MEM/WB regs
  wire [130:0] MEM_WB_data_in;
  wire [130:0] MEM_WB_data_out;

  assign MEM_WB_data_in[31:0] = MEM_instr;  //31-0位为指令
  assign MEM_WB_data_in[63:32] = Data_in;  //63-32位为DM读出的数据
  assign MEM_WB_data_in[95:64] = MEM_ALUout;  //95-64位为ALUout
  assign MEM_WB_data_in[96] = MEM_RegWrite;  //96位为RegWrite
  assign MEM_WB_data_in[128:97] = MEM_PC;  //128-97位为PC
  assign MEM_WB_data_in[130:129] = EX_MEM_data_out[133:132];  //165-164位为WDSel

  Pipeline_reg #(
      .WIDTH(131)
  ) MEM_WB (
      clk,
      rst,
      write_enable,
      flush,
      MEM_WB_data_in,
      MEM_WB_data_out
  );

  wire [31:0]DM_data_into_reg = MEM_WB_data_out[63:32];  //DM读出的数据
  wire [31:0]ALU_data_into_reg = MEM_WB_data_out[95:64];  //ALUout
  wire [31:0]PC_for_reg = MEM_WB_data_out[128:97];  //PC
  wire [1:0]MEM_WDsel = MEM_WB_data_out[130:129];  //WDSel

  assign CPU_MIO = 1'b0;
  assign INT = 1'b0;

endmodule
