// Generator : SpinalHDL v1.9.3    git head : 029104c77a54c53f1edda327a3bea333f7d65fd9
// Component : AddressGen
// Git hash  : f47ac2f65f5129dfc407dff37475ce9eae5c0e22

`timescale 1ns/1ps

module AddressGen (
  input               ram_en,
  input      [9:0]    ram_x,
  input      [9:0]    ram_y,
  output reg [13:0]   ram_addr
);

  wire       [16:0]   _zz_ram_addr;
  wire       [16:0]   _zz_ram_addr_1;
  wire       [16:0]   _zz_ram_addr_2;

  assign _zz_ram_addr = (_zz_ram_addr_1 + _zz_ram_addr_2);
  assign _zz_ram_addr_1 = (ram_y * 7'h40);
  assign _zz_ram_addr_2 = {7'd0, ram_x};
  always @(*) begin
    ram_addr = 14'h0000;
    if(ram_en) begin
      ram_addr = _zz_ram_addr[13:0];
    end
  end


endmodule
