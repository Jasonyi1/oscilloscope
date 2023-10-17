
// Efinity Top-level template
// Version: 2023.1.150.4.10
// Date: 2023-10-17 10:45

// Copyright (C) 2017 - 2023 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as C:\Users\jason\Desktop\FPGA competition\Elitestek_Oscilloscope-bram (1)\Elitestek_Oscilloscope-bram\Efinity\OscilloscopeInterfaceTest.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  OscilloscopeInterfaceTest
//     #4)  Insert design content.


module OscilloscopeInterfaceTest
(
  input clk_12M_i,
  input clk_24M_i,
  input ADC_CLK_N,
  input [1:0] key,
  input [1:0] PllLocked,
  input [7:0] DBA,
  input [7:0] DBB,
  input ADC_CLK_P,
  input Axi_Clk,
  input tx_slowclk,
  input tx_fastclk,
  input DCO_P,
  input frame_pclk,
  input adc_clk,
  input DCO_N,
  input DdrCtrl_AREADY_0,
  input [7:0] DdrCtrl_BID_0,
  input DdrCtrl_BVALID_0,
  input [127:0] DdrCtrl_RDATA_0,
  input [7:0] DdrCtrl_RID_0,
  input DdrCtrl_RLAST_0,
  input [1:0] DdrCtrl_RRESP_0,
  input DdrCtrl_RVALID_0,
  input DdrCtrl_WREADY_0,
  output [7:0] LED,
  output pdwn,
  output DS,
  output lcd_pwm,
  output [6:0] lvds_tx0_DATA,
  output [6:0] lvds_tx1_DATA,
  output [6:0] lvds_tx2_DATA,
  output [6:0] lvds_tx3_DATA,
  output [6:0] lvds_tx_clk_DATA,
  output [31:0] DdrCtrl_AADDR_0,
  output [1:0] DdrCtrl_ABURST_0,
  output [7:0] DdrCtrl_AID_0,
  output [7:0] DdrCtrl_ALEN_0,
  output [1:0] DdrCtrl_ALOCK_0,
  output [2:0] DdrCtrl_ASIZE_0,
  output DdrCtrl_ATYPE_0,
  output DdrCtrl_AVALID_0,
  output DdrCtrl_BREADY_0,
  output DdrCtrl_CFG_SEQ_RST,
  output DdrCtrl_CFG_SEQ_START,
  output DdrCtrl_RREADY_0,
  output DdrCtrl_CFG_RST_N,
  output [127:0] DdrCtrl_WDATA_0,
  output [7:0] DdrCtrl_WID_0,
  output DdrCtrl_WLAST_0,
  output [15:0] DdrCtrl_WSTRB_0,
  output DdrCtrl_WVALID_0
);


endmodule

