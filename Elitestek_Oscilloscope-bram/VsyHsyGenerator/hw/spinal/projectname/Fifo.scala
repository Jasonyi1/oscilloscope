package projectname

import  spinal.core._

//WAVE_BUF_FIFO xdut_1_to_2_fifo (
//  .a_rst_i            (axi_reset),
//.wr_clk_i           (axi_clk),
//.wr_en_i            (dut_wr_en),
//.wdata              (dut_wr_data),
//.rd_clk_i           (rd_clk),
//.rd_en_i            (dut_rd_en),
//.rdata              (dut_rdata),
//.rd_valid_o         (dut_rd_valid),
//.prog_full_o        (dut_trigger_rd),
//.rst_busy           (dut_rst_busy),
//.full_o             (dut_full_o),
//.empty_o            (dut_empty_o)
//);
class WAVE_BUF_FIFO() extends BlackBox {

  val io = new Bundle {
    val a_rst_i = in Bool()
    val clk_i = in Bool()
    val prog_full_o = out Bool()
    val rst_busy = out Bool()
    val full_o = out Bool()
    val empty_o = out Bool()
    val wdata = in UInt (8 bits)
    val wr_en_i   = in Bool()
    val rd_en_i   = in Bool()
    val rdata = out UInt (8 bits)
    val datacount_o = out UInt(9 bits)
  }

  noIoPrefix()

  mapCurrentClockDomain(clock=io.clk_i, reset=io.a_rst_i)
}
