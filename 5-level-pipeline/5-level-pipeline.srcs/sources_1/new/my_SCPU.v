module my_SCPU (
    input clk,
    input rst,
    input MIO_ready,
    input [31:0] instr,  //inst_in,instruction
    input [31:0] Data_in,  // 从内存中读取的数据
    output mem_w,
    output [31:0] PC_out,
    output [31:0] Addr_out,  // 地址输出
    output [31:0] Data_out,  // 要写入内存的数据 rs2
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
  reg [10:0] cycles;
  always @(posedge clk or posedge rst) begin
    cycles <= cycles + 1;
    if (rst) begin
      cycles <= 0;
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
  assign write_enable = 1;
  assign flush = 0;
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
  //`define WDSel_FromImm 2'b11

  //Write Data to reg select
  always @(*) begin
    case (MEM_WB_WDSel)
      `WDSel_FromALU: WD = MEM_WB_ALUout;
      `WDSel_FromMEM: WD = MEM_WB_DMout_data;
      `WDSel_FromPC:  WD = MEM_WB_Pc + 4;
      //`WDSel_FromImm: WD = MEM_WB_immout;
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
  wire [2:0] DMType;
  wire u_lui;
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
      .i_jalr(i_jalr),
      .u_lui(u_lui)
  );


  //ID/EX regs
  wire [180:0] ID_EX_data_in;
  wire [180:0] ID_EX_data_out;

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
  assign ID_EX_data_in[177] = BrUn;  //177位为BrUn 1bit
  assign ID_EX_data_in[178] = BrLt;  //178位为zero 1bit
  assign ID_EX_data_in[179] = zero;  //179位为zero 1bit
  assign ID_EX_data_in[180] = u_lui;
  Pipeline_reg #(
      .WIDTH(181)
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

  wire [31:0] EX_instr = ID_EX_data_out[31:0];  //指令
  wire [63:32] EX_PC = ID_EX_data_out[63:32];  //PC
  wire [31:0] EX_RD1 = ID_EX_data_out[95:64];  //rs1数据
  wire [31:0] EX_RD2 = ID_EX_data_out[127:96];  //rs2数据
  wire [31:0] EX_immout = ID_EX_data_out[159:128];  //立即数

  //控制信号 传递
  wire EX_RegWrite = ID_EX_data_out[160];  //RegWrite
  wire EX_DMWr = ID_EX_data_out[161];  //DMWr
  wire [1:0] EX_PCSel = ID_EX_data_out[163:162];  //PCSel
  wire EX_ASel = ID_EX_data_out[166];  //ASel
  wire EX_BSel = ID_EX_data_out[167];  //BSel
  wire [4:0] EX_ALUop = ID_EX_data_out[172:168];  //ALUop
  wire [2:0] EX_DMType = ID_EX_data_out[175:173];  //DMType
  wire EX_i_jalr = ID_EX_data_out[176];  //i_jalr
  wire EX_BrUn = ID_EX_data_out[177];  //BrUn
  wire EX_BrLt = ID_EX_data_out[178];  //BrLt
  wire EX_Zero = ID_EX_data_out[179];  //zero
  wire EX_u_lui = ID_EX_data_out[180];
  wire ID_EX_WDSel = ID_EX_data_out[165:164];  //WDSel
  //ALU
  wire [31:0] A;
  wire [31:0] B;
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
      .WB_rd(WB_rd),
      .EX_rs1(EX_rs1),
      .EX_rs2(EX_rs2),
      .forwardA(forwardA),
      .forwardB(forwardB)
  );

  reg [31:0] EX_Data_A;
  reg [31:0] EX_Data_B;

  reg [31:0] EX_MEM_forward_Data;
  reg [31:0] MEM_WB_forward_Data;

//选择从EX/MEM,MEM/WB寄存器中要前递的数据
  always@(*)begin
    case(MEM_WB_WDSel)
      `WDSel_FromALU: begin
        EX_MEM_forward_Data= EX_MEM_ALUout;
        MEM_WB_forward_Data= MEM_WB_ALUout;
      end
      `WDSel_FromMEM: begin
        MEM_WB_forward_Data= MEM_WB_DMout_data;
      end
      `WDSel_FromPC:  begin
        EX_MEM_forward_Data =EX_MEM_PC+ 4;
        MEM_WB_forward_Data = MEM_WB_Pc+ 4;
      end
    endcase
  end

  //00 正常从寄存器读取
  //01 从EX_MEM读取
  //10 从MEM_WB读取
  always @(*) begin
    if (EX_u_lui) begin
      EX_Data_A = 0;
    end else begin
      case (forwardA)
        2'b00: EX_Data_A = EX_RD1;
        2'b01: EX_Data_A = EX_MEM_forward_Data;
        2'b10:   EX_Data_A = MEM_WB_forward_Data;
        default: EX_Data_A = EX_RD1;
      endcase
    end
    case (forwardB)
      2'b00:   EX_Data_B = EX_RD2;
      2'b01:   EX_Data_B = EX_MEM_forward_Data;
      2'b10:   EX_Data_B = MEM_WB_forward_Data;
      default: EX_Data_B = EX_RD2;
    endcase
  end

  assign A = (EX_ASel) ? EX_PC : EX_Data_A;  //第一个
  assign B = (EX_BSel) ? EX_immout : EX_Data_B;  //选择ALU的第二个输入数据


  ALU u_alu (
      .A(A),
      .B(B),
      .ALUop(EX_ALUop),
      .ALUout(ALUout),
      .Zero(Zero)
  );

  //EX/MEM regs
  wire [169:0] EX_MEM_data_in;
  wire [169:0] EX_MEM_data_out;

  assign EX_MEM_data_in[31:0] = EX_instr;  //31-0位为指令
  assign EX_MEM_data_in[63:32] = ALUout;  // 63-32位为ALUout
  assign EX_MEM_data_in[95:64] = EX_Data_B;  //rs2数据,用于写入内存,由于前递的问题,这里选择经过前递单元后的数据
  assign EX_MEM_data_in[96] = EX_RegWrite;  //96位为RegWrite
  assign EX_MEM_data_in[97] = EX_DMWr;  //97位为DMWr
  assign EX_MEM_data_in[100:98] = EX_DMType;  //100-98位为DMType
  assign EX_MEM_data_in[132:101] = EX_PC;  //132-101位为PC
  assign EX_MEM_data_in[134:133] = ID_EX_data_out[165:164];  //134-133位为WDSel
  assign EX_MEM_data_in[166:135] = EX_immout;
  assign EX_MEM_data_in[167] = EX_i_jalr;  //167位为i_jalr
  assign EX_MEM_data_in[169:168] = EX_PCSel;  //168-169位为PCSel

  Pipeline_reg #(
      .WIDTH(170)
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

  wire [31:0] MEM_instr = EX_MEM_data_out[31:0];  //指令
  wire [63:32] EX_MEM_ALUout = EX_MEM_data_out[63:32];  //ALUout
  wire [31:0] MEM_RD2 = EX_MEM_data_out[95:64];  //rs2数据
  wire MEM_DMWr = EX_MEM_data_out[97];  //DMWr
  wire [2:0] MEM_DMType = EX_MEM_data_out[100:98];  //DMType
  wire [31:0] EX_MEM_PC = EX_MEM_data_out[132:101];  //PC
  wire [31:0] EX_MEM_immout = EX_MEM_data_out[166:135];  //immout
  wire MEM_i_jalr = EX_MEM_data_out[167];

  //DM
  assign Addr_out = EX_MEM_ALUout;
  assign Data_out = MEM_RD2;
  assign mem_w = MEM_DMWr;
  assign dm_ctrl = MEM_DMType;

  //MEM/WB regs
  wire [163:0] MEM_WB_data_in;
  wire [163:0] MEM_WB_data_out;

  assign MEM_WB_data_in[31:0] = MEM_instr;  //31-0位为指令
  assign MEM_WB_data_in[63:32] = Data_in;  //63-32位为DM读出的数据
  assign MEM_WB_data_in[95:64] = EX_MEM_ALUout;  //95-64位为ALUout
  assign MEM_WB_data_in[96] = MEM_RegWrite;  //96位为RegWrite
  assign MEM_WB_data_in[128:97] = EX_MEM_PC;  //128-97位为PC
  assign MEM_WB_data_in[130:129] = EX_MEM_data_out[134:133];  //130-129位为WDSel
  assign MEM_WB_data_in[162:131] = EX_MEM_data_out[166:135];  // 162-131位为immout
  assign MEM_WB_data_in[163] = EX_MEM_data_out[167];  //163位为i_jalr

  Pipeline_reg #(
      .WIDTH(163)
  ) MEM_WB (
      clk,
      rst,
      write_enable,
      flush,
      MEM_WB_data_in,
      MEM_WB_data_out
  );

  wire [31:0] MEM_WB_DMout_data = MEM_WB_data_out[63:32];  //DM读出的数据
  wire [31:0] MEM_WB_ALUout = MEM_WB_data_out[95:64];  //ALUout
  wire [31:0] MEM_WB_Pc = MEM_WB_data_out[128:97];  //PC
  wire [ 1:0] MEM_WB_WDSel = MEM_WB_data_out[130:129];  //WDSel
  wire [31:0] MEM_WB_immout = MEM_WB_data_out[162:131];  //immout(for lui)

  assign CPU_MIO = 1'b0;
  assign INT = 1'b0;

endmodule
