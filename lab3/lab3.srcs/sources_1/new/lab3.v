`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/17 21:11:44
// Design Name: 
// Module Name: lab3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab3 (
    input clk,
    input rstn,
    input [15:0] sw_i,
    output [7:0] disp_seg_o,
    output [7:0] disp_an_o
);
  reg [31:0] clkdiv;
  wire clk_cpu;

  always @(posedge clk or negedge rstn) begin
    if (!rstn) clkdiv <= 0;
    else clkdiv <= clkdiv + 1'b1;
  end
  assign clk_cpu = (sw_i[15]) ? clkdiv[27] : clkdiv[25];

  reg [63:0] display_data;
  reg [ 5:0] led_data_addr;
  reg [63:0] led_disp_data;
  parameter LED_DATA_NUM = 10;

  reg [63:0] LED_DATA[10:0];
  initial begin
    LED_DATA[0]  = 64'hfffffffefefefefe;
    LED_DATA[1]  = 64'hfffefefefefeffff;
    LED_DATA[2]  = 64'hdefefefeffffffff;
    LED_DATA[3]  = 64'hcefefeffffffffff;
    LED_DATA[4]  = 64'hc2ffffffffffffff;
    LED_DATA[5]  = 64'hc1feffffffffffff;
    LED_DATA[6]  = 64'hf1fcffffffffffff;
    LED_DATA[7]  = 64'hfdf8f7ffffffffff;
    LED_DATA[8]  = 64'hfff8f3ffffffffff;
    LED_DATA[9]  = 64'hfffbf1feffffffff;
    LED_DATA[10] = 64'hfffff9f8ffffffff;
  end

  //data display
  wire [31:0] ac_instr;
  reg  [31:0] reg_data;
  reg  [31:0] alu_disp_data;
  reg  [31:0] dmem_data;

  //choose display source data

  always @(sw_i) begin
    if (sw_i[0] == 0) begin
      case (sw_i[14:11])
        4'b1000: display_data = ac_instr;
        4'b0100: display_data = reg_data;
        4'b0010: display_data = alu_disp_data;
        4'b0001: display_data = dmem_data;
        default: display_data = ac_instr;
      endcase
    end else begin
      display_data = led_disp_data;
    end
  end

  //rom data(instrs) display
  reg [31:0] rom_addr;
  parameter ROM_MAX = 12;
  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      rom_addr = 32'b0;
    end else begin
      if (rom_addr == ROM_MAX) begin
        rom_addr = 32'b0;
      end else begin
        if (sw_i[1] == 1'b0) begin
          rom_addr = rom_addr + 1'b1;
        end
      end
    end
  end

  dist_mem_gen_0 u_IM (
      .a  (rom_addr),
      .spo(ac_instr)
  );

  //RF data display
  reg [4:0] reg_addr;
  parameter RFMAX = 32;
  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      reg_addr = 0;
    end else begin
      if (reg_addr == RFMAX) begin
        reg_addr = 0;
      end else if (sw_i[13] == 1'b1) begin
        reg_addr = reg_addr + 1'b1;
        reg_data = u_rf.rf[reg_addr];
      end
    end
  end

  reg [2:0] alu_addr;
  //ALU content display
  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      alu_addr = 3'b000;
    end else begin
      alu_addr = alu_addr + 1'b1;
      case (alu_addr)
        3'b001:  alu_disp_data = u_alu.A;
        3'b010:  alu_disp_data = u_alu.B;
        3'b011:  alu_disp_data = u_alu.ALUout;
        3'b100:  alu_disp_data = u_alu.Zero;
        default: alu_disp_data = 32'hFFFFFFFF;
      endcase
    end
  end

  reg [5:0] dm_addr;
  //DM content display
  parameter DM_MAX = 16;
  always @(posedge clk_cpu or negedge rstn) begin
    if (!rstn) begin
      dm_addr = 6'b0;
    end else begin
      if (dm_addr == DM_MAX) begin
        dm_addr = 6'b0;
      end else begin
        dm_addr   = dm_addr + 1'b1;
        dmem_data = u_dm.dmem[dm_addr][7:0];
      end
    end
  end

  seg7x16 u_seg7x16 (
      .clk(clk),
      .rstn(rstn),
      .i_data(display_data),
      .disp_mode(sw_i[0]),
      .o_seg(disp_seg_o),
      .o_sel(disp_an_o)
  );

  /////////////////////////////////////////////////////////////////////////////

  //THE TRUE CPU HERE

  //PC update
  reg  [31:0] PC;
  wire [31:0] instr;
  wire [ 1:0] PCSel;
  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      PC = 32'b0;
    end else begin
      if (sw_i[1] == 1'b0) begin
        if (PCSel == 2'b00) begin
          PC = PC + 4;
        end else if (PCSel == 2'b01) begin
          PC = PC + immout;
        end else if (PCSel == 2'b10) begin
          PC = ALUout;
        end else begin
          PC = PC + 4;
        end
      end
    end
  end

  dist_mem_gen_0 u_im (
      .a  (PC / 4),
      .spo(instr)
  );


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
      `WDSel_FromMEM: WD = dout;
      `WDSel_FromPC:  WD = PC + 4;
      `WDSel_FromImm: WD = immout;
    endcase
  end

  RF u_rf (
      .clk (clk),
      .rst (rstn),
      .RFWr(RegWrite),
      .sw_i(sw_i),
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
  wire [5:0] addr;
  wire [31:0] din;
  wire [2:0] DMType;
  wire [31:0] dout;
  // always @(posedge clk) begin
  //   if (sw_i[11] == 1'b1) begin
  //     //DMWr   = 0;
  //     //DMType = sw_i[10:8];
  //   end
  // end

  assign addr = ALUout;
  assign din  = RD2;

  DM u_dm (
      .clk(clk),
      .DMWr(DMWr),
      .addr(addr),
      .din(din),
      .DMType(DMType),
      .sw_i(sw_i),
      .dout(dout)
  );

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

endmodule
