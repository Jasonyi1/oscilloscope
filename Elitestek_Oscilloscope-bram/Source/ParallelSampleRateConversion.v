// Generator : SpinalHDL v1.7.3    git head : aeaeece704fe43c766e0d36a93f2ecbb8a9f2003
// Component : CoefGen_With_SRC
// Git hash  : 78ad2bf59a856a509257944298657b829d09efd0

`timescale 1ns/1ps

module CoefGen_With_SRC (
  input               io_src_in_valid,
  output              io_src_in_ready,
  input      [7:0]    io_src_in_payload,
  output              io_src_out_valid,
  input               io_src_out_ready,
  output     [7:0]    io_src_out_payload,
  output     [3:0]    io_intRate,
  output     [3:0]    io_decRate,
  input      [1:0]    io_coefSel_i,
  input               io_request,
  input               reset,
  input               clk
);

  wire       [18:0]   coefGen_1_io_coef;
  wire                coefGen_1_io_intRate_valid;
  wire       [3:0]    coefGen_1_io_intRate_payload;
  wire                coefGen_1_io_decRate_valid;
  wire       [3:0]    coefGen_1_io_decRate_payload;
  wire                coefGen_1_io_index_valid;
  wire       [3:0]    coefGen_1_io_index_payload_indexLine;
  wire       [3:0]    coefGen_1_io_index_payload_indexRow;
  wire                src_io_input_ready;
  wire                src_io_output_valid;
  wire       [7:0]    src_io_output_payload;
  wire                src_io_interpolateRate_ready;
  wire                src_io_decimateRate_ready;
  wire       [3:0]    src_io_currInterpolateRate;
  wire       [3:0]    src_io_currDecimateRate;

  CoefGen coefGen_1 (
    .io_coefSel_i               (io_coefSel_i[1:0]                        ), //i
    .io_request                 (io_request                               ), //i
    .io_coef                    (coefGen_1_io_coef[18:0]                  ), //o
    .io_intRate_valid           (coefGen_1_io_intRate_valid               ), //o
    .io_intRate_ready           (src_io_interpolateRate_ready             ), //i
    .io_intRate_payload         (coefGen_1_io_intRate_payload[3:0]        ), //o
    .io_decRate_valid           (coefGen_1_io_decRate_valid               ), //o
    .io_decRate_ready           (src_io_decimateRate_ready                ), //i
    .io_decRate_payload         (coefGen_1_io_decRate_payload[3:0]        ), //o
    .io_index_valid             (coefGen_1_io_index_valid                 ), //o
    .io_index_payload_indexLine (coefGen_1_io_index_payload_indexLine[3:0]), //o
    .io_index_payload_indexRow  (coefGen_1_io_index_payload_indexRow[3:0] ), //o
    .clk                        (clk                                      ), //i
    .reset                      (reset                                    )  //i
  );
  ParallelSampleRateConversion src (
    .io_input_valid                        (io_src_in_valid                          ), //i
    .io_input_ready                        (src_io_input_ready                       ), //o
    .io_input_payload                      (io_src_in_payload[7:0]                   ), //i
    .io_output_valid                       (src_io_output_valid                      ), //o
    .io_output_ready                       (io_src_out_ready                         ), //i
    .io_output_payload                     (src_io_output_payload[7:0]               ), //o
    .io_interpolateRate_valid              (coefGen_1_io_intRate_valid               ), //i
    .io_interpolateRate_ready              (src_io_interpolateRate_ready             ), //o
    .io_interpolateRate_payload            (coefGen_1_io_intRate_payload[3:0]        ), //i
    .io_decimateRate_valid                 (coefGen_1_io_decRate_valid               ), //i
    .io_decimateRate_ready                 (src_io_decimateRate_ready                ), //o
    .io_decimateRate_payload               (coefGen_1_io_decRate_payload[3:0]        ), //i
    .io_currInterpolateRate                (src_io_currInterpolateRate[3:0]          ), //o
    .io_currDecimateRate                   (src_io_currDecimateRate[3:0]             ), //o
    .io_coefficient                        (coefGen_1_io_coef[18:0]                  ), //i
    .io_coefficientIndex_valid             (coefGen_1_io_index_valid                 ), //i
    .io_coefficientIndex_payload_indexLine (coefGen_1_io_index_payload_indexLine[3:0]), //i
    .io_coefficientIndex_payload_indexRow  (coefGen_1_io_index_payload_indexRow[3:0] ), //i
    .reset                                 (reset                                    ), //i
    .clk                                   (clk                                      )  //i
  );
  assign io_intRate = src_io_currInterpolateRate;
  assign io_decRate = src_io_currDecimateRate;
  assign io_src_in_ready = src_io_input_ready;
  assign io_src_out_valid = src_io_output_valid;
  assign io_src_out_payload = src_io_output_payload;

endmodule

module ParallelSampleRateConversion (
  input               io_input_valid /* verilator public */ ,
  output reg          io_input_ready /* verilator public */ ,
  input      [7:0]    io_input_payload /* verilator public */ ,
  output reg          io_output_valid /* verilator public */ ,
  input               io_output_ready /* verilator public */ ,
  output     [7:0]    io_output_payload /* verilator public */ ,
  input               io_interpolateRate_valid /* verilator public */ ,
  output              io_interpolateRate_ready /* verilator public */ ,
  input      [3:0]    io_interpolateRate_payload /* verilator public */ ,
  input               io_decimateRate_valid /* verilator public */ ,
  output              io_decimateRate_ready /* verilator public */ ,
  input      [3:0]    io_decimateRate_payload /* verilator public */ ,
  output     [3:0]    io_currInterpolateRate /* verilator public */ ,
  output     [3:0]    io_currDecimateRate /* verilator public */ ,
  input      [18:0]   io_coefficient /* verilator public */ ,
  input               io_coefficientIndex_valid /* verilator public */ ,
  input      [3:0]    io_coefficientIndex_payload_indexLine /* verilator public */ ,
  input      [3:0]    io_coefficientIndex_payload_indexRow /* verilator public */ ,
  input               reset,
  input               clk
);

  wire       [2:0]    _zz__zz_1;
  wire       [2:0]    _zz__zz_8;
  wire       [4:0]    _zz_div2Domain_dRateDouble;
  wire       [4:0]    _zz_div2Domain_dRateDouble_1;
  wire       [4:0]    _zz_div2Domain_intRateDouble;
  wire       [4:0]    _zz_div2Domain_intRateDouble_1;
  reg        [3:0]    _zz_div2Domain_stateIWire;
  wire       [1:0]    _zz_div2Domain_stateIWire_1;
  reg        [3:0]    _zz_div2Domain_state2IWire;
  wire       [1:0]    _zz_div2Domain_state2IWire_1;
  wire       [4:0]    _zz_div2Domain_stateIOverflow;
  wire       [4:0]    _zz_div2Domain_stateIOverflow_1;
  wire       [4:0]    _zz_div2Domain_stateIOverflow_2;
  wire       [4:0]    _zz_div2Domain_state2IOverflow;
  wire       [4:0]    _zz_div2Domain_state2IOverflow_1;
  wire       [4:0]    _zz_div2Domain_state2IOverflow_2;
  reg        [3:0]    _zz_div2Domain_si_0;
  wire       [1:0]    _zz_div2Domain_si_0_1;
  reg        [3:0]    _zz_div2Domain_si_0_2;
  wire       [1:0]    _zz_div2Domain_si_0_3;
  reg        [3:0]    _zz_div2Domain_si_1;
  wire       [1:0]    _zz_div2Domain_si_1_1;
  reg        [3:0]    _zz_div2Domain_si_1_2;
  wire       [1:0]    _zz_div2Domain_si_1_3;
  wire       [3:0]    _zz_div2Domain_state2I_0;
  wire       [0:0]    _zz_div2Domain_state2I_0_1;
  wire       [4:0]    _zz_when_ParallelSRC_l99;
  wire       [4:0]    _zz_when_ParallelSRC_l99_1;
  wire       [4:0]    _zz_div2Domain_stateI_1;
  wire       [4:0]    _zz_div2Domain_stateI_1_1;
  wire       [4:0]    _zz_div2Domain_stateI_1_2;
  wire       [4:0]    _zz_div2Domain_stateI_1_3;
  wire       [4:0]    _zz_div2Domain_stateI_1_4;
  wire       [4:0]    _zz_div2Domain_stateI_1_5;
  wire       [4:0]    _zz_div2Domain_stateI_1_6;
  wire       [4:0]    _zz_div2Domain_stateI_1_7;
  wire       [4:0]    _zz_div2Domain_stateI_1_8;
  wire       [4:0]    _zz_when_ParallelSRC_l101;
  wire       [4:0]    _zz_when_ParallelSRC_l101_1;
  wire       [4:0]    _zz_when_ParallelSRC_l101_2;
  wire       [4:0]    _zz_when_ParallelSRC_l106;
  wire       [4:0]    _zz_when_ParallelSRC_l106_1;
  wire       [4:0]    _zz_div2Domain_state2I_1;
  wire       [4:0]    _zz_div2Domain_state2I_1_1;
  wire       [4:0]    _zz_div2Domain_state2I_1_2;
  wire       [4:0]    _zz_div2Domain_state2I_1_3;
  wire       [4:0]    _zz_div2Domain_state2I_1_4;
  wire       [4:0]    _zz_div2Domain_state2I_1_5;
  wire       [4:0]    _zz_div2Domain_state2I_1_6;
  wire       [4:0]    _zz_div2Domain_state2I_1_7;
  wire       [4:0]    _zz_div2Domain_state2I_1_8;
  wire       [4:0]    _zz_when_ParallelSRC_l108;
  wire       [4:0]    _zz_when_ParallelSRC_l108_1;
  wire       [4:0]    _zz_when_ParallelSRC_l108_2;
  wire       [4:0]    _zz_when_ParallelSRC_l99_1_1;
  wire       [4:0]    _zz_when_ParallelSRC_l99_1_2;
  wire       [4:0]    _zz_div2Domain_stateI_2;
  wire       [4:0]    _zz_div2Domain_stateI_2_1;
  wire       [4:0]    _zz_div2Domain_stateI_2_2;
  wire       [4:0]    _zz_div2Domain_stateI_2_3;
  wire       [4:0]    _zz_div2Domain_stateI_2_4;
  wire       [4:0]    _zz_div2Domain_stateI_2_5;
  wire       [4:0]    _zz_div2Domain_stateI_2_6;
  wire       [4:0]    _zz_div2Domain_stateI_2_7;
  wire       [4:0]    _zz_div2Domain_stateI_2_8;
  wire       [4:0]    _zz_when_ParallelSRC_l101_1_1;
  wire       [4:0]    _zz_when_ParallelSRC_l101_1_2;
  wire       [4:0]    _zz_when_ParallelSRC_l101_1_3;
  wire       [4:0]    _zz_when_ParallelSRC_l106_1_1;
  wire       [4:0]    _zz_when_ParallelSRC_l106_1_2;
  wire       [4:0]    _zz_div2Domain_state2I_2;
  wire       [4:0]    _zz_div2Domain_state2I_2_1;
  wire       [4:0]    _zz_div2Domain_state2I_2_2;
  wire       [4:0]    _zz_div2Domain_state2I_2_3;
  wire       [4:0]    _zz_div2Domain_state2I_2_4;
  wire       [4:0]    _zz_div2Domain_state2I_2_5;
  wire       [4:0]    _zz_div2Domain_state2I_2_6;
  wire       [4:0]    _zz_div2Domain_state2I_2_7;
  wire       [4:0]    _zz_div2Domain_state2I_2_8;
  wire       [4:0]    _zz_when_ParallelSRC_l108_1_1;
  wire       [4:0]    _zz_when_ParallelSRC_l108_1_2;
  wire       [4:0]    _zz_when_ParallelSRC_l108_1_3;
  wire       [4:0]    _zz_when_ParallelSRC_l126;
  wire       [4:0]    _zz_when_ParallelSRC_l126_1;
  wire       [4:0]    _zz_when_ParallelSRC_l126_2;
  wire       [4:0]    _zz_when_ParallelSRC_l126_1_1;
  wire       [4:0]    _zz_when_ParallelSRC_l126_1_2;
  wire       [4:0]    _zz_when_ParallelSRC_l126_1_3;
  reg        [3:0]    _zz_div2Domain_useSame;
  wire       [1:0]    _zz_div2Domain_useSame_1;
  reg        [3:0]    _zz_div2Domain_useSame_2;
  wire       [1:0]    _zz_div2Domain_useSame_3;
  wire       [4:0]    _zz_div2Domain_shiftTwo;
  reg        [3:0]    _zz_switch_ParallelSRC_l156_1;
  wire       [0:0]    _zz_switch_ParallelSRC_l156_2;
  wire       [19:0]   _zz_multiResult_0_2;
  wire       [19:0]   _zz_multiResult_1_2;
  wire       [19:0]   _zz_multiResult_2_2;
  wire       [19:0]   _zz_multiResult_3_2;
  wire       [19:0]   _zz_multiResult_4_2;
  wire       [19:0]   _zz_multiResult_5_2;
  reg        [3:0]    _zz_switch_ParallelSRC_l156_1_1;
  wire       [0:0]    _zz_10;
  wire       [0:0]    _zz_11;
  wire       [1:0]    _zz_12;
  wire       [19:0]   _zz_multiResult_0_1_1;
  wire       [19:0]   _zz_multiResult_1_1_1;
  wire       [19:0]   _zz_multiResult_2_1_1;
  wire       [19:0]   _zz_multiResult_3_1_1;
  wire       [19:0]   _zz_multiResult_4_1_1;
  wire       [19:0]   _zz_multiResult_5_1_1;
  wire       [4:0]    _zz_io_input_ready;
  wire       [4:0]    _zz_io_input_ready_1;
  wire       [0:0]    _zz_io_input_ready_2;
  wire       [0:0]    _zz_io_input_ready_3;
  wire       [2:0]    _zz_currentState;
  reg        [7:0]    _zz_io_output_payload;
  wire       [0:0]    _zz_io_output_payload_1;
  wire       [3:0]    romLinesUInt;
  wire                outputCount_willIncrement;
  wire                outputCount_willClear;
  reg        [0:0]    outputCount_valueNext;
  reg        [0:0]    outputCount_value;
  wire                outputCount_willOverflowIfInc;
  wire                outputCount_willOverflow;
  reg        [7:0]    inputReg;
  wire                io_input_fire;
  wire                io_input_fire_1;
  wire       [7:0]    serialToParallel_0;
  reg        [7:0]    serialToParallel_1;
  reg        [2:0]    currentState;
  reg        [0:0]    _zz_when_ClockDomain_l369;
  wire                when_ClockDomain_l369;
  reg                 when_ClockDomain_l369_regNext;
  (* MAX_FANOUT = 100 *) wire                clkDiv2;
  reg        [18:0]   div2Domain_coefficientVec_0_0;
  reg        [18:0]   div2Domain_coefficientVec_0_1;
  reg        [18:0]   div2Domain_coefficientVec_0_2;
  reg        [18:0]   div2Domain_coefficientVec_0_3;
  reg        [18:0]   div2Domain_coefficientVec_0_4;
  reg        [18:0]   div2Domain_coefficientVec_0_5;
  reg        [18:0]   div2Domain_coefficientVec_1_0;
  reg        [18:0]   div2Domain_coefficientVec_1_1;
  reg        [18:0]   div2Domain_coefficientVec_1_2;
  reg        [18:0]   div2Domain_coefficientVec_1_3;
  reg        [18:0]   div2Domain_coefficientVec_1_4;
  reg        [18:0]   div2Domain_coefficientVec_1_5;
  reg        [18:0]   div2Domain_coefficientVec_2_0;
  reg        [18:0]   div2Domain_coefficientVec_2_1;
  reg        [18:0]   div2Domain_coefficientVec_2_2;
  reg        [18:0]   div2Domain_coefficientVec_2_3;
  reg        [18:0]   div2Domain_coefficientVec_2_4;
  reg        [18:0]   div2Domain_coefficientVec_2_5;
  reg        [18:0]   div2Domain_coefficientVec_3_0;
  reg        [18:0]   div2Domain_coefficientVec_3_1;
  reg        [18:0]   div2Domain_coefficientVec_3_2;
  reg        [18:0]   div2Domain_coefficientVec_3_3;
  reg        [18:0]   div2Domain_coefficientVec_3_4;
  reg        [18:0]   div2Domain_coefficientVec_3_5;
  reg        [18:0]   div2Domain_coefficientVec_4_0;
  reg        [18:0]   div2Domain_coefficientVec_4_1;
  reg        [18:0]   div2Domain_coefficientVec_4_2;
  reg        [18:0]   div2Domain_coefficientVec_4_3;
  reg        [18:0]   div2Domain_coefficientVec_4_4;
  reg        [18:0]   div2Domain_coefficientVec_4_5;
  reg        [18:0]   div2Domain_coefficientVec_5_0;
  reg        [18:0]   div2Domain_coefficientVec_5_1;
  reg        [18:0]   div2Domain_coefficientVec_5_2;
  reg        [18:0]   div2Domain_coefficientVec_5_3;
  reg        [18:0]   div2Domain_coefficientVec_5_4;
  reg        [18:0]   div2Domain_coefficientVec_5_5;
  wire       [7:0]    _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_7;
  wire       [7:0]    _zz_8;
  wire       [18:0]   _zz_div2Domain_coefficientVec_0_0;
  reg        [3:0]    div2Domain_intRate;
  reg        [3:0]    div2Domain_decRate;
  wire       [3:0]    div2Domain_si_0;
  wire       [3:0]    div2Domain_si_1;
  wire       [4:0]    div2Domain_dRateDouble;
  wire       [4:0]    div2Domain_intRateDouble;
  reg        [3:0]    div2Domain_stateI_0;
  reg        [3:0]    div2Domain_stateI_1;
  reg        [3:0]    div2Domain_stateI_2;
  reg        [3:0]    div2Domain_state2I_0;
  reg        [3:0]    div2Domain_state2I_1;
  reg        [3:0]    div2Domain_state2I_2;
  reg        [3:0]    div2Domain_decStateI_0;
  reg        [3:0]    div2Domain_decStateI_1;
  reg        [3:0]    div2Domain_decStateI_2;
  reg        [3:0]    div2Domain_decState2I_0;
  reg        [3:0]    div2Domain_decState2I_1;
  reg        [3:0]    div2Domain_decState2I_2;
  reg        [4:0]    div2Domain_dRateDoubleTemp;
  reg        [3:0]    div2Domain_dRateTemp;
  reg        [4:0]    div2Domain_iRateDoubleTemp;
  reg        [3:0]    div2Domain_iRateTemp;
  wire       [3:0]    div2Domain_stateIWire;
  wire       [3:0]    div2Domain_state2IWire;
  wire                div2Domain_stateIOverflow;
  wire                div2Domain_state2IOverflow;
  wire                div2Domain_allowToShift;
  wire                when_ParallelSRC_l99;
  wire                when_ParallelSRC_l101;
  wire                when_ParallelSRC_l106;
  wire                when_ParallelSRC_l108;
  wire                when_ParallelSRC_l99_1;
  wire                when_ParallelSRC_l101_1;
  wire                when_ParallelSRC_l106_1;
  wire                when_ParallelSRC_l108_1;
  wire                when_ParallelSRC_l122;
  wire                when_ParallelSRC_l126;
  wire                when_ParallelSRC_l122_1;
  wire                when_ParallelSRC_l126_1;
  wire                io_interpolateRate_fire;
  wire                io_decimateRate_fire;
  wire                div2Domain_useSame;
  wire                div2Domain_shiftTwo;
  wire       [7:0]    div2Domain_delayLineResult_0;
  wire       [7:0]    div2Domain_delayLineResult_1;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_1;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_2;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_3;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_4;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_5;
  (* MAX_FANOUT = 1 *) reg        [7:0]    ShiftRegWithMux_6;
  wire       [7:0]    div2Domain_hist_0_0;
  wire       [7:0]    div2Domain_hist_0_1;
  wire       [7:0]    div2Domain_hist_0_2;
  wire       [7:0]    div2Domain_hist_0_3;
  wire       [7:0]    div2Domain_hist_0_4;
  wire       [7:0]    div2Domain_hist_0_5;
  wire       [7:0]    div2Domain_hist_1_0;
  wire       [7:0]    div2Domain_hist_1_1;
  wire       [7:0]    div2Domain_hist_1_2;
  wire       [7:0]    div2Domain_hist_1_3;
  wire       [7:0]    div2Domain_hist_1_4;
  wire       [7:0]    div2Domain_hist_1_5;
  reg        [15:0]   multiResult_0;
  reg        [15:0]   multiResult_1;
  reg        [15:0]   multiResult_2;
  reg        [15:0]   multiResult_3;
  reg        [15:0]   multiResult_4;
  reg        [15:0]   multiResult_5;
  reg        [18:0]   filterCoefficient_0;
  reg        [18:0]   filterCoefficient_1;
  reg        [18:0]   filterCoefficient_2;
  reg        [18:0]   filterCoefficient_3;
  reg        [18:0]   filterCoefficient_4;
  reg        [18:0]   filterCoefficient_5;
  reg        [7:0]    dataIn_0;
  reg        [7:0]    dataIn_1;
  reg        [7:0]    dataIn_2;
  reg        [7:0]    dataIn_3;
  reg        [7:0]    dataIn_4;
  reg        [7:0]    dataIn_5;
  wire       [3:0]    switch_ParallelSRC_l156;
  wire       [1:0]    _zz_9;
  reg        [26:0]   _zz_multiResult_0;
  reg        [26:0]   _zz_multiResult_1;
  reg        [26:0]   _zz_multiResult_2;
  reg        [26:0]   _zz_multiResult_3;
  reg        [26:0]   _zz_multiResult_4;
  reg        [26:0]   _zz_multiResult_5;
  reg        [15:0]   _zz_summaryResult;
  reg        [15:0]   _zz_summaryResult_1;
  reg        [15:0]   _zz_summaryResult_2;
  reg        [15:0]   _zz_summaryResult_3;
  wire       [15:0]   summaryResult;
  wire       [0:0]    _zz_switch_ParallelSRC_l156;
  reg        [15:0]   multiResult_0_1;
  reg        [15:0]   multiResult_1_1;
  reg        [15:0]   multiResult_2_1;
  reg        [15:0]   multiResult_3_1;
  reg        [15:0]   multiResult_4_1;
  reg        [15:0]   multiResult_5_1;
  reg        [18:0]   filterCoefficient_0_1;
  reg        [18:0]   filterCoefficient_1_1;
  reg        [18:0]   filterCoefficient_2_1;
  reg        [18:0]   filterCoefficient_3_1;
  reg        [18:0]   filterCoefficient_4_1;
  reg        [18:0]   filterCoefficient_5_1;
  reg        [7:0]    dataIn_0_1;
  reg        [7:0]    dataIn_1_1;
  reg        [7:0]    dataIn_2_1;
  reg        [7:0]    dataIn_3_1;
  reg        [7:0]    dataIn_4_1;
  reg        [7:0]    dataIn_5_1;
  wire       [3:0]    switch_ParallelSRC_l156_1;
  wire       [0:0]    switch_ParallelSRC_l163;
  reg        [26:0]   _zz_multiResult_0_1;
  reg        [26:0]   _zz_multiResult_1_1;
  reg        [26:0]   _zz_multiResult_2_1;
  reg        [26:0]   _zz_multiResult_3_1;
  reg        [26:0]   _zz_multiResult_4_1;
  reg        [26:0]   _zz_multiResult_5_1;
  reg        [15:0]   _zz_summaryResult_4;
  reg        [15:0]   _zz_summaryResult_5;
  reg        [15:0]   _zz_summaryResult_6;
  reg        [15:0]   _zz_summaryResult_7;
  wire       [15:0]   summaryResult_1;
  reg        [7:0]    outputDelay;
  wire                when_ParallelSRC_l193;
  wire                when_ParallelSRC_l195;
  wire                when_ParallelSRC_l199;

  assign _zz__zz_1 = io_coefficientIndex_payload_indexLine[2:0];
  assign _zz__zz_8 = io_coefficientIndex_payload_indexRow[2:0];
  assign _zz_div2Domain_dRateDouble = {1'd0, div2Domain_decRate};
  assign _zz_div2Domain_dRateDouble_1 = {1'd0, div2Domain_decRate};
  assign _zz_div2Domain_intRateDouble = {1'd0, div2Domain_intRate};
  assign _zz_div2Domain_intRateDouble_1 = {1'd0, div2Domain_intRate};
  assign _zz_div2Domain_stateIWire_1 = currentState[1:0];
  assign _zz_div2Domain_state2IWire_1 = currentState[1:0];
  assign _zz_div2Domain_stateIOverflow = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_stateIOverflow_1 = (_zz_div2Domain_stateIOverflow_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateIOverflow_2 = {1'd0, div2Domain_stateIWire};
  assign _zz_div2Domain_state2IOverflow = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_state2IOverflow_1 = (_zz_div2Domain_state2IOverflow_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2IOverflow_2 = {1'd0, div2Domain_state2IWire};
  assign _zz_div2Domain_si_0_1 = currentState[1:0];
  assign _zz_div2Domain_si_0_3 = currentState[1:0];
  assign _zz_div2Domain_si_1_1 = currentState[1:0];
  assign _zz_div2Domain_si_1_3 = currentState[1:0];
  assign _zz_div2Domain_state2I_0_1 = 1'b0;
  assign _zz_div2Domain_state2I_0 = {3'd0, _zz_div2Domain_state2I_0_1};
  assign _zz_when_ParallelSRC_l99 = (_zz_when_ParallelSRC_l99_1 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l99_1 = {1'd0, div2Domain_stateI_0};
  assign _zz_div2Domain_stateI_1 = (_zz_div2Domain_stateI_1_1 - div2Domain_iRateDoubleTemp);
  assign _zz_div2Domain_stateI_1_1 = (_zz_div2Domain_stateI_1_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_1_2 = {1'd0, div2Domain_stateI_0};
  assign _zz_div2Domain_stateI_1_3 = (_zz_div2Domain_stateI_1_4 - _zz_div2Domain_stateI_1_6);
  assign _zz_div2Domain_stateI_1_4 = (_zz_div2Domain_stateI_1_5 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_1_5 = {1'd0, div2Domain_stateI_0};
  assign _zz_div2Domain_stateI_1_6 = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_stateI_1_7 = (_zz_div2Domain_stateI_1_8 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_1_8 = {1'd0, div2Domain_stateI_0};
  assign _zz_when_ParallelSRC_l101 = {1'd0, div2Domain_iRateTemp};
  assign _zz_when_ParallelSRC_l101_1 = (_zz_when_ParallelSRC_l101_2 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l101_2 = {1'd0, div2Domain_stateI_0};
  assign _zz_when_ParallelSRC_l106 = (_zz_when_ParallelSRC_l106_1 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l106_1 = {1'd0, div2Domain_state2I_0};
  assign _zz_div2Domain_state2I_1 = (_zz_div2Domain_state2I_1_1 - div2Domain_iRateDoubleTemp);
  assign _zz_div2Domain_state2I_1_1 = (_zz_div2Domain_state2I_1_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_1_2 = {1'd0, div2Domain_state2I_0};
  assign _zz_div2Domain_state2I_1_3 = (_zz_div2Domain_state2I_1_4 - _zz_div2Domain_state2I_1_6);
  assign _zz_div2Domain_state2I_1_4 = (_zz_div2Domain_state2I_1_5 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_1_5 = {1'd0, div2Domain_state2I_0};
  assign _zz_div2Domain_state2I_1_6 = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_state2I_1_7 = (_zz_div2Domain_state2I_1_8 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_1_8 = {1'd0, div2Domain_state2I_0};
  assign _zz_when_ParallelSRC_l108 = {1'd0, div2Domain_iRateTemp};
  assign _zz_when_ParallelSRC_l108_1 = (_zz_when_ParallelSRC_l108_2 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l108_2 = {1'd0, div2Domain_state2I_0};
  assign _zz_when_ParallelSRC_l99_1_1 = (_zz_when_ParallelSRC_l99_1_2 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l99_1_2 = {1'd0, div2Domain_stateI_1};
  assign _zz_div2Domain_stateI_2 = (_zz_div2Domain_stateI_2_1 - div2Domain_iRateDoubleTemp);
  assign _zz_div2Domain_stateI_2_1 = (_zz_div2Domain_stateI_2_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_2_2 = {1'd0, div2Domain_stateI_1};
  assign _zz_div2Domain_stateI_2_3 = (_zz_div2Domain_stateI_2_4 - _zz_div2Domain_stateI_2_6);
  assign _zz_div2Domain_stateI_2_4 = (_zz_div2Domain_stateI_2_5 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_2_5 = {1'd0, div2Domain_stateI_1};
  assign _zz_div2Domain_stateI_2_6 = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_stateI_2_7 = (_zz_div2Domain_stateI_2_8 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_stateI_2_8 = {1'd0, div2Domain_stateI_1};
  assign _zz_when_ParallelSRC_l101_1_1 = {1'd0, div2Domain_iRateTemp};
  assign _zz_when_ParallelSRC_l101_1_2 = (_zz_when_ParallelSRC_l101_1_3 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l101_1_3 = {1'd0, div2Domain_stateI_1};
  assign _zz_when_ParallelSRC_l106_1_1 = (_zz_when_ParallelSRC_l106_1_2 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l106_1_2 = {1'd0, div2Domain_state2I_1};
  assign _zz_div2Domain_state2I_2 = (_zz_div2Domain_state2I_2_1 - div2Domain_iRateDoubleTemp);
  assign _zz_div2Domain_state2I_2_1 = (_zz_div2Domain_state2I_2_2 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_2_2 = {1'd0, div2Domain_state2I_1};
  assign _zz_div2Domain_state2I_2_3 = (_zz_div2Domain_state2I_2_4 - _zz_div2Domain_state2I_2_6);
  assign _zz_div2Domain_state2I_2_4 = (_zz_div2Domain_state2I_2_5 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_2_5 = {1'd0, div2Domain_state2I_1};
  assign _zz_div2Domain_state2I_2_6 = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_state2I_2_7 = (_zz_div2Domain_state2I_2_8 + div2Domain_dRateDoubleTemp);
  assign _zz_div2Domain_state2I_2_8 = {1'd0, div2Domain_state2I_1};
  assign _zz_when_ParallelSRC_l108_1_1 = {1'd0, div2Domain_iRateTemp};
  assign _zz_when_ParallelSRC_l108_1_2 = (_zz_when_ParallelSRC_l108_1_3 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l108_1_3 = {1'd0, div2Domain_state2I_1};
  assign _zz_when_ParallelSRC_l126 = (_zz_when_ParallelSRC_l126_1 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l126_1 = {1'd0, div2Domain_stateI_0};
  assign _zz_when_ParallelSRC_l126_2 = {1'd0, div2Domain_iRateTemp};
  assign _zz_when_ParallelSRC_l126_1_1 = (_zz_when_ParallelSRC_l126_1_2 + div2Domain_dRateDoubleTemp);
  assign _zz_when_ParallelSRC_l126_1_2 = {1'd0, div2Domain_stateI_1};
  assign _zz_when_ParallelSRC_l126_1_3 = {1'd0, div2Domain_iRateTemp};
  assign _zz_div2Domain_useSame_1 = currentState[1:0];
  assign _zz_div2Domain_useSame_3 = currentState[1:0];
  assign _zz_div2Domain_shiftTwo = {1'd0, div2Domain_iRateTemp};
  assign _zz_multiResult_0_2 = (_zz_multiResult_0 >>> 7);
  assign _zz_multiResult_1_2 = (_zz_multiResult_1 >>> 7);
  assign _zz_multiResult_2_2 = (_zz_multiResult_2 >>> 7);
  assign _zz_multiResult_3_2 = (_zz_multiResult_3 >>> 7);
  assign _zz_multiResult_4_2 = (_zz_multiResult_4 >>> 7);
  assign _zz_multiResult_5_2 = (_zz_multiResult_5 >>> 7);
  assign _zz_10 = 1'b0;
  assign _zz_12 = 2'b01;
  assign _zz_11 = _zz_12[0:0];
  assign _zz_multiResult_0_1_1 = (_zz_multiResult_0_1 >>> 7);
  assign _zz_multiResult_1_1_1 = (_zz_multiResult_1_1 >>> 7);
  assign _zz_multiResult_2_1_1 = (_zz_multiResult_2_1 >>> 7);
  assign _zz_multiResult_3_1_1 = (_zz_multiResult_3_1 >>> 7);
  assign _zz_multiResult_4_1_1 = (_zz_multiResult_4_1 >>> 7);
  assign _zz_multiResult_5_1_1 = (_zz_multiResult_5_1 >>> 7);
  assign _zz_io_input_ready = {1'd0, div2Domain_iRateTemp};
  assign _zz_io_input_ready_1 = {1'd0, div2Domain_iRateTemp};
  assign _zz_io_input_ready_2 = (1'b1 - outputCount_value);
  assign _zz_io_input_ready_3 = (1'b1 - outputCount_value);
  assign _zz_currentState = (currentState + 3'b001);
  assign _zz_io_output_payload_1 = (1'b1 - outputCount_value);
  assign _zz_switch_ParallelSRC_l156_2 = 1'b0;
  always @(*) begin
    case(_zz_div2Domain_stateIWire_1)
      2'b00 : _zz_div2Domain_stateIWire = div2Domain_stateI_0;
      2'b01 : _zz_div2Domain_stateIWire = div2Domain_stateI_1;
      default : _zz_div2Domain_stateIWire = div2Domain_stateI_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_state2IWire_1)
      2'b00 : _zz_div2Domain_state2IWire = div2Domain_state2I_0;
      2'b01 : _zz_div2Domain_state2IWire = div2Domain_state2I_1;
      default : _zz_div2Domain_state2IWire = div2Domain_state2I_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_si_0_1)
      2'b00 : _zz_div2Domain_si_0 = div2Domain_stateI_0;
      2'b01 : _zz_div2Domain_si_0 = div2Domain_stateI_1;
      default : _zz_div2Domain_si_0 = div2Domain_stateI_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_si_0_3)
      2'b00 : _zz_div2Domain_si_0_2 = div2Domain_decStateI_0;
      2'b01 : _zz_div2Domain_si_0_2 = div2Domain_decStateI_1;
      default : _zz_div2Domain_si_0_2 = div2Domain_decStateI_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_si_1_1)
      2'b00 : _zz_div2Domain_si_1 = div2Domain_state2I_0;
      2'b01 : _zz_div2Domain_si_1 = div2Domain_state2I_1;
      default : _zz_div2Domain_si_1 = div2Domain_state2I_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_si_1_3)
      2'b00 : _zz_div2Domain_si_1_2 = div2Domain_decState2I_0;
      2'b01 : _zz_div2Domain_si_1_2 = div2Domain_decState2I_1;
      default : _zz_div2Domain_si_1_2 = div2Domain_decState2I_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_useSame_1)
      2'b00 : _zz_div2Domain_useSame = div2Domain_stateI_0;
      2'b01 : _zz_div2Domain_useSame = div2Domain_stateI_1;
      default : _zz_div2Domain_useSame = div2Domain_stateI_2;
    endcase
  end

  always @(*) begin
    case(_zz_div2Domain_useSame_3)
      2'b00 : _zz_div2Domain_useSame_2 = div2Domain_state2I_0;
      2'b01 : _zz_div2Domain_useSame_2 = div2Domain_state2I_1;
      default : _zz_div2Domain_useSame_2 = div2Domain_state2I_2;
    endcase
  end

  always @(*) begin
    case(_zz_switch_ParallelSRC_l156_2)
      1'b0 : _zz_switch_ParallelSRC_l156_1 = div2Domain_si_0;
      default : _zz_switch_ParallelSRC_l156_1 = div2Domain_si_1;
    endcase
  end

  always @(*) begin
    case(_zz_switch_ParallelSRC_l156)
      1'b0 : _zz_switch_ParallelSRC_l156_1_1 = div2Domain_si_0;
      default : _zz_switch_ParallelSRC_l156_1_1 = div2Domain_si_1;
    endcase
  end

  always @(*) begin
    case(_zz_io_output_payload_1)
      1'b0 : _zz_io_output_payload = div2Domain_delayLineResult_0;
      default : _zz_io_output_payload = div2Domain_delayLineResult_1;
    endcase
  end

  assign romLinesUInt = 4'b0110;
  assign outputCount_willClear = 1'b0;
  assign outputCount_willOverflowIfInc = (outputCount_value == 1'b1);
  assign outputCount_willOverflow = (outputCount_willOverflowIfInc && outputCount_willIncrement);
  always @(*) begin
    outputCount_valueNext = (outputCount_value + outputCount_willIncrement);
    if(outputCount_willClear) begin
      outputCount_valueNext = 1'b0;
    end
  end

  assign outputCount_willIncrement = 1'b1;
  always @(*) begin
    io_output_valid = 1'b0;
    if(io_interpolateRate_fire) begin
      io_output_valid = 1'b0;
    end
    if(io_decimateRate_fire) begin
      io_output_valid = 1'b0;
    end
    if(when_ParallelSRC_l199) begin
      io_output_valid = 1'b1;
    end
  end

  assign io_interpolateRate_ready = 1'b1;
  assign io_decimateRate_ready = 1'b1;
  assign io_input_fire = (io_input_valid && io_input_ready);
  assign io_input_fire_1 = (io_input_valid && io_input_ready);
  assign serialToParallel_0 = inputReg;
  assign when_ClockDomain_l369 = (_zz_when_ClockDomain_l369 == 1'b1);
  assign clkDiv2 = (when_ClockDomain_l369_regNext || reset);
  assign _zz_1 = ({7'd0,1'b1} <<< _zz__zz_1);
  assign _zz_2 = _zz_1[0];
  assign _zz_3 = _zz_1[1];
  assign _zz_4 = _zz_1[2];
  assign _zz_5 = _zz_1[3];
  assign _zz_6 = _zz_1[4];
  assign _zz_7 = _zz_1[5];
  assign _zz_8 = ({7'd0,1'b1} <<< _zz__zz_8);
  assign _zz_div2Domain_coefficientVec_0_0 = io_coefficient;
  assign div2Domain_dRateDouble = (_zz_div2Domain_dRateDouble + _zz_div2Domain_dRateDouble_1);
  assign div2Domain_intRateDouble = (_zz_div2Domain_intRateDouble + _zz_div2Domain_intRateDouble_1);
  assign div2Domain_stateIWire = _zz_div2Domain_stateIWire;
  assign div2Domain_state2IWire = _zz_div2Domain_state2IWire;
  assign div2Domain_stateIOverflow = (_zz_div2Domain_stateIOverflow <= _zz_div2Domain_stateIOverflow_1);
  assign div2Domain_state2IOverflow = (_zz_div2Domain_state2IOverflow <= _zz_div2Domain_state2IOverflow_1);
  assign div2Domain_allowToShift = (((div2Domain_state2IOverflow && div2Domain_stateIOverflow) || ((! div2Domain_state2IOverflow) && div2Domain_stateIOverflow)) || (div2Domain_intRate == div2Domain_decRate));
  assign div2Domain_si_0 = ((div2Domain_decRate < div2Domain_intRate) ? _zz_div2Domain_si_0 : _zz_div2Domain_si_0_2);
  assign div2Domain_si_1 = ((div2Domain_decRate < div2Domain_intRate) ? _zz_div2Domain_si_1 : _zz_div2Domain_si_1_2);
  assign when_ParallelSRC_l99 = (div2Domain_iRateDoubleTemp <= _zz_when_ParallelSRC_l99);
  assign when_ParallelSRC_l101 = (_zz_when_ParallelSRC_l101 <= _zz_when_ParallelSRC_l101_1);
  assign when_ParallelSRC_l106 = (div2Domain_iRateDoubleTemp <= _zz_when_ParallelSRC_l106);
  assign when_ParallelSRC_l108 = (_zz_when_ParallelSRC_l108 <= _zz_when_ParallelSRC_l108_1);
  assign when_ParallelSRC_l99_1 = (div2Domain_iRateDoubleTemp <= _zz_when_ParallelSRC_l99_1_1);
  assign when_ParallelSRC_l101_1 = (_zz_when_ParallelSRC_l101_1_1 <= _zz_when_ParallelSRC_l101_1_2);
  assign when_ParallelSRC_l106_1 = (div2Domain_iRateDoubleTemp <= _zz_when_ParallelSRC_l106_1_1);
  assign when_ParallelSRC_l108_1 = (_zz_when_ParallelSRC_l108_1_1 <= _zz_when_ParallelSRC_l108_1_2);
  assign when_ParallelSRC_l122 = (div2Domain_stateI_1 < div2Domain_state2I_1);
  assign when_ParallelSRC_l126 = (_zz_when_ParallelSRC_l126 < _zz_when_ParallelSRC_l126_2);
  assign when_ParallelSRC_l122_1 = (div2Domain_stateI_2 < div2Domain_state2I_2);
  assign when_ParallelSRC_l126_1 = (_zz_when_ParallelSRC_l126_1_1 < _zz_when_ParallelSRC_l126_1_3);
  assign io_interpolateRate_fire = (io_interpolateRate_valid && io_interpolateRate_ready);
  always @(*) begin
    if(io_interpolateRate_fire) begin
      io_input_ready = 1'b0;
    end
    if(io_decimateRate_fire) begin
      io_input_ready = 1'b0;
    end
    io_input_ready = (((((div2Domain_state2IOverflow && div2Domain_stateIOverflow) && (_zz_io_input_ready < div2Domain_dRateDoubleTemp)) || (((div2Domain_state2IOverflow && div2Domain_stateIOverflow) && (div2Domain_dRateDoubleTemp <= _zz_io_input_ready_1)) && _zz_io_input_ready_2[0])) || (((! div2Domain_state2IOverflow) && div2Domain_stateIOverflow) && _zz_io_input_ready_3[0])) || (div2Domain_intRate == div2Domain_decRate));
  end

  assign io_decimateRate_fire = (io_decimateRate_valid && io_decimateRate_ready);
  assign div2Domain_useSame = (_zz_div2Domain_useSame < _zz_div2Domain_useSame_2);
  assign div2Domain_shiftTwo = ((! div2Domain_useSame) && (_zz_div2Domain_shiftTwo < div2Domain_dRateDoubleTemp));
  assign div2Domain_hist_1_0 = (div2Domain_useSame ? ShiftRegWithMux_1 : ShiftRegWithMux);
  assign div2Domain_hist_0_0 = ShiftRegWithMux_1;
  assign div2Domain_hist_1_1 = (div2Domain_useSame ? ShiftRegWithMux_2 : ShiftRegWithMux_1);
  assign div2Domain_hist_0_1 = ShiftRegWithMux_2;
  assign div2Domain_hist_1_2 = (div2Domain_useSame ? ShiftRegWithMux_3 : ShiftRegWithMux_2);
  assign div2Domain_hist_0_2 = ShiftRegWithMux_3;
  assign div2Domain_hist_1_3 = (div2Domain_useSame ? ShiftRegWithMux_4 : ShiftRegWithMux_3);
  assign div2Domain_hist_0_3 = ShiftRegWithMux_4;
  assign div2Domain_hist_1_4 = (div2Domain_useSame ? ShiftRegWithMux_5 : ShiftRegWithMux_4);
  assign div2Domain_hist_0_4 = ShiftRegWithMux_5;
  assign div2Domain_hist_1_5 = (div2Domain_useSame ? ShiftRegWithMux_6 : ShiftRegWithMux_5);
  assign div2Domain_hist_0_5 = ShiftRegWithMux_6;
  assign switch_ParallelSRC_l156 = _zz_switch_ParallelSRC_l156_1;
  assign _zz_9 = 2'b01;
  assign summaryResult = ($signed(_zz_summaryResult_3) + $signed(_zz_summaryResult_2));
  assign div2Domain_delayLineResult_0 = (summaryResult >>> 8);
  assign _zz_switch_ParallelSRC_l156 = 1'b1;
  assign switch_ParallelSRC_l156_1 = _zz_switch_ParallelSRC_l156_1_1;
  assign switch_ParallelSRC_l163 = _zz_switch_ParallelSRC_l156;
  assign summaryResult_1 = ($signed(_zz_summaryResult_7) + $signed(_zz_summaryResult_6));
  assign div2Domain_delayLineResult_1 = (summaryResult_1 >>> 8);
  assign io_currInterpolateRate = div2Domain_intRate;
  assign io_currDecimateRate = div2Domain_decRate;
  assign when_ParallelSRC_l193 = ((io_output_ready == 1'b0) || (io_coefficientIndex_valid == 1'b1));
  assign when_ParallelSRC_l195 = ((io_input_ready && io_output_ready) && (outputDelay <= 8'h2e));
  assign when_ParallelSRC_l199 = (8'h08 < outputDelay);
  assign io_output_payload = _zz_io_output_payload;
  always @(posedge clk) begin
    if(reset) begin
      outputCount_value <= 1'b0;
      inputReg <= 8'h0;
      serialToParallel_1 <= 8'h0;
      currentState <= 3'b000;
      _zz_when_ClockDomain_l369 <= 1'b0;
      when_ClockDomain_l369_regNext <= 1'b0;
      outputDelay <= 8'h0;
    end else begin
      outputCount_value <= outputCount_valueNext;
      if(io_input_fire) begin
        inputReg <= io_input_payload;
      end
      if(io_input_fire_1) begin
        serialToParallel_1 <= serialToParallel_0;
      end
      _zz_when_ClockDomain_l369 <= (_zz_when_ClockDomain_l369 + 1'b1);
      if(when_ClockDomain_l369) begin
        _zz_when_ClockDomain_l369 <= 1'b0;
      end
      when_ClockDomain_l369_regNext <= when_ClockDomain_l369;
      currentState <= ((outputCount_value == 1'b0) ? ((currentState == 3'b010) ? 3'b000 : _zz_currentState) : currentState);
      if(when_ParallelSRC_l193) begin
        outputDelay <= 8'h0;
      end else begin
        if(when_ParallelSRC_l195) begin
          outputDelay <= (outputDelay + 8'h01);
        end
      end
    end
  end

  always @(posedge clk) begin
    if(clkDiv2) begin
      if(reset) begin
      div2Domain_coefficientVec_0_0 <= 19'h0;
      div2Domain_coefficientVec_0_1 <= 19'h0;
      div2Domain_coefficientVec_0_2 <= 19'h0;
      div2Domain_coefficientVec_0_3 <= 19'h0;
      div2Domain_coefficientVec_0_4 <= 19'h0;
      div2Domain_coefficientVec_0_5 <= 19'h0;
      div2Domain_coefficientVec_1_0 <= 19'h0;
      div2Domain_coefficientVec_1_1 <= 19'h0;
      div2Domain_coefficientVec_1_2 <= 19'h0;
      div2Domain_coefficientVec_1_3 <= 19'h0;
      div2Domain_coefficientVec_1_4 <= 19'h0;
      div2Domain_coefficientVec_1_5 <= 19'h0;
      div2Domain_coefficientVec_2_0 <= 19'h0;
      div2Domain_coefficientVec_2_1 <= 19'h0;
      div2Domain_coefficientVec_2_2 <= 19'h0;
      div2Domain_coefficientVec_2_3 <= 19'h0;
      div2Domain_coefficientVec_2_4 <= 19'h0;
      div2Domain_coefficientVec_2_5 <= 19'h0;
      div2Domain_coefficientVec_3_0 <= 19'h0;
      div2Domain_coefficientVec_3_1 <= 19'h0;
      div2Domain_coefficientVec_3_2 <= 19'h0;
      div2Domain_coefficientVec_3_3 <= 19'h0;
      div2Domain_coefficientVec_3_4 <= 19'h0;
      div2Domain_coefficientVec_3_5 <= 19'h0;
      div2Domain_coefficientVec_4_0 <= 19'h0;
      div2Domain_coefficientVec_4_1 <= 19'h0;
      div2Domain_coefficientVec_4_2 <= 19'h0;
      div2Domain_coefficientVec_4_3 <= 19'h0;
      div2Domain_coefficientVec_4_4 <= 19'h0;
      div2Domain_coefficientVec_4_5 <= 19'h0;
      div2Domain_coefficientVec_5_0 <= 19'h0;
      div2Domain_coefficientVec_5_1 <= 19'h0;
      div2Domain_coefficientVec_5_2 <= 19'h0;
      div2Domain_coefficientVec_5_3 <= 19'h0;
      div2Domain_coefficientVec_5_4 <= 19'h0;
      div2Domain_coefficientVec_5_5 <= 19'h0;
      div2Domain_intRate <= 4'b0000;
      div2Domain_decRate <= 4'b0000;
      div2Domain_stateI_0 <= 4'b0000;
      div2Domain_stateI_1 <= 4'b0000;
      div2Domain_stateI_2 <= 4'b0000;
      div2Domain_state2I_0 <= 4'b0000;
      div2Domain_state2I_1 <= 4'b0000;
      div2Domain_state2I_2 <= 4'b0000;
      div2Domain_decStateI_0 <= 4'b0000;
      div2Domain_decStateI_1 <= 4'b0000;
      div2Domain_decStateI_2 <= 4'b0000;
      div2Domain_decState2I_0 <= 4'b0000;
      div2Domain_decState2I_1 <= 4'b0000;
      div2Domain_decState2I_2 <= 4'b0000;
      div2Domain_dRateDoubleTemp <= 5'h0;
      div2Domain_dRateTemp <= 4'b0000;
      div2Domain_iRateDoubleTemp <= 5'h0;
      div2Domain_iRateTemp <= 4'b0000;
      ShiftRegWithMux <= 8'h0;
      ShiftRegWithMux_1 <= 8'h0;
      ShiftRegWithMux_2 <= 8'h0;
      ShiftRegWithMux_3 <= 8'h0;
      ShiftRegWithMux_4 <= 8'h0;
      ShiftRegWithMux_5 <= 8'h0;
      ShiftRegWithMux_6 <= 8'h0;
      multiResult_0 <= 16'h0;
      multiResult_1 <= 16'h0;
      multiResult_2 <= 16'h0;
      multiResult_3 <= 16'h0;
      multiResult_4 <= 16'h0;
      multiResult_5 <= 16'h0;
      filterCoefficient_0 <= 19'h0;
      filterCoefficient_1 <= 19'h0;
      filterCoefficient_2 <= 19'h0;
      filterCoefficient_3 <= 19'h0;
      filterCoefficient_4 <= 19'h0;
      filterCoefficient_5 <= 19'h0;
      dataIn_0 <= 8'h0;
      dataIn_1 <= 8'h0;
      dataIn_2 <= 8'h0;
      dataIn_3 <= 8'h0;
      dataIn_4 <= 8'h0;
      dataIn_5 <= 8'h0;
      multiResult_0_1 <= 16'h0;
      multiResult_1_1 <= 16'h0;
      multiResult_2_1 <= 16'h0;
      multiResult_3_1 <= 16'h0;
      multiResult_4_1 <= 16'h0;
      multiResult_5_1 <= 16'h0;
      filterCoefficient_0_1 <= 19'h0;
      filterCoefficient_1_1 <= 19'h0;
      filterCoefficient_2_1 <= 19'h0;
      filterCoefficient_3_1 <= 19'h0;
      filterCoefficient_4_1 <= 19'h0;
      filterCoefficient_5_1 <= 19'h0;
      dataIn_0_1 <= 8'h0;
      dataIn_1_1 <= 8'h0;
      dataIn_2_1 <= 8'h0;
      dataIn_3_1 <= 8'h0;
      dataIn_4_1 <= 8'h0;
      dataIn_5_1 <= 8'h0;
      end else begin
        if(io_coefficientIndex_valid) begin
          if(_zz_8[0]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_0 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
          if(_zz_8[1]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_1 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
          if(_zz_8[2]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_2 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
          if(_zz_8[3]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_3 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
          if(_zz_8[4]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_4 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
          if(_zz_8[5]) begin
            if(_zz_2) begin
              div2Domain_coefficientVec_0_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_3) begin
              div2Domain_coefficientVec_1_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_4) begin
              div2Domain_coefficientVec_2_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_5) begin
              div2Domain_coefficientVec_3_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_6) begin
              div2Domain_coefficientVec_4_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
            if(_zz_7) begin
              div2Domain_coefficientVec_5_5 <= _zz_div2Domain_coefficientVec_0_0;
            end
          end
        end
        div2Domain_stateI_0 <= 4'b0000;
        div2Domain_state2I_0 <= ((div2Domain_decRate == div2Domain_intRate) ? _zz_div2Domain_state2I_0 : ((div2Domain_decRate < div2Domain_intRate) ? div2Domain_decRate : div2Domain_intRate));
        div2Domain_dRateDoubleTemp <= ((div2Domain_decRate < div2Domain_intRate) ? div2Domain_dRateDouble : div2Domain_intRateDouble);
        div2Domain_dRateTemp <= ((div2Domain_decRate < div2Domain_intRate) ? div2Domain_decRate : div2Domain_intRate);
        div2Domain_iRateDoubleTemp <= ((div2Domain_decRate < div2Domain_intRate) ? div2Domain_intRateDouble : div2Domain_dRateDouble);
        div2Domain_iRateTemp <= ((div2Domain_decRate < div2Domain_intRate) ? div2Domain_intRate : div2Domain_decRate);
        if(when_ParallelSRC_l99) begin
          div2Domain_stateI_1 <= _zz_div2Domain_stateI_1[3:0];
        end else begin
          if(when_ParallelSRC_l101) begin
            div2Domain_stateI_1 <= _zz_div2Domain_stateI_1_3[3:0];
          end else begin
            div2Domain_stateI_1 <= _zz_div2Domain_stateI_1_7[3:0];
          end
        end
        if(when_ParallelSRC_l106) begin
          div2Domain_state2I_1 <= _zz_div2Domain_state2I_1[3:0];
        end else begin
          if(when_ParallelSRC_l108) begin
            div2Domain_state2I_1 <= _zz_div2Domain_state2I_1_3[3:0];
          end else begin
            div2Domain_state2I_1 <= _zz_div2Domain_state2I_1_7[3:0];
          end
        end
        if(when_ParallelSRC_l99_1) begin
          div2Domain_stateI_2 <= _zz_div2Domain_stateI_2[3:0];
        end else begin
          if(when_ParallelSRC_l101_1) begin
            div2Domain_stateI_2 <= _zz_div2Domain_stateI_2_3[3:0];
          end else begin
            div2Domain_stateI_2 <= _zz_div2Domain_stateI_2_7[3:0];
          end
        end
        if(when_ParallelSRC_l106_1) begin
          div2Domain_state2I_2 <= _zz_div2Domain_state2I_2[3:0];
        end else begin
          if(when_ParallelSRC_l108_1) begin
            div2Domain_state2I_2 <= _zz_div2Domain_state2I_2_3[3:0];
          end else begin
            div2Domain_state2I_2 <= _zz_div2Domain_state2I_2_7[3:0];
          end
        end
        div2Domain_decStateI_0 <= div2Domain_stateI_0;
        div2Domain_decStateI_1 <= div2Domain_stateI_1;
        div2Domain_decStateI_2 <= div2Domain_stateI_2;
        div2Domain_decState2I_0 <= div2Domain_state2I_0;
        div2Domain_decState2I_1 <= div2Domain_state2I_1;
        div2Domain_decState2I_2 <= div2Domain_state2I_2;
        div2Domain_decStateI_0 <= 4'b0000;
        div2Domain_decState2I_0 <= 4'b0000;
        if(when_ParallelSRC_l122) begin
          div2Domain_decStateI_1 <= div2Domain_stateI_0;
          div2Domain_decState2I_1 <= div2Domain_stateI_0;
        end
        if(when_ParallelSRC_l126) begin
          div2Domain_decStateI_1 <= div2Domain_stateI_0;
        end
        if(when_ParallelSRC_l122_1) begin
          div2Domain_decStateI_2 <= div2Domain_stateI_1;
          div2Domain_decState2I_2 <= div2Domain_stateI_1;
        end
        if(when_ParallelSRC_l126_1) begin
          div2Domain_decStateI_2 <= div2Domain_stateI_1;
        end
        if(io_interpolateRate_fire) begin
          div2Domain_intRate <= io_interpolateRate_payload;
        end
        if(io_decimateRate_fire) begin
          div2Domain_decRate <= io_decimateRate_payload;
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux <= (div2Domain_shiftTwo ? serialToParallel_0 : serialToParallel_1);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_1 <= (div2Domain_shiftTwo ? serialToParallel_1 : ShiftRegWithMux);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_2 <= (div2Domain_shiftTwo ? ShiftRegWithMux : ShiftRegWithMux_1);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_3 <= (div2Domain_shiftTwo ? ShiftRegWithMux_1 : ShiftRegWithMux_2);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_4 <= (div2Domain_shiftTwo ? ShiftRegWithMux_2 : ShiftRegWithMux_3);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_5 <= (div2Domain_shiftTwo ? ShiftRegWithMux_3 : ShiftRegWithMux_4);
        end
        if(div2Domain_allowToShift) begin
          ShiftRegWithMux_6 <= (div2Domain_shiftTwo ? ShiftRegWithMux_4 : ShiftRegWithMux_5);
        end
        case(switch_ParallelSRC_l156)
          4'b0000 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_0_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_0_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_0_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_0_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_0_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_0_5;
          end
          4'b0001 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_1_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_1_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_1_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_1_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_1_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_1_5;
          end
          4'b0010 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_2_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_2_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_2_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_2_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_2_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_2_5;
          end
          4'b0011 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_3_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_3_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_3_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_3_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_3_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_3_5;
          end
          4'b0100 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_4_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_4_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_4_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_4_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_4_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_4_5;
          end
          4'b0101 : begin
            filterCoefficient_0 <= div2Domain_coefficientVec_5_0;
            filterCoefficient_1 <= div2Domain_coefficientVec_5_1;
            filterCoefficient_2 <= div2Domain_coefficientVec_5_2;
            filterCoefficient_3 <= div2Domain_coefficientVec_5_3;
            filterCoefficient_4 <= div2Domain_coefficientVec_5_4;
            filterCoefficient_5 <= div2Domain_coefficientVec_5_5;
          end
          default : begin
          end
        endcase
        dataIn_0 <= div2Domain_hist_0_0;
        dataIn_1 <= div2Domain_hist_0_1;
        dataIn_2 <= div2Domain_hist_0_2;
        dataIn_3 <= div2Domain_hist_0_3;
        dataIn_4 <= div2Domain_hist_0_4;
        dataIn_5 <= div2Domain_hist_0_5;
        multiResult_0 <= _zz_multiResult_0_2[15:0];
        multiResult_1 <= _zz_multiResult_1_2[15:0];
        multiResult_2 <= _zz_multiResult_2_2[15:0];
        multiResult_3 <= _zz_multiResult_3_2[15:0];
        multiResult_4 <= _zz_multiResult_4_2[15:0];
        multiResult_5 <= _zz_multiResult_5_2[15:0];
        case(switch_ParallelSRC_l156_1)
          4'b0000 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_0_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_0_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_0_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_0_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_0_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_0_5;
          end
          4'b0001 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_1_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_1_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_1_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_1_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_1_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_1_5;
          end
          4'b0010 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_2_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_2_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_2_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_2_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_2_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_2_5;
          end
          4'b0011 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_3_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_3_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_3_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_3_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_3_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_3_5;
          end
          4'b0100 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_4_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_4_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_4_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_4_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_4_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_4_5;
          end
          4'b0101 : begin
            filterCoefficient_0_1 <= div2Domain_coefficientVec_5_0;
            filterCoefficient_1_1 <= div2Domain_coefficientVec_5_1;
            filterCoefficient_2_1 <= div2Domain_coefficientVec_5_2;
            filterCoefficient_3_1 <= div2Domain_coefficientVec_5_3;
            filterCoefficient_4_1 <= div2Domain_coefficientVec_5_4;
            filterCoefficient_5_1 <= div2Domain_coefficientVec_5_5;
          end
          default : begin
          end
        endcase
        if((switch_ParallelSRC_l163 == _zz_10)) begin
            dataIn_0_1 <= div2Domain_hist_0_0;
            dataIn_1_1 <= div2Domain_hist_0_1;
            dataIn_2_1 <= div2Domain_hist_0_2;
            dataIn_3_1 <= div2Domain_hist_0_3;
            dataIn_4_1 <= div2Domain_hist_0_4;
            dataIn_5_1 <= div2Domain_hist_0_5;
        end else if((switch_ParallelSRC_l163 == _zz_11)) begin
            dataIn_0_1 <= div2Domain_hist_1_0;
            dataIn_1_1 <= div2Domain_hist_1_1;
            dataIn_2_1 <= div2Domain_hist_1_2;
            dataIn_3_1 <= div2Domain_hist_1_3;
            dataIn_4_1 <= div2Domain_hist_1_4;
            dataIn_5_1 <= div2Domain_hist_1_5;
        end
        multiResult_0_1 <= _zz_multiResult_0_1_1[15:0];
        multiResult_1_1 <= _zz_multiResult_1_1_1[15:0];
        multiResult_2_1 <= _zz_multiResult_2_1_1[15:0];
        multiResult_3_1 <= _zz_multiResult_3_1_1[15:0];
        multiResult_4_1 <= _zz_multiResult_4_1_1[15:0];
        multiResult_5_1 <= _zz_multiResult_5_1_1[15:0];
      end
    end
  end

  always @(posedge clk) begin
    if(clkDiv2) begin
      _zz_multiResult_0 <= ($signed(dataIn_0) * $signed(filterCoefficient_0));
      _zz_multiResult_1 <= ($signed(dataIn_1) * $signed(filterCoefficient_1));
      _zz_multiResult_2 <= ($signed(dataIn_2) * $signed(filterCoefficient_2));
      _zz_multiResult_3 <= ($signed(dataIn_3) * $signed(filterCoefficient_3));
      _zz_multiResult_4 <= ($signed(dataIn_4) * $signed(filterCoefficient_4));
      _zz_multiResult_5 <= ($signed(dataIn_5) * $signed(filterCoefficient_5));
      _zz_summaryResult <= ($signed(multiResult_0) + $signed(multiResult_1));
      _zz_summaryResult_1 <= ($signed(multiResult_2) + $signed(multiResult_3));
      _zz_summaryResult_2 <= ($signed(multiResult_4) + $signed(multiResult_5));
      _zz_summaryResult_3 <= ($signed(_zz_summaryResult) + $signed(_zz_summaryResult_1));
      _zz_multiResult_0_1 <= ($signed(dataIn_0_1) * $signed(filterCoefficient_0_1));
      _zz_multiResult_1_1 <= ($signed(dataIn_1_1) * $signed(filterCoefficient_1_1));
      _zz_multiResult_2_1 <= ($signed(dataIn_2_1) * $signed(filterCoefficient_2_1));
      _zz_multiResult_3_1 <= ($signed(dataIn_3_1) * $signed(filterCoefficient_3_1));
      _zz_multiResult_4_1 <= ($signed(dataIn_4_1) * $signed(filterCoefficient_4_1));
      _zz_multiResult_5_1 <= ($signed(dataIn_5_1) * $signed(filterCoefficient_5_1));
      _zz_summaryResult_4 <= ($signed(multiResult_0_1) + $signed(multiResult_1_1));
      _zz_summaryResult_5 <= ($signed(multiResult_2_1) + $signed(multiResult_3_1));
      _zz_summaryResult_6 <= ($signed(multiResult_4_1) + $signed(multiResult_5_1));
      _zz_summaryResult_7 <= ($signed(_zz_summaryResult_4) + $signed(_zz_summaryResult_5));
    end
  end


endmodule

module CoefGen (
  input      [1:0]    io_coefSel_i /* verilator public */ ,
  input               io_request /* verilator public */ ,
  output     [18:0]   io_coef /* verilator public */ ,
  output reg          io_intRate_valid /* verilator public */ ,
  input               io_intRate_ready /* verilator public */ ,
  output reg [3:0]    io_intRate_payload /* verilator public */ ,
  output reg          io_decRate_valid /* verilator public */ ,
  input               io_decRate_ready /* verilator public */ ,
  output reg [3:0]    io_decRate_payload /* verilator public */ ,
  output reg          io_index_valid /* verilator public */ ,
  output     [3:0]    io_index_payload_indexLine /* verilator public */ ,
  output     [3:0]    io_index_payload_indexRow /* verilator public */ ,
  input               clk,
  input               reset
);

  reg        [18:0]   _zz_io_coef;
  wire       [5:0]    _zz_io_coef_1;
  wire       [18:0]   _zz_io_coef_2;
  wire       [0:0]    _zz_io_coef_3;
  wire       [3:0]    _zz_when_CoefGen_l75;
  wire       [6:0]    _zz_when_CoefGen_l81;
  wire       [3:0]    _zz_when_CoefGen_l86;
  wire       [3:0]    _zz_when_CoefGen_l87;
  reg        [1:0]    coefSel;
  reg        [18:0]   coefficientVec_0_0;
  reg        [18:0]   coefficientVec_0_1;
  reg        [18:0]   coefficientVec_0_2;
  reg        [18:0]   coefficientVec_0_3;
  reg        [18:0]   coefficientVec_0_4;
  reg        [18:0]   coefficientVec_0_5;
  reg        [18:0]   coefficientVec_0_6;
  reg        [18:0]   coefficientVec_0_7;
  reg        [18:0]   coefficientVec_0_8;
  reg        [18:0]   coefficientVec_0_9;
  reg        [18:0]   coefficientVec_0_10;
  reg        [18:0]   coefficientVec_0_11;
  reg        [18:0]   coefficientVec_0_12;
  reg        [18:0]   coefficientVec_0_13;
  reg        [18:0]   coefficientVec_0_14;
  reg        [18:0]   coefficientVec_0_15;
  reg        [18:0]   coefficientVec_0_16;
  reg        [18:0]   coefficientVec_0_17;
  reg        [18:0]   coefficientVec_0_18;
  reg        [18:0]   coefficientVec_0_19;
  reg        [18:0]   coefficientVec_0_20;
  reg        [18:0]   coefficientVec_0_21;
  reg        [18:0]   coefficientVec_0_22;
  reg        [18:0]   coefficientVec_0_23;
  reg        [18:0]   coefficientVec_0_24;
  reg        [18:0]   coefficientVec_0_25;
  reg        [18:0]   coefficientVec_0_26;
  reg        [18:0]   coefficientVec_0_27;
  reg        [18:0]   coefficientVec_0_28;
  reg        [18:0]   coefficientVec_0_29;
  reg        [18:0]   coefficientVec_0_30;
  reg        [18:0]   coefficientVec_0_31;
  reg        [18:0]   coefficientVec_0_32;
  reg        [18:0]   coefficientVec_0_33;
  reg        [18:0]   coefficientVec_0_34;
  reg        [18:0]   coefficientVec_0_35;
  reg                 updateStartReg;
  reg        [6:0]    updateCntReg;
  reg        [3:0]    rowCnt;
  reg        [3:0]    lineCnt;
  reg                 setupUpdate;
  reg                 io_request_regNext;
  wire                when_CoefGen_l51;
  reg        [0:0]    divReg;
  wire                when_CoefGen_l73;
  wire                when_CoefGen_l75;
  wire                when_CoefGen_l81;
  wire                when_CoefGen_l86;
  wire                when_CoefGen_l87;

  assign _zz_io_coef_1 = updateCntReg[5:0];
  assign _zz_io_coef_3 = 1'b0;
  assign _zz_io_coef_2 = {{18{_zz_io_coef_3[0]}}, _zz_io_coef_3};
  assign _zz_when_CoefGen_l75 = (rowCnt + 4'b0001);
  assign _zz_when_CoefGen_l81 = (updateCntReg + 7'h01);
  assign _zz_when_CoefGen_l86 = (rowCnt + 4'b0001);
  assign _zz_when_CoefGen_l87 = (lineCnt + 4'b0001);
  always @(*) begin
    case(_zz_io_coef_1)
      6'b000000 : _zz_io_coef = coefficientVec_0_0;
      6'b000001 : _zz_io_coef = coefficientVec_0_1;
      6'b000010 : _zz_io_coef = coefficientVec_0_2;
      6'b000011 : _zz_io_coef = coefficientVec_0_3;
      6'b000100 : _zz_io_coef = coefficientVec_0_4;
      6'b000101 : _zz_io_coef = coefficientVec_0_5;
      6'b000110 : _zz_io_coef = coefficientVec_0_6;
      6'b000111 : _zz_io_coef = coefficientVec_0_7;
      6'b001000 : _zz_io_coef = coefficientVec_0_8;
      6'b001001 : _zz_io_coef = coefficientVec_0_9;
      6'b001010 : _zz_io_coef = coefficientVec_0_10;
      6'b001011 : _zz_io_coef = coefficientVec_0_11;
      6'b001100 : _zz_io_coef = coefficientVec_0_12;
      6'b001101 : _zz_io_coef = coefficientVec_0_13;
      6'b001110 : _zz_io_coef = coefficientVec_0_14;
      6'b001111 : _zz_io_coef = coefficientVec_0_15;
      6'b010000 : _zz_io_coef = coefficientVec_0_16;
      6'b010001 : _zz_io_coef = coefficientVec_0_17;
      6'b010010 : _zz_io_coef = coefficientVec_0_18;
      6'b010011 : _zz_io_coef = coefficientVec_0_19;
      6'b010100 : _zz_io_coef = coefficientVec_0_20;
      6'b010101 : _zz_io_coef = coefficientVec_0_21;
      6'b010110 : _zz_io_coef = coefficientVec_0_22;
      6'b010111 : _zz_io_coef = coefficientVec_0_23;
      6'b011000 : _zz_io_coef = coefficientVec_0_24;
      6'b011001 : _zz_io_coef = coefficientVec_0_25;
      6'b011010 : _zz_io_coef = coefficientVec_0_26;
      6'b011011 : _zz_io_coef = coefficientVec_0_27;
      6'b011100 : _zz_io_coef = coefficientVec_0_28;
      6'b011101 : _zz_io_coef = coefficientVec_0_29;
      6'b011110 : _zz_io_coef = coefficientVec_0_30;
      6'b011111 : _zz_io_coef = coefficientVec_0_31;
      6'b100000 : _zz_io_coef = coefficientVec_0_32;
      6'b100001 : _zz_io_coef = coefficientVec_0_33;
      6'b100010 : _zz_io_coef = coefficientVec_0_34;
      default : _zz_io_coef = coefficientVec_0_35;
    endcase
  end

  always @(*) begin
    case(coefSel)
      2'b00 : begin
        io_intRate_payload = 4'b0110;
      end
      2'b01 : begin
        io_intRate_payload = 4'b0110;
      end
      2'b10 : begin
        io_intRate_payload = 4'b0110;
      end
      default : begin
        io_intRate_payload = 4'b0110;
      end
    endcase
  end

  always @(*) begin
    case(coefSel)
      2'b00 : begin
        io_decRate_payload = 4'b0110;
      end
      2'b01 : begin
        io_decRate_payload = 4'b0011;
      end
      2'b10 : begin
        io_decRate_payload = 4'b0010;
      end
      default : begin
        io_decRate_payload = 4'b0001;
      end
    endcase
  end

  assign when_CoefGen_l51 = (io_request && (! io_request_regNext));
  assign io_coef = (updateStartReg ? _zz_io_coef : _zz_io_coef_2);
  always @(*) begin
    io_index_valid = 1'b0;
    if(updateStartReg) begin
      io_index_valid = 1'b1;
    end
  end

  always @(*) begin
    io_decRate_valid = 1'b0;
    if(updateStartReg) begin
      io_decRate_valid = 1'b1;
    end
  end

  always @(*) begin
    io_intRate_valid = 1'b0;
    if(updateStartReg) begin
      io_intRate_valid = 1'b1;
    end
  end

  assign io_index_payload_indexRow = rowCnt;
  assign io_index_payload_indexLine = lineCnt;
  assign when_CoefGen_l73 = ((divReg == 1'b0) && updateStartReg);
  assign when_CoefGen_l75 = (_zz_when_CoefGen_l75 == 4'b0110);
  assign when_CoefGen_l81 = (_zz_when_CoefGen_l81 == 7'h24);
  assign when_CoefGen_l86 = (_zz_when_CoefGen_l86 == 4'b0110);
  assign when_CoefGen_l87 = (_zz_when_CoefGen_l87 == 4'b0110);
  always @(posedge clk) begin
    if(reset) begin
      coefSel <= 2'b00;
      coefficientVec_0_0 <= 19'h0;
      coefficientVec_0_1 <= 19'h0;
      coefficientVec_0_2 <= 19'h0;
      coefficientVec_0_3 <= 19'h0;
      coefficientVec_0_4 <= 19'h0;
      coefficientVec_0_5 <= 19'h0;
      coefficientVec_0_6 <= 19'h0;
      coefficientVec_0_7 <= 19'h0;
      coefficientVec_0_8 <= 19'h0;
      coefficientVec_0_9 <= 19'h0;
      coefficientVec_0_10 <= 19'h0;
      coefficientVec_0_11 <= 19'h0;
      coefficientVec_0_12 <= 19'h0;
      coefficientVec_0_13 <= 19'h0;
      coefficientVec_0_14 <= 19'h0;
      coefficientVec_0_15 <= 19'h0;
      coefficientVec_0_16 <= 19'h0;
      coefficientVec_0_17 <= 19'h0;
      coefficientVec_0_18 <= 19'h0;
      coefficientVec_0_19 <= 19'h0;
      coefficientVec_0_20 <= 19'h0;
      coefficientVec_0_21 <= 19'h0;
      coefficientVec_0_22 <= 19'h0;
      coefficientVec_0_23 <= 19'h0;
      coefficientVec_0_24 <= 19'h0;
      coefficientVec_0_25 <= 19'h0;
      coefficientVec_0_26 <= 19'h0;
      coefficientVec_0_27 <= 19'h0;
      coefficientVec_0_28 <= 19'h0;
      coefficientVec_0_29 <= 19'h0;
      coefficientVec_0_30 <= 19'h0;
      coefficientVec_0_31 <= 19'h0;
      coefficientVec_0_32 <= 19'h0;
      coefficientVec_0_33 <= 19'h0;
      coefficientVec_0_34 <= 19'h0;
      coefficientVec_0_35 <= 19'h0;
      updateStartReg <= 1'b0;
      updateCntReg <= 7'h0;
      rowCnt <= 4'b0000;
      lineCnt <= 4'b0000;
      setupUpdate <= 1'b1;
      divReg <= 1'b0;
    end else begin
      coefficientVec_0_0 <= 19'h0;
      coefficientVec_0_1 <= 19'h7fdc1;
      coefficientVec_0_2 <= 19'h00f6f;
      coefficientVec_0_3 <= 19'h071dc;
      coefficientVec_0_4 <= 19'h001a8;
      coefficientVec_0_5 <= 19'h7ff53;
      coefficientVec_0_6 <= 19'h0000b;
      coefficientVec_0_7 <= 19'h7fb74;
      coefficientVec_0_8 <= 19'h02353;
      coefficientVec_0_9 <= 19'h066d4;
      coefficientVec_0_10 <= 19'h7fa45;
      coefficientVec_0_11 <= 19'h00013;
      coefficientVec_0_12 <= 19'h00029;
      coefficientVec_0_13 <= 19'h7f918;
      coefficientVec_0_14 <= 19'h03b2f;
      coefficientVec_0_15 <= 19'h05338;
      coefficientVec_0_16 <= 19'h7f810;
      coefficientVec_0_17 <= 19'h00040;
      coefficientVec_0_18 <= 19'h00040;
      coefficientVec_0_19 <= 19'h7f810;
      coefficientVec_0_20 <= 19'h05338;
      coefficientVec_0_21 <= 19'h03b2f;
      coefficientVec_0_22 <= 19'h7f918;
      coefficientVec_0_23 <= 19'h00029;
      coefficientVec_0_24 <= 19'h00013;
      coefficientVec_0_25 <= 19'h7fa45;
      coefficientVec_0_26 <= 19'h066d4;
      coefficientVec_0_27 <= 19'h02353;
      coefficientVec_0_28 <= 19'h7fb74;
      coefficientVec_0_29 <= 19'h0000b;
      coefficientVec_0_30 <= 19'h7ff53;
      coefficientVec_0_31 <= 19'h001a8;
      coefficientVec_0_32 <= 19'h071dc;
      coefficientVec_0_33 <= 19'h00f6f;
      coefficientVec_0_34 <= 19'h7fdc1;
      coefficientVec_0_35 <= 19'h0;
      if(when_CoefGen_l51) begin
        coefSel <= io_coefSel_i;
        updateStartReg <= 1'b1;
      end else begin
        if(setupUpdate) begin
          setupUpdate <= 1'b0;
          updateStartReg <= 1'b1;
        end
      end
      divReg <= (divReg + 1'b1);
      if(when_CoefGen_l73) begin
        if(updateStartReg) begin
          if(when_CoefGen_l75) begin
            rowCnt <= 4'b0000;
          end else begin
            rowCnt <= (rowCnt + 4'b0001);
          end
          updateCntReg <= (updateCntReg + 7'h01);
          if(when_CoefGen_l81) begin
            updateStartReg <= 1'b0;
            updateCntReg <= 7'h0;
          end
        end
        if(when_CoefGen_l86) begin
          if(when_CoefGen_l87) begin
            lineCnt <= 4'b0000;
          end else begin
            lineCnt <= (lineCnt + 4'b0001);
          end
        end
      end
    end
  end

  always @(posedge clk) begin
    io_request_regNext <= io_request;
  end


endmodule
