`timescale 1ns/1ps

//----------------------------------------------------------------
//波形输入FIFO
module ram_data
(
    input clk,
    input rst,

    input [7:0] fifo_data,//FIFO的数据
    input fifo_rd_en,//fifo读使能
    input [9:0] fifo_data_remain,//fifo数据量
    input fifo_data_finished,//FIFO数据读取完毕

    input [13:0] lcd_ram_addr,//输入的RAM地址用于LCD刷屏
    input [4:0] lcd_ram_en,//输入的RAM片选用于LCD刷屏
    input lcd_refreshing,//输入的lcd刷新信号，拉高开始刷新

    output [15:0] ram_data_o,
    output [2:0] ram_state,
    output new_frame,
    output ram_ready
);
    localparam FIFO_DEPTH = 300;
    //----------------------------------------------------------------
    //状态机
    localparam S_IDLE         = 3'd0; //初始状态
    localparam S_RAM_REFRESH  = 3'd1; //RAM清零
    localparam S_READ_FIFO    = 3'd2; //读FIFO数据 写RAM
    localparam S_LCD_REFRESH  = 3'd3; //LCD刷新

    assign new_frame = fifo_data_finished;
    reg             [2:0]           state;
    assign ram_state = state;
    always @(posedge clk)
    begin
        if(rst == 1'b0)
            state <= S_IDLE;
        else
        begin
            case(state)
                S_IDLE : 
                begin
                    state <= S_RAM_REFRESH;
                end
                S_RAM_REFRESH : 
                begin
                    if((ram_refresh_addr + 1'b1== 17'h14000))
                        state <= S_READ_FIFO;
                    else
                        state <= S_RAM_REFRESH;
                end
                S_READ_FIFO : 
                begin
                    if(fifo_data_finished)
                        state <= S_LCD_REFRESH;
                    else
                        state <= S_READ_FIFO;
                end
                S_LCD_REFRESH : 
                begin
                    if(wrefresh_data_en_dly[1:0] == 2'b10)
                        state <= S_RAM_REFRESH;
                    else
                        state <= S_LCD_REFRESH;
                end
                default : 
                begin
                    state <= S_IDLE;
                end
            endcase
        end
    end

    assign ram_ready = state == S_LCD_REFRESH;
    //----------------------------------------------------------------
    //写片选信号生成
    //包括刷屏和非刷屏
    wire [9:0] ram_x_in = FIFO_DEPTH - fifo_data_remain;
    wire [9:0] ram_x_forward = ram_x_in + 1'b1; //当前地址的下一个地址
    wire [16:0] ram_refresh_addr_forward = ram_refresh_addr + 1'b1;  //当前地址的下一个地址
    reg [4:0] film_selection;

    always @(posedge clk) begin
    if(rst == 1'b0)
            film_selection <= 5'b00000;
        else
        begin
        if(state == S_READ_FIFO)
        begin
            case(ram_x_forward[8:6])
                3'b000 : film_selection <= 5'b00001;
                3'b001 : film_selection <= 5'b00010;
                3'b010 : film_selection <= 5'b00100;
                3'b011 : film_selection <= 5'b01000;
                3'b100 : film_selection <= 5'b10000;
                default : film_selection <= 5'b00000;
            endcase
        end
        else if(state == S_RAM_REFRESH)
        begin
            case(ram_refresh_addr_forward[16:14])
                3'b000 : film_selection <= 5'b00001;
                3'b001 : film_selection <= 5'b00010;
                3'b010 : film_selection <= 5'b00100;
                3'b011 : film_selection <= 5'b01000;
                3'b100 : film_selection <= 5'b10000;
                default : film_selection <= 5'b00000;
            endcase
        end
        else
            film_selection <= film_selection;
        end
    end

    wire [4:0] ram_we;
    assign ram_we = ((fifo_rd_en == 1'b1 && fifo_data_remain > 10'd0) ||
                      state == S_RAM_REFRESH) ? film_selection : 5'b0;
    // always @(posedge clk) begin
    // if(~rst)
    //     ram_we <= 5'b0;
    // else
    // begin
    //     if((fifo_rd_en == 1'b1 && fifo_data_remain > 10'd0) || state == S_RAM_REFRESH)
    //     ram_we <= film_selection;
    //     else
    //     ram_we <= 5'b0;
    // end
    // end





    //-----------------------------------------------------------------
    //刷新信号产生
    reg             [3:0]           wrefresh_data_en_dly;

    always @(posedge clk)
    begin
        if(rst == 1'b0)
        wrefresh_data_en_dly <= 4'b0;
        else
        wrefresh_data_en_dly <= {wrefresh_data_en_dly[2:0],lcd_refreshing};
    end


    //-----------------------------------------------------------------
    //刷新地址产生
    reg  [16:0] ram_refresh_addr;

    always @(posedge clk) begin
    if(rst == 1'b0)
        ram_refresh_addr <= 4'b0;
    else
    begin
        if(state == S_RAM_REFRESH)
        ram_refresh_addr <= ram_refresh_addr + 1;
        else
        ram_refresh_addr <= 0;
    end
    end

    //-----------------------------------------------------------------
    wire [13:0] ram_waddr = (|ram_we) ? ((state == S_RAM_REFRESH) ? ram_refresh_addr[13:0] : {(fifo_data), ram_x_in[5:0]}) : 14'b0;
    // reg [13:0] ram_waddr;
    // always @(posedge clk) begin
    //     if(rst == 1'b0)
    //         ram_waddr <= 14'b0;
    //     else begin
    //         if(!ram_we) begin
    //             if(state == S_RAM_REFRESH)
    //                 ram_waddr <= ram_refresh_addr[13:0];
    //             else
    //                 ram_waddr <= {(fifo_data), ram_x_in[5:0]};
    //         end
    //         else
    //             ram_waddr <= 14'b0;
    //     end
    // end
    //-----------------------------------------------------------------
    //RAM定义与读写
    wire [4:0] ram_re = lcd_ram_en;
    wire [15:0] ram_wdata_a = (state == S_RAM_REFRESH) ? 1'b0 : 1'b1;
    wire [13:0] ram_raddr = lcd_ram_addr;
    wire ram_re_1 = 1'b1;
    wire [15:0] ram_rdata_0;
    wire [15:0] ram_rdata_1;
    wire [15:0] ram_rdata_2;
    wire [15:0] ram_rdata_3;
    wire [15:0] ram_rdata_4;
    wire w_data = 1'b1;
    WAVE_MAPPING_RAM u_WAVE_MAPPING_RAM0(
    .re ( ram_re_1 ),
    .we ( ram_we[0] ),
    .waddr ( ram_waddr ),
    .wdata_a ( ram_wdata_a ),
    .rdata_b ( ram_rdata_0 ),
    .raddr ( ram_raddr ),
    .clk ( clk )
    );
    
    WAVE_MAPPING_RAM u_WAVE_MAPPING_RAM1(
    .re ( ram_re_1 ),
    .we ( ram_we[1] ),
    .waddr ( ram_waddr ),
    .wdata_a ( ram_wdata_a ),
    .rdata_b (ram_rdata_1),
    .raddr ( ram_raddr ),
    .clk ( clk )
    );

    WAVE_MAPPING_RAM u_WAVE_MAPPING_RAM2(
    .re ( ram_re_1 ),
    .we ( ram_we[2] ),
    .waddr ( ram_waddr ),
    .wdata_a ( ram_wdata_a ),
    .rdata_b (ram_rdata_2),
    .raddr ( ram_raddr ),
    .clk ( clk )
    );

    WAVE_MAPPING_RAM u_WAVE_MAPPING_RAM3(
    .re ( ram_re_1 ),
    .we ( ram_we[3] ),
    .waddr ( ram_waddr ),
    .wdata_a ( ram_wdata_a ),
    .rdata_b (ram_rdata_3),
    .raddr ( ram_raddr ),
    .clk ( clk )
    );

    WAVE_MAPPING_RAM u_WAVE_MAPPING_RAM4(
    .re ( ram_re_1 ),
    .we ( ram_we[4] ),
    .waddr ( ram_waddr ),
    .wdata_a ( ram_wdata_a ),
    .rdata_b (ram_rdata_4),
    .raddr ( ram_raddr ),
    .clk ( clk )
    );

    //----------------------------------------------------------------------
    //图像读片选
    assign _zz_ram_rdata_3 = ram_re == 5'b01000 ? ram_rdata_3 : ram_rdata_4;
    assign _zz_ram_rdata_2 = ram_re == 5'b00100 ? ram_rdata_2 : _zz_ram_rdata_3;
    assign _zz_ram_rdata_1 = ram_re == 5'b00010 ? ram_rdata_1 : _zz_ram_rdata_2;
    assign _zz_ram_rdata_0 = ram_re == 5'b00001 ? ram_rdata_0 : _zz_ram_rdata_1;
    assign ram_data_o = _zz_ram_rdata_0;
endmodule