module src_coefficients_generator(
    output [2:0] int_rate,
    output int_valid,

    output [2:0] dec_rate,
    output dec_valid,

    input clk,
    input rst
);

    reg [5:0] delay;

    always @(posedge clk) begin
        if(rst) begin
            delay <= 6'b1;
        end
        else begin
            if(delay != 0)
                delay <= delay + 1'b1;
            else
                delay <= delay;
        end
    end

    assign int_rate = 1;
    assign dec_rate = 1;

    assign int_valid = (delay == 0) ? 0 : 1;
    assign dec_valid = (delay == 0) ? 0 : 1;
    
endmodule