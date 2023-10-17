`timescale 1ns/1ps

//----------------------------------------------------------------
//波形输入FIFO
module fifo_data_recv
(
    input wr_clk,
    input rd_clk,
    input rst,
    input [7:0] fifo_data_in,
    input valid,
    
    input ram_ready,

    input trigger,
    
    input out_ready,
    input src_output_valid,
    input src_output_ready,

    input [2:0] dec_rate,
    output data_valid,
    output empty_o,
    output full_o,
    //output reg rd_en,
    output [7:0] fifo_data_out
    // output [3:0] fifo_state_out
);
    localparam FIFO_DEPTH = 300;

    parameter IDLE = 0;
    parameter READY = 1;
    parameter WRITE = 2;
    parameter WAIT = 3;
    parameter READ = 4;
    parameter DONE = 5;

    reg [2:0] state;

    wire rst_busy;
    
    reg wr_en;
    reg rd_en;
    assign data_valid = ( state == READ && read_cnt < 'd300)? 1:0;

    reg [11:0] read_cnt;
    always @( posedge rd_clk or posedge rst )
    begin
        if( rst )
            read_cnt <= 0;
        else
        begin
            if(state == READ && (~(src_output_valid | src_output_ready) || src_output_valid))
                read_cnt <= read_cnt + 1;
            else
                read_cnt <= 0;
        end
    end

    reg [2:0] decimate_cnt_r;
    always @(posedge wr_clk or posedge rst)
    begin
        if( rst )
            decimate_cnt_r <= 0;
        else
        begin
            if(decimate_cnt_r == dec_rate)
                decimate_cnt_r <= 0;
            else if( state == WRITE )
                decimate_cnt_r <= decimate_cnt_r + 1;
            else
                decimate_cnt_r <= 0;
        end
    end

    //assign data_valid = rd_en;
    // assign fifo_state_out = state;
    always @( posedge wr_clk or posedge rst )
    begin
        if( rst )
            state <= IDLE;
        else
        case( state )
        IDLE:
            if( ~rst_busy )
                state <= READY;
        READY:
            if( trigger )
                state <= WRITE;
        WRITE:
            if( full_o )
                state <= WAIT;
        WAIT:
            if( valid )
                state <= READ;
        READ:
            if( read_cnt > 'd300 )
                state <= READY;
        default: state <= IDLE;
        endcase
    end
    
    reg fifo_rst_r;
    wire fifo_rst = rst | fifo_rst_r;
    always @( posedge wr_clk or posedge rst )
    begin
        if( rst )
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        else
        case( state )
        IDLE:
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        READY:
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        WRITE:
        begin
            wr_en <= decimate_cnt_r == dec_rate;
            rd_en <= 0;
        end
        WAIT:
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        READ:
        begin
            wr_en <= 0;
            rd_en <= out_ready ;
            
        end
        DONE:
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        default:
        begin
            wr_en <= 0;
            rd_en <= 0;
        end
        endcase
    end
    wire [7:0] fifo_data_out;

    //reg wr_en;

    always @(posedge rd_clk or posedge rst) begin
        if( rst )
            fifo_rst_r <= 0;
        else begin
            if(read_cnt >= 'd300)
                fifo_rst_r <= 1;
            else
                fifo_rst_r <= 0;
        end
    end
    
    reg [9:0] fifo_wr_datacount_out;
    wire [9:0] fifo_data_remain;
    always @(posedge wr_clk or posedge rst) begin
        if( rst )
            fifo_wr_datacount_out <= 10'b0;
        else
            fifo_wr_datacount_out <= fifo_data_remain;
    end

    WAVE_BUF_FIFO u_WAVE_BUF_FIFO(
    .full_o ( full_o ),
    .empty_o ( empty_o ),
    .wr_clk_i ( wr_clk ),
    .rd_clk_i ( rd_clk ),
    .wr_en_i ( wr_en ),
    .rd_en_i ( rd_en ),
    .wdata ( fifo_data_in ),
    .rd_datacount_o (  ),
    .wr_datacount_o ( fifo_data_remain ),
    .rst_busy (rst_busy),
    .rdata ( fifo_data_out ),
    .a_rst_i ( fifo_rst )
    );

endmodule