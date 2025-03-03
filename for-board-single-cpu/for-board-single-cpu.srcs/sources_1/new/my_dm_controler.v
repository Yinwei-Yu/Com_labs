module my_dm_controller (
    input             mem_w,
    input      [31:0] Addr_in,
    input      [31:0] Data_write,
    input      [ 2:0] dm_ctrl,
    input      [31:0] Data_read_from_dm,
    output reg [31:0] Data_read,
    output reg [31:0] Data_write_to_dm,
    output reg [ 3:0] wea_mem
);

  `define dm_word 3'b000
  `define dm_halfword 3'b001
  `define dm_halfword_unsigned 3'b010
  `define dm_byte 3'b011
  `define dm_byte_unsigned 3'b100

  //写使能
  always @(*) begin
    if (mem_w) begin
      case (dm_ctrl)
        `dm_word:     wea_mem = 4'b1111;  // 字操作：全部4字节使能
        `dm_halfword: wea_mem = (Addr_in[1]) ? 4'b1100 : 4'b0011;  // 半字对齐
        `dm_byte:     wea_mem = 4'b0001 << Addr_in[1:0];  // 字节对齐
        default:      wea_mem = 4'b0000;  // 其他类型或无操作
      endcase
    end else begin
      wea_mem = 4'b0000;  // 非写操作时关闭使能
    end
  end

  //写入内存的数据sw
  always @(*) begin
    if (mem_w) begin
      case (dm_ctrl)
        `dm_byte, `dm_byte_unsigned: begin
          case (Addr_in[1:0])
            2'b00: Data_write_to_dm = {24'b0, Data_write[7:0]};
            2'b01: Data_write_to_dm = {16'b0, Data_write[7:0], 8'b0};
            2'b10: Data_write_to_dm = {8'b0, Data_write[7:0], 16'b0};
            2'b11: Data_write_to_dm = {Data_write[7:0], 24'b0};
          endcase
        end
        `dm_halfword, `dm_halfword_unsigned: begin
          case (Addr_in[1])
            1'b0: Data_write_to_dm = {16'b0, Data_write[15:0]};
            1'b1: Data_write_to_dm = {Data_write[15:0], 16'b0};
          endcase
        end
        `dm_word: Data_write_to_dm = Data_write;
        default:  Data_write_to_dm = 32'b0;
      endcase
    end else begin
      Data_write_to_dm = 32'b0;  // 非写操作时输出0
    end
  end

  //读取数据lw
  always @(*) begin
    case (dm_ctrl)
      // 字节读取（有符号扩展）
      `dm_byte: begin
        case (Addr_in[1:0])
          2'b00: Data_read = {{24{Data_read_from_dm[7]}}, Data_read_from_dm[7:0]};
          2'b01: Data_read = {{24{Data_read_from_dm[15]}}, Data_read_from_dm[15:8]};
          2'b10: Data_read = {{24{Data_read_from_dm[23]}}, Data_read_from_dm[23:16]};
          2'b11: Data_read = {{24{Data_read_from_dm[31]}}, Data_read_from_dm[31:24]};
        endcase
      end
      // 字节读取（无符号扩展）
      `dm_byte_unsigned: begin
        case (Addr_in[1:0])
          2'b00: Data_read = {24'b0, Data_read_from_dm[7:0]};
          2'b01: Data_read = {24'b0, Data_read_from_dm[15:8]};
          2'b10: Data_read = {24'b0, Data_read_from_dm[23:16]};
          2'b11: Data_read = {24'b0, Data_read_from_dm[31:24]};
        endcase
      end
      // 半字读取（有符号扩展）
      `dm_halfword: begin
        case (Addr_in[1:0])
          2'b00: Data_read = {{16{Data_read_from_dm[15]}}, Data_read_from_dm[15:0]};
          2'b01: Data_read = {{16{Data_read_from_dm[23]}}, Data_read_from_dm[23:8]};
          2'b10: Data_read = {{16{Data_read_from_dm[31]}}, Data_read_from_dm[31:16]};
          2'b11: Data_read = {{24{Data_read_from_dm[31]}}, Data_read_from_dm[31:24]};
        endcase
      end
      // 半字读取（无符号扩展）
      `dm_halfword_unsigned: begin
        case (Addr_in[1:0])
          2'b00: Data_read = {16'b0, Data_read_from_dm[15:0]};
          2'b01: Data_read = {16'b0, Data_read_from_dm[23:8]};
          2'b10: Data_read = {16'b0, Data_read_from_dm[31:16]};
          2'b11: Data_read = {24'b0, Data_read_from_dm[31:24]};
        endcase
      end
      // 字读取
      `dm_word: Data_read = Data_read_from_dm;
      // 默认值
      default:  Data_read = 32'hFFFFFFFF;
    endcase
  end

endmodule
