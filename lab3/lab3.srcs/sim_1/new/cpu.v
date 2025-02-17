`timescale 1ns / 1ps

module tb_lab3;

  // Inputs
  reg clk;
  reg rstn;
  reg [15:0] sw_i;
  //reg [5:0] counter;
  //reg [31:0] x10;
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

  seg7x16 u_seg7x16 (
      .clk(clk),
      .rstn(rstn),
      .i_data(uut.display_data),
      .disp_mode(uut.sw_i[0]),
      .o_seg(uut.disp_seg_o),
      .o_sel(uut.disp_an_o)
  );

  // Clock generation (10ns period, 50MHz)
  always begin
    clk = 1'b0;
    #5 clk = 1'b1;
    //counter = counter + 1;
    #5;
  end

  // Initial block to apply reset and stimulus
  initial begin
    // Initialize inputs
    //counter = 6'b0;
    rstn = 1'b0;  // Apply reset
    sw_i = 16'b0000_0000_00_0000_00;  // Initialize switch input to 0
    #5 rstn = 1'b1;  // Deassert reset
    // Finish simulation after some time
    #3000;
    $finish;
  end

  initial begin
    // 
    $monitor(
        "Time: %0t | clk: %b| PC: %h | instr: %h | Op:%h | rs1:%h | rs2:%h | rd:%h | immout:%h | A:%h | B:%h | ALUout:%h | addr:%h | din:%h | dout:%h |",
        $time, clk, uut.PC, uut.instr, uut.Op, uut.rs1, uut.rs2, uut.rd, uut.immout, uut.A, uut.B,
        uut.ALUout, uut.addr, uut.din, uut.dout);
    $monitor(
        "Time:%0t | clk:%b | Control | PCSel:%b | RegWrite:%b | WDSel:%b | ALUop:%b | ASel:%b | BSel:%b | Zero:%b | DMType:%b | MemWrite:%b | WDSel:%b |",
        $time, clk, uut.PCSel, uut.RegWrite, uut.WDSel, uut.ALUop, uut.ASel, uut.BSel, uut.Zero,
        uut.DMType, uut.DMWr, uut.WDSel);
    $monitor(
        "Time:%0t | clk:%b | DMem | DM[0]:%h | DM[1]:%h | DM[2]:%h | DM[3]:%h | DM[4]:%h | DM[5]:%h | DM[6]:%h | DM[7]:%h | DM[8]:%h | DM[9]:%h | DM[10]:%h | DM[11]:%h | DM[12]:%h | DM[13]:%h | DM[14]:%h | DM[15]:%h |",
        $time, clk, u_dm.dmem[0], u_dm.dmem[1], u_dm.dmem[2], u_dm.dmem[3], u_dm.dmem[4],
        u_dm.dmem[5], u_dm.dmem[6], u_dm.dmem[7], u_dm.dmem[8], u_dm.dmem[9], u_dm.dmem[10],
        u_dm.dmem[11], u_dm.dmem[12], u_dm.dmem[13], u_dm.dmem[14], u_dm.dmem[15]);
    $monitor(
        "Time:%0t | clk:%b | DMem | DM[16]:%h | DM[17]:%h | DM[18]:%h | DM[19]:%h | DM[20]:%h | DM[21]:%h | DM[22]:%h | DM[23]:%h | DM[24]:%h | DM[25]:%h | DM[26]:%h | DM[27]:%h | DM[28]:%h | DM[29]:%h | DM[30]:%h | DM[31]:%h |",
        $time, clk, u_dm.dmem[16], u_dm.dmem[17], u_dm.dmem[18], u_dm.dmem[19], u_dm.dmem[20],
        u_dm.dmem[21], u_dm.dmem[22], u_dm.dmem[23], u_dm.dmem[24], u_dm.dmem[25], u_dm.dmem[26],
        u_dm.dmem[27], u_dm.dmem[28], u_dm.dmem[29], u_dm.dmem[30], u_dm.dmem[31]);
    $monitor(
        "Time:%0t | clk:%b | Register | x0:%h | x1:%h | x2:%h | x3:%h | x4:%h | x5:%h | x6:%h | x7:%h | x8:%h | x9:%h | x10:%h | x11:%h | x12:%h | x13:%h | x14:%h | x15:%h |",
        $time, clk, u_rf.rf[0], u_rf.rf[1], u_rf.rf[2], u_rf.rf[3], u_rf.rf[4], u_rf.rf[5],
        u_rf.rf[6], u_rf.rf[7], u_rf.rf[8], u_rf.rf[9], u_rf.rf[10], u_rf.rf[11], u_rf.rf[12],
        u_rf.rf[13], u_rf.rf[14], u_rf.rf[15]);
    $monitor(
        "Time:%0t | clk:%b | Register | x16:%h | x17:%h | x18:%h | x19:%h | x20:%h | x21:%h | x22:%h | x23:%h | x24:%h | x25:%h | x26:%h | x27:%h | x28:%h | x29:%h | x30:%h | x31:%h |",
        $time, clk, u_rf.rf[16], u_rf.rf[17], u_rf.rf[18], u_rf.rf[19], u_rf.rf[20], u_rf.rf[21],
        u_rf.rf[22], u_rf.rf[23], u_rf.rf[24], u_rf.rf[25], u_rf.rf[26], u_rf.rf[27], u_rf.rf[28],
        u_rf.rf[29], u_rf.rf[30], u_rf.rf[31]);
  end

endmodule
