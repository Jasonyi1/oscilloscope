`timescale 1ns/1ps
module tri_ctrl(
    input clk,
    input rst,
    input [7:0] data_in,
    input [7:0] tri_level,
    input change,
    
    output tri_valid,
    output [7:0] data_out
);

    reg [7:0] tri_level_reg;
    reg [7:0] data_reg0;
    reg [7:0] data_reg1;
    reg [7:0] data_reg2;
    reg [7:0] data_reg3;
    reg [7:0] data_reg4;
    reg [7:0] data_reg5;
    reg [7:0] data_reg6;
    reg [7:0] data_reg7;
    reg [7:0] data_reg8;
    reg [7:0] data_reg9;
    
    reg [4:0] tri_valid_reg;
    
    wire tri_sig1;
    wire tri_sig2;
    
    assign tri_sig1 = ( data_reg0 < tri_level_reg )&&( data_reg4 <= tri_level_reg )? 1:0;
    assign tri_sig2 = ( data_reg5 >= tri_level_reg )&&( data_reg9 >= tri_level_reg )? 1:0;
    
    assign data_out = data_reg9;
    always @( posedge clk or posedge rst )
    begin
        if( rst )
            tri_level_reg <= 8'b10000000;
        else if( change )
            tri_level_reg <= tri_level;
    end
    
    always @( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            data_reg0 <= 8'd0;
            data_reg1 <= 8'd0;
            data_reg2 <= 8'd0;
            data_reg3 <= 8'd0;
            data_reg4 <= 8'd0;
            data_reg5 <= 8'd0;
            data_reg6 <= 8'd0;
            data_reg7 <= 8'd0;
            data_reg8 <= 8'd0;
            data_reg9 <= 8'd0;
        end
        else
        begin
            data_reg0 <= data_in;
            data_reg1 <= data_reg0;
            data_reg2 <= data_reg1;
            data_reg3 <= data_reg2;
            data_reg4 <= data_reg3;
            data_reg5 <= data_reg4;
            data_reg6 <= data_reg5;
            data_reg7 <= data_reg6;
            data_reg8 <= data_reg7;
            data_reg9 <= data_reg8;
        end
    end
    
    always @( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            tri_valid_reg <= 0;
        end
        else if( tri_sig1 && tri_sig2 )
        begin
            tri_valid_reg <= 5'b10000;
        end
        else
            tri_valid_reg <= { 1'b0, tri_valid_reg[4:1] };
    end
    
    assign tri_valid = tri_valid_reg[0];
endmodule