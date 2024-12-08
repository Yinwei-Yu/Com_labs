`timescale 1ns / 1ps

module tb_lab3;

  // Inputs
  reg clk;
  reg rstn;
  reg [15:0] sw_i;
  reg [5:0] counter;
  // Outputs
  wire [7:0] disp_seg_o;
  wire [7:0] disp_an_o;

  // Instantiate the DUT (Device Under Test)
  lab3 uut (
      .clk(clk),
      .rstn(rstn),
      .sw_i(sw_i),
      .disp_seg_o(disp_seg_o),
      .disp_an_o(disp_an_o)
  );

  RF u_rf (
      .clk (clk),
      .rst (rstn),
      .RFWr(uut.RegWrite),
      .sw_i(uut.sw_i),
      .A1  (uut.rs1),
      .A2  (uut.rs2),
      .A3  (uut.rd),
      .WD  (uut.WD),
      .RD1 (uut.RD1),
      .RD2 (uut.RD2)
  );

  DM u_dm (
      .clk(clk),
      .DMWr(uut.DMWr),
      .addr(uut.addr),
      .din(uut.din),
      .DMType(uut.DMType),
      .sw_i(uut.sw_i),
      .dout(uut.dout)
  );

  // Clock generation (10ns period, 50MHz)
  always begin
    clk = 1'b0;
    #5 clk = 1'b1;
    counter = counter + 1;
    #5;
  end

  // Initial block to apply reset and stimulus
  initial begin
    // Initialize inputs
    counter = 6'b0;
    rstn = 1'b0;  // Apply reset
    sw_i = 16'b0;  // Initialize switch input to 0
    #5 rstn = 1'b1;  // Deassert reset
    // Finish simulation after some time
    #150;
    $finish;
  end

  initial begin
    // 
    $monitor(
        "Time: %0t | clk: %b| PC/4: %h | instr: %h | Op:%h | rs1:%h | rs2:%h | rd:%h | Funct3:%b | Funct7:%b |A:%h | B:%h | ALUout:%h | addr:%h | din:%h | dout:%h |",
        $time, clk, uut.PC / 4, uut.instr, uut.Op, uut.rs1, uut.rs2, uut.rd, uut.Funct3,
        uut.Funct7, uut.A, uut.B, uut.ALUout, uut.addr, uut.din, uut.dout);
    $monitor(
        "Time:%0t | clk:%b | Control | RegWrite:%b | ALUop:%b | ALUsrc:%b | DMType:%b | MemWrite:%b | WDSel:%b | DM1:%h | DM[addr]:%h | DM[addr+1]:%h | DM[addr+2]:%h | DM[addr+3]:%h |",
        $time, clk, uut.RegWrite, uut.ALUop, uut.ALUSrc, uut.DMType, uut.DMWr, uut.WDSel,
        u_dm.dmem[1], u_dm.dmem[uut.addr], u_dm.dmem[uut.addr+1], u_dm.dmem[uut.addr+2],
        u_dm.dmem[uut.addr+3]);
    $monitor(
        "Time:%0t | clk:%b | Register| x0:%h | x1:%h | x2:%h | x3:%h | x4:%h | x5:%h | x6:%h | x7:%h | x8:%h | x9:%h | x10:%h |",
        $time, clk, u_rf.rf[0], u_rf.rf[1], u_rf.rf[2], u_rf.rf[3], u_rf.rf[4], u_rf.rf[5],
        u_rf.rf[6], u_rf.rf[7], u_rf.rf[8], u_rf.rf[9], u_rf.rf[10]);
  end

endmodule
