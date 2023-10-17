
`timescale 100ps/10ps

//`include  "ParamDefine.v"

//`include "ddr_calibration_defines.v"
module  OscilloscopeInterfaceTest 
(
  //System Signal
  input clk_12M_i,
  input clk_24M_i,

  input           Axi_Clk   , //Axi 0 Channel Clock, 400MHz
  input           tx_slowclk,	//48MHz
  input           tx_fastclk,	//168MHz
  
//  input           clk_cmos,		//27MHz
  input   [ 1:0]  PllLocked , //PLL Locked
  
 
  //DDR Controner Control Signal
  output          DdrCtrl_CFG_RST_N          , //(O)[Control]DDR Controner Reset(Low Active)     
  output          DdrCtrl_CFG_SEQ_RST   , //(O)[Control]DDR Controner Sequencer Reset 
  output          DdrCtrl_CFG_SEQ_START , //(O)[Control]DDR Controner Sequencer Start 
  
  //auto calibration
//  output          DdrCtrl_CFG_SCL_IN,       //ddr_slave_i2c_scl,   
//  output          DdrCtrl_CFG_SDA_IN,       //ddr_slave_i2c_sda,   
//  input           DdrCtrl_CFG_SDA_OEN,      //ddr_slave_i2c_sda_in,
  
  //DDR Controner AXI4 0 Signal
  output  [ 7:0]  DdrCtrl_AID_0     , //(O)[Addres] Address ID
  output  [31:0]  DdrCtrl_AADDR_0   , //(O)[Addres] Address
  output  [ 7:0]  DdrCtrl_ALEN_0    , //(O)[Addres] Address Brust Length
  output  [ 2:0]  DdrCtrl_ASIZE_0   , //(O)[Addres] Address Burst size
  output  [ 1:0]  DdrCtrl_ABURST_0  , //(O)[Addres] Address Burst type
  output  [ 1:0]  DdrCtrl_ALOCK_0   , //(O)[Addres] Address Lock type
  output          DdrCtrl_AVALID_0  , //(O)[Addres] Address Valid
  input           DdrCtrl_AREADY_0  , //(I)[Addres] Address Ready
  output          DdrCtrl_ATYPE_0   , //(O)[Addres] Operate Type 0=Read, 1=Write

  output  [ 7:0]  DdrCtrl_WID_0     , //(O)[Write]  ID
  output [127:0]  DdrCtrl_WDATA_0   , //(O)[Write]  Data
  output  [15:0]  DdrCtrl_WSTRB_0   , //(O)[Write]  Data Strobes(Byte valid)
  output          DdrCtrl_WLAST_0   , //(O)[Write]  Data Last
  output          DdrCtrl_WVALID_0  , //(O)[Write]  Data Valid
  input           DdrCtrl_WREADY_0  , //(I)[Write]  Data Ready

  input   [ 7:0]  DdrCtrl_RID_0     , //(I)[Read]   ID
  input  [127:0]  DdrCtrl_RDATA_0   , //(I)[Read]   Data
  input           DdrCtrl_RLAST_0   , //(I)[Read]   Data Last
  input           DdrCtrl_RVALID_0  , //(I)[Read]   Data Valid
  output          DdrCtrl_RREADY_0  , //(O)[Read]   Data Ready
  input   [ 1:0]  DdrCtrl_RRESP_0   , //(I)[Read]   Response

  input   [ 7:0]  DdrCtrl_BID_0     , //(I)[Answer] Response Write ID
  input           DdrCtrl_BVALID_0  , //(I)[Answer] Response valid
  output          DdrCtrl_BREADY_0  , //(O)[Answer] Response Ready

  //Other Signal
  output  [7:0]   LED               ,
  
  input [1:0] key,

    input           adc_clk,
    input           frame_pclk,            
    
    output          lcd_pwm,
    output  [6:0]   lvds_tx_clk_DATA,
    output  [6:0]   lvds_tx0_DATA,
    output  [6:0]   lvds_tx1_DATA,
    output  [6:0]   lvds_tx2_DATA,
    output  [6:0]   lvds_tx3_DATA
);
//----------------------------------------------------------------------

assign  lcd_pwm = 1'b1;

localparam CLOCK_MAIN  = 96_000000;
localparam CLOCK_CMOS  = 27_000000;
localparam CLOCK_PIXEL = 74_250000;



wire sys_rst_n = PllLocked[0];
    
/*------------------------------------------------------
//  Clock & Reset Process
//***************************************************/
  
  /////////////////////////////////////////////////////////
  //Power On Reset Process
  reg [7:0] PowerOnResetCnt = 8'h0  ; //Power On Reset Counter
  reg [2:0] ResetShiftReg   = 3'h0  ; //Reset Shift Regist
  
  always @( posedge Axi_Clk) if (&PllLocked)    
  begin
    PowerOnResetCnt <= PowerOnResetCnt + {7'h0,(~&PowerOnResetCnt)};
  end
  
  always @( posedge Axi_Clk)  
  begin
    ResetShiftReg[2] <= ResetShiftReg[1] ;
    ResetShiftReg[1] <= ResetShiftReg[0] ;
    ResetShiftReg[0] <= (&PowerOnResetCnt);
  end    
  
  /////////////////////////////////////////////////////////
  //DDR Reset  
  wire  DDrCtrlReset  ;  //DDR Controner Reset(Low Active)  
  wire  DdrSeqReset   ;  //DDR Controner Sequencer Reset    
  wire  DDrSeqStart   ;  //DDR Controner Sequencer Start    
  wire  DdrInitDone   ;  //DDR Initial Done status
  
  etx_ddr3_reset_controller U0_DDR_Reset
  (
    .ddr_rstn_i         ( ResetShiftReg[2]      ), // main user DDR reset, active low
    .clk                ( Axi_Clk                ), // user clock
    /* Connect these three signals to DDR reset interface */
    .ddr_rstn           ( DdrCtrl_CFG_RST_N     ), // Master Reset
    .ddr_cfg_seq_rst    ( DdrCtrl_CFG_SEQ_RST   ), // Sequencer Reset
    .ddr_cfg_seq_start  ( DdrCtrl_CFG_SEQ_START ), // Sequencer Start
    /* optional status monitor for user logic */
    .ddr_init_done        ( DdrInitDone           )  // Done status
  );
  

//----------------------------------------------------------------
//generate data as fifo input
wire [7:0] wave_data;
DdsModule u_DDS(
  .io_signalOut(wave_data),
  .clk(adc_clk),
  .reset(~sys_rst_n)
);

wire [7:0] data_to_trigger = {~wave_data[7],wave_data[6:0]};
wire tri_valid;
wire [7:0] data_to_fifo;

tri_ctrl tri_ctrl_o(
    .clk( adc_clk ),
    .rst( ~sys_rst_n ),
    .data_in ( data_to_trigger ),
    .tri_level (  ),
    .change (  ),
    
    .tri_valid ( tri_valid ),
    .data_out ( data_to_fifo )
);

wire [7:0] fifo_data_out;
wire fifo_valid = ram_state == S_READ_FIFO;
wire fifo_empty;
wire fifo_rd_en;
wire data_valid;
wire [3:0] fifo_state;
wire [2:0] dec_rate;
// wire fifo_debug = 1'b1;
fifo_data_recv u_FIFO_DATA_RECV(
    .wr_clk(adc_clk),
    .rd_clk(frame_pclk),
    .rst(~sys_rst_n),
    .fifo_data_in(data_to_fifo),
    .valid(~ram_busy),
    
    .trigger(tri_valid),

    .ram_ready(ram_ready),

    .out_ready( src_in_ready ),
    .src_output_valid( src_output_valid ),
    .src_output_ready( src_output_ready ),
    .dec_rate(dec_rate),
    .data_valid ( data_valid ),
    .empty_o(fifo_empty),
    .full_o(),
    //.rd_en(fifo_rd_en),
    .fifo_data_out(fifo_data_out)
    // .fifo_state_out( fifo_state )
);

wire src_req;
wire [1:0] src_coef_idx; 
KEY_2bit u_key(
  .clk( frame_pclk ),            
	.rst_n( sys_rst_n ),

  .key_data( key ),
    
	.src_req( src_req ),
	.src_coef_idx( src_coef_idx ),

  .dec_rate( dec_rate )
);

wire src_input_valid = 1'b1;
wire src_output_ready;
wire src_output_valid;
wire src_in_ready;
wire [7:0] src_out;

wire [3:0] intRate;
wire [3:0] decRate;
wire [7:0] data_to_src = {~fifo_data_out[7],fifo_data_out[6:0]};
CoefGen_With_SRC u_interpolation(
  .io_src_in_valid( src_input_valid ),
  .io_src_in_ready( src_in_ready ),
  .io_src_in_payload( data_to_src ),

  .io_src_out_valid( src_output_valid ),
  .io_src_out_ready( src_output_ready ),
  .io_src_out_payload( src_out ),

  .io_intRate( intRate ),
  .io_decRate( decRate ),

  .io_coefSel_i( src_coef_idx ),
  .io_request( src_req ),
  .clk( frame_pclk ),
  .reset( ~sys_rst_n )
);

wire data_output_fire = (intRate == decRate) ? 1'b1 : (src_output_ready & src_output_valid);
wire [7:0] data_to_ram = (intRate == decRate) ? fifo_data_out : {~src_out[7],src_out[6:0]};
wire ram_busy;
wire ram_ready;
wire [2:0] ram_state;
wire [13:0] ram_raddr;
wire [4:0] ram_re;

database database_0(
    .clk( frame_pclk ),//
    .rst( ~sys_rst_n ),//
    
    .data_in ( data_to_ram ),//
    .data_valid ( data_valid ),//在信号输入期间全程保持1，转0表示信号输入已经完成。
    .data_output_fire ( data_output_fire ),
    
    .raddr_in ( ram_raddr ),    //
    .rden_in ( ram_re ),    //
    .frame_de ( frame_de ), //
    
    .src_output_ready ( src_output_ready ),
    .state_out( ram_state ), //test
    .ram_ready ( newFrame ),//为1表示ram已经完成波形叠加过程，持续一个时钟周期。
    .ram_busy ( ram_busy ),//为1表示ram暂时不能接收采样点数据。
    .color_out ( ram_rdata )//输出颜色信息
);

assign  LED = {5'b0, ram_state};

localparam S_IDLE         = 3'd0; //初始状态
localparam S_RAM_REFRESH  = 3'd1; //RAM清零
localparam S_READ_FIFO    = 3'd2; //读FIFO数据 写RAM
localparam S_LCD_REFRESH  = 3'd3; //LCD刷新

//----------------------------------------------------------------------
//图像产生
wire            frame_de; 
wire            frame_href;
wire    [15:0]  frame_RGB;
wire    [15:0]  ram_rdata;
wire newFrame;
VsyHsyGenerator u_VsyHsyGenerator(
  .io_de(frame_de),
  .io_color(frame_RGB),
  .io_nextFrame(newFrame),
  .ram_addr(ram_raddr),
  .ram_color(ram_rdata),
  .ram_en(ram_re),
  .clk(frame_pclk),
  .reset(~sys_rst_n)
);
//---------------------------------
//AXI Reset Generate

reg   [2:0] Axi0ResetReg = 3'h0;    
  
  always @( posedge Axi_Clk)  
  begin
  Axi0ResetReg[2] <= Axi0ResetReg[1] ;
  Axi0ResetReg[1] <= Axi0ResetReg[0] ;
  Axi0ResetReg[0] <= DdrInitDone;
  end
    
  wire    Axi_Rst_N  = Axi0ResetReg[2]; //System Reset (Low Active)
  

wire	User_Clk = Axi_Clk;
wire	User_Rst_N = Axi_Rst_N;

//----------------------------------------------------------------------
axi4_ctrl u_axi4_ctrl
(
    .axi_clk        (Axi_Clk    ),
    .axi_reset      (~User_Rst_N ),
    
    .axi_aid        (DdrCtrl_AID_0),
    .axi_aaddr      (DdrCtrl_AADDR_0),
    .axi_alen       (DdrCtrl_ALEN_0),
    .axi_asize      (DdrCtrl_ASIZE_0),
    .axi_aburst     (DdrCtrl_ABURST_0),
    .axi_alock      (DdrCtrl_ALOCK_0),
    .axi_avalid     (DdrCtrl_AVALID_0),
    .axi_aready     (DdrCtrl_AREADY_0),
    .axi_atype      (DdrCtrl_ATYPE_0),
    
    .axi_wid        (DdrCtrl_WID_0),
    .axi_wdata      (DdrCtrl_WDATA_0),
    .axi_wstrb      (DdrCtrl_WSTRB_0),
    .axi_wlast      (DdrCtrl_WLAST_0),
    .axi_wvalid     (DdrCtrl_WVALID_0),
    .axi_wready     (DdrCtrl_WREADY_0),
    
    .axi_bid        (DdrCtrl_BID_0),
    .axi_bvalid     (DdrCtrl_BVALID_0),
    .axi_bready     (DdrCtrl_BREADY_0),
    
    .axi_rid        (DdrCtrl_RID_0),
    .axi_rdata      (DdrCtrl_RDATA_0),
    .axi_rlast      (DdrCtrl_RLAST_0),
    .axi_rvalid     (DdrCtrl_RVALID_0),
    .axi_rready     (DdrCtrl_RREADY_0),
    .axi_rresp      (DdrCtrl_RRESP_0),
    
    .wframe_pclk    (frame_pclk),
    .wframe_data_en (frame_de),
    .wframe_data    (frame_RGB),
    
    .rframe_pclk    (tx_slowclk),
    .rframe_vsync   (lcd_vs),
    .rframe_data_en (lcd_de),
    .rframe_data    (lcd_data)
);

//-------------------------------------
//LCD driver timing
wire  			lcd_de;
wire  			lcd_hs;      
wire  			lcd_vs;
wire  	[7:0]   lcd_red;
wire  	[7:0]   lcd_green;
wire  	[7:0]   lcd_blue;
//wire	[11:0]	lcd_xpos;		//lcd horizontal coordinate
//wire	[11:0]	lcd_ypos;		//lcd vertical coordinate
wire	[15:0]	lcd_data;		//lcd data
wire [23:0] rgb565;
assign rgb565 = {lcd_data[15:11], 3'b000, lcd_data[10:5], 2'b00, lcd_data[4:0], 3'b000};
lcd_driver u_lcd_driver
(
	//global clock
	.clk			(tx_slowclk),		
	.rst_n			(User_Rst_N), 
	 
	 //lcd interface
	.lcd_dclk		(),//(lcd_dclk),
	.lcd_blank		(),//lcd_blank
	.lcd_sync		(),		    	
	.lcd_hs			(lcd_hs),		
	.lcd_vs			(lcd_vs),
	.lcd_en			(lcd_de),		
	.lcd_rgb		({lcd_red, lcd_green, lcd_blue}),

	
	//user interface
	// .lcd_request	(),
	.lcd_data		(rgb565)//,	
    //.lcd_data		(24'hff00ff)
    //.lcd_xpos		(lcd_xpos),	
    //.lcd_ypos		(lcd_ypos)
);



wire    [7:0]   c0 = 7'b1100011;
wire    [7:0]   d0 = {lcd_green[0],  lcd_red[5:0]};
wire    [7:0]   d1 = {lcd_blue[1:0], lcd_green[5:1]};
wire    [7:0]   d2 = {lcd_de, 2'b0,  lcd_blue[5:2]};   //vs hs is reserved
wire    [7:0]   d3 = {1'b0, lcd_blue[7:6], lcd_green[7:6], lcd_red[7:6]};

assign  lvds_tx_clk_DATA = {c0[0], c0[1], c0[2], c0[3], c0[4], c0[5], c0[6]};
assign  lvds_tx0_DATA    = {d0[0], d0[1], d0[2], d0[3], d0[4], d0[5], d0[6]};
assign  lvds_tx1_DATA    = {d1[0], d1[1], d1[2], d1[3], d1[4], d1[5], d1[6]};
assign  lvds_tx2_DATA    = {d2[0], d2[1], d2[2], d2[3], d2[4], d2[5], d2[6]};
assign  lvds_tx3_DATA    = {d3[0], d3[1], d3[2], d3[3], d3[4], d3[5], d3[6]};

endmodule