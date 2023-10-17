module ad_data_recieve
(
	input adc_clk,
	input [1:0]PllLocked,
	input rst,
	input [7:0]DBA,
	input [7:0]DBB,
	input DCO_P,
	input DCO_N,
	output reg pdwn,
	output reg DS,
	output [7:0]data_out
);

reg dba_fifo_wr_en_temp;
reg dbb_fifo_wr_en_temp;
reg dba_fifo_rd_en_temp;
reg dbb_fifo_rd_en_temp;
wire dba_fifo_wr_en;
wire dbb_fifo_wr_en;
wire dba_fifo_full;
wire dbb_fifo_full;
wire dba_fifo_empty;
wire dbb_fifo_empty;
wire dba_fifo_rd_en;
wire dbb_fifo_rd_en;
wire [7:0]dba_fifo_data_output;
wire [7:0]dbb_fifo_data_output;
wire dba_fifo_rst_busy;
wire dbb_fifo_rst_busy;


localparam LOCK_CNT_LEN = 16'hffff;

wire gated_lock;
reg  [15:0] locked_cnt;
reg  gated_lock_temp;

always@(posedge adc_clk)
    if(locked_cnt == LOCK_CNT_LEN)
        gated_lock_temp <= 1'b1;
    else
        gated_lock_temp <= 1'b0;

always@(posedge adc_clk)
    if(locked_cnt == LOCK_CNT_LEN)
        locked_cnt <= locked_cnt;
    else if(PllLocked[0])
        locked_cnt <= locked_cnt + 1'b1;
    else
        locked_cnt <= 0;
assign gated_lock = gated_lock_temp;



always@(posedge adc_clk)begin
	if(~gated_lock)begin
		pdwn <= 1'b1;
		DS <= 1'b1;
	end
	else begin
		pdwn <= 1'b0;
		DS <= 1'b0;
	end
end

// FIFO复位计时
reg fifo_rst;
localparam fifo_rst_cnt_lenth = 16;
reg [3:0]fifo_rst_cnt;

always@(posedge DCO_P or posedge rst)begin
	if(rst)
		fifo_rst <= 1'b1;
	else if(fifo_rst_cnt == fifo_rst_cnt_lenth - 1)
		fifo_rst <= 1'b0;
	else
		fifo_rst <= 1'b1;
end

always@(posedge DCO_P or posedge rst)begin
	if(rst)
		fifo_rst_cnt <= 4'd0;
	else if(fifo_rst_cnt < fifo_rst_cnt_lenth - 1)
		fifo_rst_cnt <= fifo_rst_cnt + 4'd1;
	else
		fifo_rst_cnt <= fifo_rst_cnt;
end

// DBA FIFO读控制
always@(posedge DCO_N or posedge rst)begin
	if(rst)
		dba_fifo_wr_en_temp <= 1'b0;
	else if(fifo_rst_cnt == fifo_rst_cnt_lenth - 1)begin
		if(dba_fifo_rst_busy)
			dba_fifo_wr_en_temp <= 1'b0;
		else
			dba_fifo_wr_en_temp <= 1'b1;
	end
	else
		dba_fifo_wr_en_temp <= 1'b0;
end

assign dba_fifo_wr_en = dba_fifo_wr_en_temp & ~dba_fifo_full;


// DBB FIFO读控制
always@(posedge DCO_P or posedge rst)begin
	if(rst)
		dbb_fifo_wr_en_temp <= 1'b0;
	else if(fifo_rst_cnt == fifo_rst_cnt_lenth - 1)begin
		if(dbb_fifo_rst_busy)
			dbb_fifo_wr_en_temp <= 1'b0;
		else
			dbb_fifo_wr_en_temp <= 1'b1;
	end
	else
		dbb_fifo_wr_en_temp <= 1'b0;
end
assign dbb_fifo_wr_en = dbb_fifo_wr_en_temp & ~dbb_fifo_full;


reg [3:0]rd_cnt;
always@(posedge adc_clk or posedge rst)begin
	if(rst)begin
		rd_cnt <= 4'd0;
	end
	else if(dbb_fifo_rst_busy)
		rd_cnt <= 4'd0;
	else if(rd_cnt < 4'd15)
		rd_cnt <= rd_cnt + 4'd1;
	else
		rd_cnt <= rd_cnt;
end

localparam IDLE = 2'b00;
localparam INIT = 2'b01;
localparam PORT_A_OUT = 2'b10;
localparam PORT_B_OUT = 2'b11;
reg [1:0]state;
reg [7:0]data_out_temp;
assign data_out = data_out_temp;
always@(posedge adc_clk or posedge rst)begin
	if(rst)begin
		data_out_temp <= 8'b00000000;
		dbb_fifo_rd_en_temp <= 1'b0;
		dba_fifo_rd_en_temp <= 1'b0;
		state <= IDLE;
	end
	else begin
		case(state)
			IDLE:
				begin
					if(rd_cnt == 4'd15)begin
						state <= INIT;
						data_out_temp <= 8'b00000000;
						dbb_fifo_rd_en_temp <= 1'b0;	
						dba_fifo_rd_en_temp <= 1'b1;
					end
					else begin
						state <= IDLE;
						data_out_temp <= 8'b00000000;
						dbb_fifo_rd_en_temp <= 1'b0;	
						dba_fifo_rd_en_temp <= 1'b0;
					end
				end
			INIT:
				begin
					data_out_temp <= 8'b00000000;
					dbb_fifo_rd_en_temp <= 1'b1;	
					dba_fifo_rd_en_temp <= 1'b0;
					state <= PORT_A_OUT;
				end
			PORT_A_OUT:
				begin
					data_out_temp <= dba_fifo_data_output;
					dbb_fifo_rd_en_temp <= 1'b0;	
					dba_fifo_rd_en_temp <= 1'b1;
					state <= PORT_B_OUT;
				end
			PORT_B_OUT:
				begin
					data_out_temp <= dbb_fifo_data_output;
					dbb_fifo_rd_en_temp <= 1'b1;	
					dba_fifo_rd_en_temp <= 1'b0;
					state <= PORT_A_OUT;
				end
		endcase
	end
end
assign dba_fifo_rd_en = dba_fifo_rd_en_temp & ~dba_fifo_empty;
assign dbb_fifo_rd_en = dbb_fifo_rd_en_temp & ~dbb_fifo_empty;

ADC_FIFO DBA_FIFO(
.full_o(dba_fifo_full),
.empty_o(dba_fifo_empty),
.wr_clk_i(DCO_N),
.rd_clk_i(adc_clk),
.wr_en_i(dba_fifo_wr_en),
.rd_en_i(dba_fifo_rd_en),
.wdata(DBA),
.wr_datacount_o(),
.rst_busy(dba_fifo_rst_busy),
.rdata(dba_fifo_data_output),
.rd_datacount_o(),
.a_rst_i(fifo_rst)
);


ADC_FIFO DBB_FIFO(
.full_o(dbb_fifo_full),
.empty_o(dbb_fifo_empty),
.wr_clk_i(DCO_P),
.rd_clk_i(adc_clk),
.wr_en_i(dbb_fifo_wr_en),
.rd_en_i(dbb_fifo_rd_en),
.wdata(DBB),
.wr_datacount_o(),
.rst_busy(dbb_fifo_rst_busy),
.rdata(dbb_fifo_data_output),
.rd_datacount_o(),
.a_rst_i(fifo_rst)
);


endmodule