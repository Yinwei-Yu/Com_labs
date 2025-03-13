module EXT (
    input [4:0] iimm_shamt,
    input [11:0] iimm,
    input [11:0] simm,
    input [11:0] bimm,
    input [19:0] uimm,
    input [19:0] jimm,
    input [5:0] EXTOp,
    output reg [31:0] immout
);

  //EXT CTRL itype, stype, btype, utype, jtype
  `define EXT_CTRL_ITYPE_SHAMT 6'b100000
  `define EXT_CTRL_ITYPE 6'b010000
  `define EXT_CTRL_STYPE 6'b001000
  `define EXT_CTRL_BTYPE 6'b000100
  `define EXT_CTRL_UTYPE 6'b000010
  `define EXT_CTRL_JTYPE 6'b000001

  always @(*) begin
    case (EXTOp)
      `EXT_CTRL_ITYPE_SHAMT: immout <= {27'b0, iimm_shamt[4:0]};
      `EXT_CTRL_ITYPE: immout <= {{20{iimm[11]}}, iimm[11:0]};
      `EXT_CTRL_STYPE: immout <= {{20{simm[11]}}, simm[11:0]};
      `EXT_CTRL_BTYPE: immout <= {{19{bimm[11]}}, bimm[11:0], 1'b0};
      `EXT_CTRL_UTYPE: immout <= {uimm[19:0], 12'b0};
      `EXT_CTRL_JTYPE: immout <= {{11{jimm[19]}}, jimm[19:0], 1'b0};
      default: immout <= 32'b0;
    endcase
  end

endmodule
