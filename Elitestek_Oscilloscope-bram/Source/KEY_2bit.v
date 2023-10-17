/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )  
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@qq.com
Filename			:		KEY_2bit_Test.v
Date				:		2022-02-08
Description			:		Basic KEY Test design.
Modification History	:
Date			By			Version			Change Description
=========================================================================
22/02/08		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module KEY_2bit
(
	//global clock
	input				clk,            
	input				rst_n,


    //key interface
    input   [1:0]       key_data,
    
	output       		src_req,
	output  reg [1:0]	src_coef_idx,
	output 	reg [2:0]	dec_rate
);


//----------------------------------
//Key scan with counter detect
wire			key_flag;
wire	[1:0]	key_value;
key_counter_scan		
#(
	.KEY_WIDTH	(2)
)
u_key_counter_scan
(
	//global
	.clk				(clk),
	.rst_n				(rst_n),
	
	//key interface
	.key_data			(key_data),		
	
	//user interface
	.key_flag			(key_flag),
	.key_value			(key_value)	
);
reg	[1:0]	key_value_r;
reg [1:0]	dec_rate_state;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
    	src_coef_idx <= 2'b01;
		dec_rate <= 3'b0;
		dec_rate_state <= 2'b0;
	end
    else
	begin
		if(key_flag & key_value[1])
			src_coef_idx <= src_coef_idx + 1;
		else
			src_coef_idx <= src_coef_idx;

		if(key_flag & key_value[0])
			dec_rate_state <= dec_rate_state + 1;
		else
			dec_rate_state <= dec_rate_state;

		case(dec_rate_state)
			2'b00 : dec_rate <= 0;
			2'b01 : dec_rate <= 3'b1;
			2'b10 : dec_rate <= 3'b10;
			default : dec_rate <= 3'd4;
		endcase
	end
end
assign	src_req = (key_flag & key_value[1]) ? 1'b1 : 1'b0;


endmodule


