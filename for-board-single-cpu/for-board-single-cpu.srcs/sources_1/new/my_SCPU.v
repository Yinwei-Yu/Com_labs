module my_SCPU (
    input clk,
    input rstn,
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

  //THE TRUE CPU HERE
  //PC update
  reg  [31:0] PC;
  wire [31:0] instr;
  wire [ 1:0] PCSel;
  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      PC <= 0;
    end else begin
      if (PCSel == 2'b00) begin
        PC <= PC + 4;
      end else if (PCSel == 2'b01) begin
        PC <= PC + immout;
      end else if (PCSel == 2'b10) begin
        PC <= ALUout;
      end else begin
        PC <= PC + 4;
      end
    end
  end

  assign PC_out = PC;

  //instuction decode
  wire [6:0] Op;
  wire [4:0] rd_addr;
  wire [6:0] Funct7;
  wire [2:0] Funct3;
  wire [4:0] rs1_addr;
  wire [4:0] rs2_addr;

  //reg [31:0] imm;
  assign Op = instr[6:0];
  assign rd_addr = instr[11:7];
  assign Funct3 = instr[14:12];
  assign rs1_addr = instr[19:15];
  assign rs2_addr = instr[24:20];
  assign Funct7 = instr[31:25];

  //EXT imm extend unit
  wire [ 5:0] EXTOp;
  wire [31:0] immout;

  EXT u_ext (
      .iimm_shamt(instr[24:20]),
      .iimm(instr[31:20]),
      .simm({instr[31:25], instr[11:7]}),
      .bimm({instr[31], instr[7], instr[30:25], instr[11:8]}),
      .uimm(instr[31:12]),
      .jimm({instr[31], instr[19:12], instr[20], instr[30:21]}),
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
  assign rd  = rd_addr;

  `define WDSel_FromALU 2'b00
  `define WDSel_FromMEM 2'b01
  `define WDSel_FromPC 2'b10
  `define WDSel_FromImm 2'b11

  //Write Data to reg select
  always @(*) begin
    case (WDSel)
      `WDSel_FromALU: WD = ALUout;
      `WDSel_FromMEM: WD = Data_in;
      `WDSel_FromPC:  WD = PC + 4;
      `WDSel_FromImm: WD = immout;
    endcase
  end

  RF u_rf (
      .clk (clk),
      .rst (rstn),
      .RFWr(RegWrite),
      .A1  (rs1),
      .A2  (rs2),
      .A3  (rd),
      .WD  (WD),
      .RD1 (RD1),
      .RD2 (RD2)
  );

  //ALU
  wire [31:0] A;
  wire [31:0] B;
  wire [31:0] ALUout;
  wire [4:0] ALUop;
  wire Zero;
  wire ASel;
  wire BSel;

  assign B = (BSel) ? immout : RD2;
  assign A = ASel ? PC : RD1;

  ALU u_alu (
      .A(A),
      .B(B),
      .ALUop(ALUop),
      .ALUout(ALUout),
      .Zero(Zero)
  );


  //DM
  wire DMWr;
  wire [2:0] DMType;
  assign Addr_out = ALUout;
  assign Data_out = RD2;
  assign mem_w = DMWr;
  assign dm_ctrl = DMType;

  wire BrUn;
  wire BrLt = BrUn ? (RD1 < RD2) : ($signed(RD1) < $signed(RD2));  //less than for blt bltu bge bgeu

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
      .PCSel(PCSel)
  );

  assign CPU_MIO = 1'b0;
  assign INT = 1'b0;

endmodule
