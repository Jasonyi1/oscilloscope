


# Efinity Interface Designer SDC
# Version: 2022.1.226.4.3
# Date: 2022-12-31 11:58

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: T35F324
# Project: T35_Sensor_DDR3_LCD_Test
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 2.5063 Ddr_Clk
# create_clock -period 1.87617 Ddr_Clk
create_clock -period 37.5940 clk_cmos
create_clock -period 10.4167 Axi_Clk
create_clock -period 20.8333 tx_slowclk
create_clock -waveform {1.4881 4.4643} -period 5.9524 tx_fastclk
#create_clock -period 20.0501 frame_pclk
create_clock -period 15.0376 frame_pclk

create_clock -period 15.0376 DCO_P
create_clock -period 15.0376 DCO_N

create_clock -period 7.5188 adc_clk
#create_clock -period 5.0125 adc_clk

set_clock_groups -group {frame_pclk} -group {adc_clk} -group {Axi_Clk} -group {tx_slowclk} -group(DCO_P) -group(DCO_N)

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_12M_i}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_12M_i}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_24M_i}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_24M_i}]
# create_clock -period <USER_PERIOD> [get_ports {cmos_pclk}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[5]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[7]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[7]}]

# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {ADC_CLK_N}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {ADC_CLK_N}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {ADC_CLK_P}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {ADC_CLK_P}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[0]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[0]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[1]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[1]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[2]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[2]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[3]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[3]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[4]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[4]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[5]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[5]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[6]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[6]}]
set_input_delay -clock DCO_N -max 5.100 [get_ports {DBA[7]}]
set_input_delay -clock DCO_N -min 2.550 [get_ports {DBA[7]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[0]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[0]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[1]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[1]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[2]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[2]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[3]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[3]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[4]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[4]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[5]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[5]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[6]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[6]}]
set_input_delay -clock DCO_P -max 5.100 [get_ports {DBB[7]}]
set_input_delay -clock DCO_P -min 2.550 [get_ports {DBB[7]}]
set_output_delay -clock adc_clk -max -4.210 [get_ports {pdwn}]
set_output_delay -clock adc_clk -min -2.330 [get_ports {pdwn}]
set_output_delay -clock adc_clk -max -4.210 [get_ports {DS}]
set_output_delay -clock adc_clk -min -2.330 [get_ports {DS}]

# LVDS RX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {lcd_pwm}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {lcd_pwm}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_ctl1}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_ctl1}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[4]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[4]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[5]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[5]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[6]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[6]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_data[7]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_data[7]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_href}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_href}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_vsync}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_vsync}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_ctl0}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_ctl0}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_ctl2}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_ctl2}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_ctl3}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_ctl3}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_sclk}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_sclk}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_sdat_IN}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_sdat_IN}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_sdat_OUT}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_sdat_OUT}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cmos_sdat_OE}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cmos_sdat_OE}]



# LVDS Tx Constraints
####################
set_output_delay -clock tx_slowclk -max -4.230 [get_ports {lvds_tx0_DATA[6] lvds_tx0_DATA[5] lvds_tx0_DATA[4] lvds_tx0_DATA[3] lvds_tx0_DATA[2] lvds_tx0_DATA[1] lvds_tx0_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.235 [get_ports {lvds_tx0_DATA[6] lvds_tx0_DATA[5] lvds_tx0_DATA[4] lvds_tx0_DATA[3] lvds_tx0_DATA[2] lvds_tx0_DATA[1] lvds_tx0_DATA[0]}]
set_output_delay -clock tx_slowclk -max -4.230 [get_ports {lvds_tx1_DATA[6] lvds_tx1_DATA[5] lvds_tx1_DATA[4] lvds_tx1_DATA[3] lvds_tx1_DATA[2] lvds_tx1_DATA[1] lvds_tx1_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.235 [get_ports {lvds_tx1_DATA[6] lvds_tx1_DATA[5] lvds_tx1_DATA[4] lvds_tx1_DATA[3] lvds_tx1_DATA[2] lvds_tx1_DATA[1] lvds_tx1_DATA[0]}]
set_output_delay -clock tx_slowclk -max -4.230 [get_ports {lvds_tx2_DATA[6] lvds_tx2_DATA[5] lvds_tx2_DATA[4] lvds_tx2_DATA[3] lvds_tx2_DATA[2] lvds_tx2_DATA[1] lvds_tx2_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.235 [get_ports {lvds_tx2_DATA[6] lvds_tx2_DATA[5] lvds_tx2_DATA[4] lvds_tx2_DATA[3] lvds_tx2_DATA[2] lvds_tx2_DATA[1] lvds_tx2_DATA[0]}]
set_output_delay -clock tx_slowclk -max -4.230 [get_ports {lvds_tx3_DATA[6] lvds_tx3_DATA[5] lvds_tx3_DATA[4] lvds_tx3_DATA[3] lvds_tx3_DATA[2] lvds_tx3_DATA[1] lvds_tx3_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.235 [get_ports {lvds_tx3_DATA[6] lvds_tx3_DATA[5] lvds_tx3_DATA[4] lvds_tx3_DATA[3] lvds_tx3_DATA[2] lvds_tx3_DATA[1] lvds_tx3_DATA[0]}]
set_output_delay -clock tx_slowclk -max -4.230 [get_ports {lvds_tx_clk_DATA[6] lvds_tx_clk_DATA[5] lvds_tx_clk_DATA[4] lvds_tx_clk_DATA[3] lvds_tx_clk_DATA[2] lvds_tx_clk_DATA[1] lvds_tx_clk_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.235 [get_ports {lvds_tx_clk_DATA[6] lvds_tx_clk_DATA[5] lvds_tx_clk_DATA[4] lvds_tx_clk_DATA[3] lvds_tx_clk_DATA[2] lvds_tx_clk_DATA[1] lvds_tx_clk_DATA[0]}]

# DDR Constraints
#####################
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_AADDR_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_AADDR_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_ABURST_0[1] DdrCtrl_ABURST_0[0]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_ABURST_0[1] DdrCtrl_ABURST_0[0]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_AID_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_AID_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_ALEN_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_ALEN_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_ALOCK_0[1] DdrCtrl_ALOCK_0[0]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_ALOCK_0[1] DdrCtrl_ALOCK_0[0]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_ASIZE_0[2] DdrCtrl_ASIZE_0[1] DdrCtrl_ASIZE_0[0]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_ASIZE_0[2] DdrCtrl_ASIZE_0[1] DdrCtrl_ASIZE_0[0]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_ATYPE_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_ATYPE_0}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_AVALID_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_AVALID_0}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_BREADY_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_BREADY_0}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_RREADY_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_RREADY_0}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_WDATA_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_WDATA_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_WID_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_WID_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_WLAST_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_WLAST_0}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_WSTRB_0[*]}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_WSTRB_0[*]}]
set_output_delay -clock Axi_Clk -max -1.810 [get_ports {DdrCtrl_WVALID_0}]
set_output_delay -clock Axi_Clk -min -2.655 [get_ports {DdrCtrl_WVALID_0}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_AREADY_0}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_AREADY_0}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_BID_0[*]}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_BID_0[*]}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_BVALID_0}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_BVALID_0}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_RDATA_0[*]}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_RDATA_0[*]}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_RID_0[*]}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_RID_0[*]}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_RLAST_0}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_RLAST_0}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_RRESP_0[1] DdrCtrl_RRESP_0[0]}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_RRESP_0[1] DdrCtrl_RRESP_0[0]}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_RVALID_0}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_RVALID_0}]
set_input_delay -clock Axi_Clk -max 7.310 [get_ports {DdrCtrl_WREADY_0}]
set_input_delay -clock Axi_Clk -min 3.655 [get_ports {DdrCtrl_WREADY_0}]
