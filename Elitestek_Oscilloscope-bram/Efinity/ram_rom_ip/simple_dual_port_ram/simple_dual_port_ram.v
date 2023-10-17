
module simple_dual_port_ram
#(
	parameter DATA_WIDTH	= 10,
	parameter ADDR_WIDTH	= 14,
	parameter OUTPUT_REG	= "FALSE",
	parameter RAM_INIT_FILE	= "./ram_rom_ip/simple_dual_port_ram/ram_init_file.mem"
)
(
	input [(DATA_WIDTH-1):0] wdata,
	input [(ADDR_WIDTH-1):0] waddr, raddr,
	input we, clk, re,
	output [(DATA_WIDTH-1):0] rdata
);

	localparam MEMORY_DEPTH = 2**ADDR_WIDTH;
	localparam MAX_DATA = (1<<ADDR_WIDTH)-1;
	
	reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
	reg [DATA_WIDTH-1:0] r_rdata_1P;
	reg [DATA_WIDTH-1:0] r_rdata_2P;
	
	integer i;
	initial
	begin
	// By default the Efinix memory will initialize to 0
		if (RAM_INIT_FILE != "")
		begin
			$readmemh(RAM_INIT_FILE, ram);
		end
	end
	
	always @ (posedge clk)
		if (we)
		ram[waddr] <= wdata;
	
	always @ (posedge clk)
	begin
		if (re)
			r_rdata_1P <= ram[raddr];
		r_rdata_2P <= r_rdata_1P;
	end
	
	generate
		if (OUTPUT_REG == "TRUE")
			assign	rdata = r_rdata_2P;
		else
			assign	rdata = r_rdata_1P;
	endgenerate

endmodule

