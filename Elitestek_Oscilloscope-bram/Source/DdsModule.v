// Generator : SpinalHDL v1.9.3    git head : 029104c77a54c53f1edda327a3bea333f7d65fd9
// Component : DdsModule
// Git hash  : 9db8a52bfc668fe3a2234c919a6525e06b49c734

`timescale 1ns/1ps

module DdsModule (
  output reg [7:0]    io_signalOut,
  input               clk,
  input               reset
);

  wire       [1:0]    _zz_noise1_valueNext;
  wire       [0:0]    _zz_noise1_valueNext_1;
  wire       [1:0]    _zz_noise3_valueNext;
  wire       [0:0]    _zz_noise3_valueNext_1;
  wire       [6:0]    _zz_inc_valueNext;
  wire       [0:0]    _zz_inc_valueNext_1;
  wire       [7:0]    _zz_io_signalOut;
  reg        [7:0]    _zz_io_signalOut_1;
  wire       [7:0]    _zz_io_signalOut_2;
  wire       [1:0]    _zz_io_signalOut_3;
  wire       [7:0]    _zz_io_signalOut_4;
  wire       [1:0]    _zz_io_signalOut_5;
  wire                noise1_willIncrement;
  wire                noise1_willClear;
  reg        [1:0]    noise1_valueNext;
  reg        [1:0]    noise1_value;
  wire                noise1_willOverflowIfInc;
  wire                noise1_willOverflow;
  wire                noise3_willIncrement;
  wire                noise3_willClear;
  reg        [1:0]    noise3_valueNext;
  reg        [1:0]    noise3_value;
  wire                noise3_willOverflowIfInc;
  wire                noise3_willOverflow;
  wire                inc_willIncrement;
  wire                inc_willClear;
  reg        [6:0]    inc_valueNext;
  reg        [6:0]    inc_value;
  wire                inc_willOverflowIfInc;
  wire                inc_willOverflow;
  wire       [7:0]    sinFunc_0;
  wire       [7:0]    sinFunc_1;
  wire       [7:0]    sinFunc_2;
  wire       [7:0]    sinFunc_3;
  wire       [7:0]    sinFunc_4;
  wire       [7:0]    sinFunc_5;
  wire       [7:0]    sinFunc_6;
  wire       [7:0]    sinFunc_7;
  wire       [7:0]    sinFunc_8;
  wire       [7:0]    sinFunc_9;
  wire       [7:0]    sinFunc_10;
  wire       [7:0]    sinFunc_11;
  wire       [7:0]    sinFunc_12;
  wire       [7:0]    sinFunc_13;
  wire       [7:0]    sinFunc_14;
  wire       [7:0]    sinFunc_15;
  wire       [7:0]    sinFunc_16;
  wire       [7:0]    sinFunc_17;
  wire       [7:0]    sinFunc_18;
  wire       [7:0]    sinFunc_19;
  wire       [7:0]    sinFunc_20;
  wire       [7:0]    sinFunc_21;
  wire       [7:0]    sinFunc_22;
  wire       [7:0]    sinFunc_23;
  wire       [7:0]    sinFunc_24;
  wire       [7:0]    sinFunc_25;
  wire       [7:0]    sinFunc_26;
  wire       [7:0]    sinFunc_27;
  wire       [7:0]    sinFunc_28;
  wire       [7:0]    sinFunc_29;
  wire       [7:0]    sinFunc_30;
  wire       [7:0]    sinFunc_31;
  wire       [7:0]    sinFunc_32;
  wire       [7:0]    sinFunc_33;
  wire       [7:0]    sinFunc_34;
  wire       [7:0]    sinFunc_35;
  wire       [7:0]    sinFunc_36;
  wire       [7:0]    sinFunc_37;
  wire       [7:0]    sinFunc_38;
  wire       [7:0]    sinFunc_39;
  wire       [7:0]    sinFunc_40;
  wire       [7:0]    sinFunc_41;
  wire       [7:0]    sinFunc_42;
  wire       [7:0]    sinFunc_43;
  wire       [7:0]    sinFunc_44;
  wire       [7:0]    sinFunc_45;
  wire       [7:0]    sinFunc_46;
  wire       [7:0]    sinFunc_47;
  wire       [7:0]    sinFunc_48;
  wire       [7:0]    sinFunc_49;
  wire       [7:0]    sinFunc_50;
  wire       [7:0]    sinFunc_51;
  wire       [7:0]    sinFunc_52;
  wire       [7:0]    sinFunc_53;
  wire       [7:0]    sinFunc_54;
  wire       [7:0]    sinFunc_55;
  wire       [7:0]    sinFunc_56;
  wire       [7:0]    sinFunc_57;
  wire       [7:0]    sinFunc_58;
  wire       [7:0]    sinFunc_59;
  wire       [7:0]    sinFunc_60;
  wire       [7:0]    sinFunc_61;
  wire       [7:0]    sinFunc_62;
  wire       [7:0]    sinFunc_63;
  wire       [7:0]    sinFunc_64;
  wire       [7:0]    sinFunc_65;
  wire       [7:0]    sinFunc_66;
  wire       [7:0]    sinFunc_67;
  wire       [7:0]    sinFunc_68;
  wire       [7:0]    sinFunc_69;
  wire       [7:0]    sinFunc_70;
  wire       [7:0]    sinFunc_71;
  wire       [7:0]    sinFunc_72;
  wire       [7:0]    sinFunc_73;
  wire       [7:0]    sinFunc_74;
  wire       [7:0]    sinFunc_75;
  wire       [7:0]    sinFunc_76;
  wire       [7:0]    sinFunc_77;
  wire       [7:0]    sinFunc_78;
  wire       [7:0]    sinFunc_79;
  wire       [7:0]    sinFunc_80;
  wire       [7:0]    sinFunc_81;
  wire       [7:0]    sinFunc_82;
  wire       [7:0]    sinFunc_83;
  wire       [7:0]    sinFunc_84;
  wire       [7:0]    sinFunc_85;
  wire       [7:0]    sinFunc_86;
  wire       [7:0]    sinFunc_87;
  wire       [7:0]    sinFunc_88;
  wire       [7:0]    sinFunc_89;
  wire       [7:0]    sinFunc_90;
  wire       [7:0]    sinFunc_91;
  wire       [7:0]    sinFunc_92;

  assign _zz_noise1_valueNext_1 = noise1_willIncrement;
  assign _zz_noise1_valueNext = {1'd0, _zz_noise1_valueNext_1};
  assign _zz_noise3_valueNext_1 = noise3_willIncrement;
  assign _zz_noise3_valueNext = {1'd0, _zz_noise3_valueNext_1};
  assign _zz_inc_valueNext_1 = inc_willIncrement;
  assign _zz_inc_valueNext = {6'd0, _zz_inc_valueNext_1};
  assign _zz_io_signalOut = ($signed(_zz_io_signalOut_1) + $signed(_zz_io_signalOut_2));
  assign _zz_io_signalOut_3 = noise1_value;
  assign _zz_io_signalOut_2 = {{6{_zz_io_signalOut_3[1]}}, _zz_io_signalOut_3};
  assign _zz_io_signalOut_5 = noise3_value;
  assign _zz_io_signalOut_4 = {{6{_zz_io_signalOut_5[1]}}, _zz_io_signalOut_5};
  always @(*) begin
    case(inc_value)
      7'b0000000 : _zz_io_signalOut_1 = sinFunc_0;
      7'b0000001 : _zz_io_signalOut_1 = sinFunc_1;
      7'b0000010 : _zz_io_signalOut_1 = sinFunc_2;
      7'b0000011 : _zz_io_signalOut_1 = sinFunc_3;
      7'b0000100 : _zz_io_signalOut_1 = sinFunc_4;
      7'b0000101 : _zz_io_signalOut_1 = sinFunc_5;
      7'b0000110 : _zz_io_signalOut_1 = sinFunc_6;
      7'b0000111 : _zz_io_signalOut_1 = sinFunc_7;
      7'b0001000 : _zz_io_signalOut_1 = sinFunc_8;
      7'b0001001 : _zz_io_signalOut_1 = sinFunc_9;
      7'b0001010 : _zz_io_signalOut_1 = sinFunc_10;
      7'b0001011 : _zz_io_signalOut_1 = sinFunc_11;
      7'b0001100 : _zz_io_signalOut_1 = sinFunc_12;
      7'b0001101 : _zz_io_signalOut_1 = sinFunc_13;
      7'b0001110 : _zz_io_signalOut_1 = sinFunc_14;
      7'b0001111 : _zz_io_signalOut_1 = sinFunc_15;
      7'b0010000 : _zz_io_signalOut_1 = sinFunc_16;
      7'b0010001 : _zz_io_signalOut_1 = sinFunc_17;
      7'b0010010 : _zz_io_signalOut_1 = sinFunc_18;
      7'b0010011 : _zz_io_signalOut_1 = sinFunc_19;
      7'b0010100 : _zz_io_signalOut_1 = sinFunc_20;
      7'b0010101 : _zz_io_signalOut_1 = sinFunc_21;
      7'b0010110 : _zz_io_signalOut_1 = sinFunc_22;
      7'b0010111 : _zz_io_signalOut_1 = sinFunc_23;
      7'b0011000 : _zz_io_signalOut_1 = sinFunc_24;
      7'b0011001 : _zz_io_signalOut_1 = sinFunc_25;
      7'b0011010 : _zz_io_signalOut_1 = sinFunc_26;
      7'b0011011 : _zz_io_signalOut_1 = sinFunc_27;
      7'b0011100 : _zz_io_signalOut_1 = sinFunc_28;
      7'b0011101 : _zz_io_signalOut_1 = sinFunc_29;
      7'b0011110 : _zz_io_signalOut_1 = sinFunc_30;
      7'b0011111 : _zz_io_signalOut_1 = sinFunc_31;
      7'b0100000 : _zz_io_signalOut_1 = sinFunc_32;
      7'b0100001 : _zz_io_signalOut_1 = sinFunc_33;
      7'b0100010 : _zz_io_signalOut_1 = sinFunc_34;
      7'b0100011 : _zz_io_signalOut_1 = sinFunc_35;
      7'b0100100 : _zz_io_signalOut_1 = sinFunc_36;
      7'b0100101 : _zz_io_signalOut_1 = sinFunc_37;
      7'b0100110 : _zz_io_signalOut_1 = sinFunc_38;
      7'b0100111 : _zz_io_signalOut_1 = sinFunc_39;
      7'b0101000 : _zz_io_signalOut_1 = sinFunc_40;
      7'b0101001 : _zz_io_signalOut_1 = sinFunc_41;
      7'b0101010 : _zz_io_signalOut_1 = sinFunc_42;
      7'b0101011 : _zz_io_signalOut_1 = sinFunc_43;
      7'b0101100 : _zz_io_signalOut_1 = sinFunc_44;
      7'b0101101 : _zz_io_signalOut_1 = sinFunc_45;
      7'b0101110 : _zz_io_signalOut_1 = sinFunc_46;
      7'b0101111 : _zz_io_signalOut_1 = sinFunc_47;
      7'b0110000 : _zz_io_signalOut_1 = sinFunc_48;
      7'b0110001 : _zz_io_signalOut_1 = sinFunc_49;
      7'b0110010 : _zz_io_signalOut_1 = sinFunc_50;
      7'b0110011 : _zz_io_signalOut_1 = sinFunc_51;
      7'b0110100 : _zz_io_signalOut_1 = sinFunc_52;
      7'b0110101 : _zz_io_signalOut_1 = sinFunc_53;
      7'b0110110 : _zz_io_signalOut_1 = sinFunc_54;
      7'b0110111 : _zz_io_signalOut_1 = sinFunc_55;
      7'b0111000 : _zz_io_signalOut_1 = sinFunc_56;
      7'b0111001 : _zz_io_signalOut_1 = sinFunc_57;
      7'b0111010 : _zz_io_signalOut_1 = sinFunc_58;
      7'b0111011 : _zz_io_signalOut_1 = sinFunc_59;
      7'b0111100 : _zz_io_signalOut_1 = sinFunc_60;
      7'b0111101 : _zz_io_signalOut_1 = sinFunc_61;
      7'b0111110 : _zz_io_signalOut_1 = sinFunc_62;
      7'b0111111 : _zz_io_signalOut_1 = sinFunc_63;
      7'b1000000 : _zz_io_signalOut_1 = sinFunc_64;
      7'b1000001 : _zz_io_signalOut_1 = sinFunc_65;
      7'b1000010 : _zz_io_signalOut_1 = sinFunc_66;
      7'b1000011 : _zz_io_signalOut_1 = sinFunc_67;
      7'b1000100 : _zz_io_signalOut_1 = sinFunc_68;
      7'b1000101 : _zz_io_signalOut_1 = sinFunc_69;
      7'b1000110 : _zz_io_signalOut_1 = sinFunc_70;
      7'b1000111 : _zz_io_signalOut_1 = sinFunc_71;
      7'b1001000 : _zz_io_signalOut_1 = sinFunc_72;
      7'b1001001 : _zz_io_signalOut_1 = sinFunc_73;
      7'b1001010 : _zz_io_signalOut_1 = sinFunc_74;
      7'b1001011 : _zz_io_signalOut_1 = sinFunc_75;
      7'b1001100 : _zz_io_signalOut_1 = sinFunc_76;
      7'b1001101 : _zz_io_signalOut_1 = sinFunc_77;
      7'b1001110 : _zz_io_signalOut_1 = sinFunc_78;
      7'b1001111 : _zz_io_signalOut_1 = sinFunc_79;
      7'b1010000 : _zz_io_signalOut_1 = sinFunc_80;
      7'b1010001 : _zz_io_signalOut_1 = sinFunc_81;
      7'b1010010 : _zz_io_signalOut_1 = sinFunc_82;
      7'b1010011 : _zz_io_signalOut_1 = sinFunc_83;
      7'b1010100 : _zz_io_signalOut_1 = sinFunc_84;
      7'b1010101 : _zz_io_signalOut_1 = sinFunc_85;
      7'b1010110 : _zz_io_signalOut_1 = sinFunc_86;
      7'b1010111 : _zz_io_signalOut_1 = sinFunc_87;
      7'b1011000 : _zz_io_signalOut_1 = sinFunc_88;
      7'b1011001 : _zz_io_signalOut_1 = sinFunc_89;
      7'b1011010 : _zz_io_signalOut_1 = sinFunc_90;
      7'b1011011 : _zz_io_signalOut_1 = sinFunc_91;
      default : _zz_io_signalOut_1 = sinFunc_92;
    endcase
  end

  assign noise1_willClear = 1'b0;
  assign noise1_willOverflowIfInc = (noise1_value == 2'b10);
  assign noise1_willOverflow = (noise1_willOverflowIfInc && noise1_willIncrement);
  always @(*) begin
    if(noise1_willOverflow) begin
      noise1_valueNext = 2'b00;
    end else begin
      noise1_valueNext = (noise1_value + _zz_noise1_valueNext);
    end
    if(noise1_willClear) begin
      noise1_valueNext = 2'b00;
    end
  end

  assign noise1_willIncrement = 1'b1;
  assign noise3_willClear = 1'b0;
  assign noise3_willOverflowIfInc = (noise3_value == 2'b11);
  assign noise3_willOverflow = (noise3_willOverflowIfInc && noise3_willIncrement);
  always @(*) begin
    noise3_valueNext = (noise3_value + _zz_noise3_valueNext);
    if(noise3_willClear) begin
      noise3_valueNext = 2'b00;
    end
  end

  assign noise3_willIncrement = 1'b1;
  assign inc_willClear = 1'b0;
  assign inc_willOverflowIfInc = (inc_value == 7'h5c);
  assign inc_willOverflow = (inc_willOverflowIfInc && inc_willIncrement);
  always @(*) begin
    if(inc_willOverflow) begin
      inc_valueNext = 7'h00;
    end else begin
      inc_valueNext = (inc_value + _zz_inc_valueNext);
    end
    if(inc_willClear) begin
      inc_valueNext = 7'h00;
    end
  end

  assign inc_willIncrement = 1'b1;
  assign sinFunc_0 = 8'h02;
  assign sinFunc_1 = 8'h04;
  assign sinFunc_2 = 8'h08;
  assign sinFunc_3 = 8'h0e;
  assign sinFunc_4 = 8'h13;
  assign sinFunc_5 = 8'h16;
  assign sinFunc_6 = 8'h1a;
  assign sinFunc_7 = 8'h1e;
  assign sinFunc_8 = 8'h20;
  assign sinFunc_9 = 8'h25;
  assign sinFunc_10 = 8'h28;
  assign sinFunc_11 = 8'h2d;
  assign sinFunc_12 = 8'h2e;
  assign sinFunc_13 = 8'h33;
  assign sinFunc_14 = 8'h33;
  assign sinFunc_15 = 8'h36;
  assign sinFunc_16 = 8'h38;
  assign sinFunc_17 = 8'h3c;
  assign sinFunc_18 = 8'h3c;
  assign sinFunc_19 = 8'h3e;
  assign sinFunc_20 = 8'h40;
  assign sinFunc_21 = 8'h40;
  assign sinFunc_22 = 8'h3f;
  assign sinFunc_23 = 8'h41;
  assign sinFunc_24 = 8'h40;
  assign sinFunc_25 = 8'h40;
  assign sinFunc_26 = 8'h3e;
  assign sinFunc_27 = 8'h3e;
  assign sinFunc_28 = 8'h3e;
  assign sinFunc_29 = 8'h3d;
  assign sinFunc_30 = 8'h39;
  assign sinFunc_31 = 8'h39;
  assign sinFunc_32 = 8'h36;
  assign sinFunc_33 = 8'h34;
  assign sinFunc_34 = 8'h31;
  assign sinFunc_35 = 8'h2e;
  assign sinFunc_36 = 8'h2b;
  assign sinFunc_37 = 8'h26;
  assign sinFunc_38 = 8'h24;
  assign sinFunc_39 = 8'h1f;
  assign sinFunc_40 = 8'h1b;
  assign sinFunc_41 = 8'h17;
  assign sinFunc_42 = 8'h13;
  assign sinFunc_43 = 8'h10;
  assign sinFunc_44 = 8'h0a;
  assign sinFunc_45 = 8'h08;
  assign sinFunc_46 = 8'h02;
  assign sinFunc_47 = 8'hff;
  assign sinFunc_48 = 8'hfa;
  assign sinFunc_49 = 8'hf8;
  assign sinFunc_50 = 8'hf4;
  assign sinFunc_51 = 8'hef;
  assign sinFunc_52 = 8'hea;
  assign sinFunc_53 = 8'he6;
  assign sinFunc_54 = 8'he3;
  assign sinFunc_55 = 8'he0;
  assign sinFunc_56 = 8'hdb;
  assign sinFunc_57 = 8'hd9;
  assign sinFunc_58 = 8'hd5;
  assign sinFunc_59 = 8'hd3;
  assign sinFunc_60 = 8'hcf;
  assign sinFunc_61 = 8'hce;
  assign sinFunc_62 = 8'hc9;
  assign sinFunc_63 = 8'hc8;
  assign sinFunc_64 = 8'hc5;
  assign sinFunc_65 = 8'hc5;
  assign sinFunc_66 = 8'hc4;
  assign sinFunc_67 = 8'hc4;
  assign sinFunc_68 = 8'hc3;
  assign sinFunc_69 = 8'hc2;
  assign sinFunc_70 = 8'hc3;
  assign sinFunc_71 = 8'hc2;
  assign sinFunc_72 = 8'hc3;
  assign sinFunc_73 = 8'hc2;
  assign sinFunc_74 = 8'hc3;
  assign sinFunc_75 = 8'hc5;
  assign sinFunc_76 = 8'hc7;
  assign sinFunc_77 = 8'hc9;
  assign sinFunc_78 = 8'hca;
  assign sinFunc_79 = 8'hce;
  assign sinFunc_80 = 8'hcf;
  assign sinFunc_81 = 8'hd4;
  assign sinFunc_82 = 8'hd6;
  assign sinFunc_83 = 8'hd9;
  assign sinFunc_84 = 8'hdd;
  assign sinFunc_85 = 8'hdf;
  assign sinFunc_86 = 8'he4;
  assign sinFunc_87 = 8'he8;
  assign sinFunc_88 = 8'hed;
  assign sinFunc_89 = 8'hf0;
  assign sinFunc_90 = 8'hf3;
  assign sinFunc_91 = 8'hf7;
  assign sinFunc_92 = 8'hfd;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      noise1_value <= 2'b00;
      noise3_value <= 2'b00;
      io_signalOut <= 8'h00;
      inc_value <= 7'h00;
    end else begin
      noise1_value <= noise1_valueNext;
      noise3_value <= noise3_valueNext;
      inc_value <= inc_valueNext;
      io_signalOut <= ($signed(_zz_io_signalOut) - $signed(_zz_io_signalOut_4));
    end
  end


endmodule
