`timescale 1ns/1ps
module database
#( parameter WIDTH = 8
	)
    (
    input clk,
    input rst,
    input [( WIDTH - 1 ):0] data_in,
    input data_valid,
    input [13:0] raddr_in,
    input [4:0] rden_in,
    input frame_de,
    input data_output_fire,
    
    output [2:0] state_out, //test
    output src_output_ready,
    output ram_ready,
    output ram_busy,
    output reg [15:0] color_out
    );
    
    assign state_out = ~state;   //test
    //assign ram_ready = ( cnt_wave == 'd255 )?1:0;
    assign ram_ready = ( cnt_wave == 'd1023 )?1:0;
    parameter IDLE = 0;
    parameter DIN = 1;
    parameter DOUT = 2;
    parameter WAIT = 3;
    
    reg [2:0] state;
    
    reg [9:0] cnt_wave;
    reg [13:0] waddr;   //输入ram的写地址
    reg [13:0] raddr_reg;   //ram存数据时的读地址
    wire[13:0] raddr;   //输入ram的读地址
    reg [8:0] col;
    
    reg data_valid_reg;
    reg  [( WIDTH - 1 ):0] data_in_reg;
    
    reg[4:0] we;    //ram写使能
    wire[4:0] re;   //ram读使能
    
    wire [9:0] rdata;
    wire [9:0] rdata0;
    wire [9:0] rdata1;
    wire [9:0] rdata2;
    wire [9:0] rdata3;
    wire [9:0] rdata4;
    reg [9:0] data_tmp;
    reg [9:0] wdata;
    assign src_output_ready = (state == DIN);

    reg wr_en;
    assign ram_busy = wr_en || ( state == DOUT );
    
    always @( posedge clk )
    begin
        we <= re_reg;
    end
    
    reg[4:0] re_reg;    //ram内读使能
    //wire[4:0] re_reg;    //ram内读使能
    
    always @( posedge clk )
    begin
        if( state == DIN )
            case( col[8:6] )
            3'b000: re_reg = 5'b00001;
            3'b001: re_reg = 5'b00010;
            3'b010: re_reg = 5'b00100;
            3'b011: re_reg = 5'b01000;
            3'b100: re_reg = 5'b10000;
            default: re_reg = 5'b00000;
            endcase
        else
            re_reg = 5'b00000;
    end

    reg[3:0] wrefresh_data_en_dly;

    always @( posedge clk or posedge rst )
    begin
        if( rst )
            wrefresh_data_en_dly <= 4'b0;
        else
            wrefresh_data_en_dly <= {wrefresh_data_en_dly[2:0],frame_de};
    end

    
    always @( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            data_in_reg <= 'd0;
            data_valid_reg <= 0;
        end
        else
        begin
            data_in_reg <= data_in;
            data_valid_reg <= data_valid;
        end
    end
    
    always @( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            state <= IDLE;
            waddr <= 14'd0;
            raddr_reg <= 14'd0;
            cnt_wave <= 0;
        end
        else
        case( state )
            IDLE: 
            begin
                wr_en <= 1;
                wdata <= 8'd0;
                raddr_reg <= 14'd0;
                if( waddr == 'h3fff )
                begin
                    waddr <= 14'd0;
                    state <= WAIT;
                end
                else
                    waddr <= waddr + 1;
            end
            DIN:
            begin
                if(data_output_fire) 
                begin
                    wr_en <= 0;
                    col <= col + 1;
                    raddr_reg[13:6] <= ( 8'd255 - data_in_reg );
                    raddr_reg[5:0] <= col[5:0];
                    waddr <= raddr_reg[13:0];
                    wdata <= rdata + 1'b1;
                end
                if( ~data_valid_reg )
                begin
                    state <= WAIT;
                    cnt_wave <= cnt_wave + 1;
                end
            end
            DOUT:
            begin
                wr_en <= 0;
                if(wrefresh_data_en_dly[1:0] == 2'b10)
                    state <= IDLE;
                else
                    state <= DOUT;
            end
            WAIT:
            begin
                wr_en <= 0;
                waddr <= 'd0;
                raddr_reg <= 'd0;
                col <= 9'd0;
                data_tmp <= 'd0;
                wdata <= 8'd0;
                if( ram_ready )
                begin
                    state <= DOUT;
                    cnt_wave <= 0;
                end
                else if( data_valid )
                begin
                    state <= DIN;
                end
             end
      
            default:
            begin
                state <= IDLE;
                wdata <= 0;
                waddr <= 14'd0;
                raddr_reg <= 14'd0;
                cnt_wave <= 0;
            end
        endcase   
    end
    
    
    always @( * )
    begin
        if( state == DOUT )
        begin
            if( rdata == 0)
            begin
                color_out <= 0;
            end
            else if( (rdata[9]) == 1 )
            begin
                color_out <= {5'b11111, 6'b0, rdata[9:5]};
            end
            else if( rdata[8] == 1 )
            begin
                color_out <= {5'b11111, 6'b0, rdata[9:5]};
            end
            else if( rdata[7] == 1 )
            begin
                color_out <= {5'b11111, 6'b0, rdata[9:5]};
            end
            else if( rdata[6] == 1 )
            begin
                color_out <= {5'b11111, 6'b0, rdata[9:5]};;
            end
            else if( rdata[5] == 1 )
            begin
                color_out <= {5'b11111, 6'b0, rdata[9:5]};;
            end
            else if( rdata[4] == 1 )
            begin
                color_out <= {rdata[4:0], 11'b0};
            end
            else if( rdata[3] == 1 )
            begin
                color_out <= {rdata[4:0], 11'b0};
            end
            else 
            begin
                color_out <= 16'h8000;
            end
        end
    end
    
    assign raddr = ( state == DOUT )? raddr_in : raddr_reg;
    //assign raddr = ( state == DOUT )? raddr_in : 8'b0;  //test
    assign re = ( state == DOUT )? rden_in : re_reg;
    //assign re = ( state == DOUT )? rden_in : 8'd0;  //test
    wire [4:0] we_a;
    assign we_a[0] = wr_en || we[0];
    assign we_a[1] = wr_en || we[1];
    assign we_a[2] = wr_en || we[2];
    assign we_a[3] = wr_en || we[3];
    assign we_a[4] = wr_en || we[4];
    
    assign rdata = re[0]?rdata0:( re[1] ?rdata1:( re[2]? rdata2:( re[3]?rdata3: (re[4]?rdata4:5'd0))));
    //assign rdata = rdata0|rdata1|rdata2|rdata3|rdata4;
    simple_dual_port_ram data_ram0(
        //.re( re[0] ),
        .re( 1 ),
        .we( we_a[0] ),
        .waddr( waddr ),
        .wdata( wdata ),
        .rdata ( rdata0 ),
        .raddr ( raddr ),
        .clk ( clk )
    );
    
    simple_dual_port_ram data_ram1(
        //.re( re[1] ),
        .re( 1 ),
        .we( we_a[1] ),
        .waddr( waddr ),
        .wdata( wdata ),
        .rdata ( rdata1 ),
        .raddr ( raddr ),
        .clk ( clk )
    );
    
    simple_dual_port_ram data_ram2(
        //.re( re[2] ),
        .re( 1 ),
        .we( we_a[2] ),
        .waddr( waddr ),
        .wdata( wdata ),
        .rdata ( rdata2 ),
        .raddr ( raddr ),
        .clk ( clk )
    );
    
    simple_dual_port_ram data_ram3(
        //.re( re[3] ),
        .re( 1 ),
        .we( we_a[3] ),
        .waddr( waddr ),
        .wdata( wdata ),
        .rdata ( rdata3 ),
        .raddr ( raddr ),
        .clk ( clk )
    );
    
    simple_dual_port_ram data_ram4(
        //.re( re[4] ),
        .re( 1 ),
        .we( we_a[4] ),
        .waddr( waddr ),
        .wdata( wdata ),
        .rdata( rdata4 ),
        .raddr ( raddr ),
        .clk ( clk )
    );
endmodule