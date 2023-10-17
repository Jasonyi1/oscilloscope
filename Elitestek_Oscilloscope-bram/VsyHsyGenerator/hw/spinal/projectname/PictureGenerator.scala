package projectname

import spinal.core._
import spinal.lib._
case class PictureGenerator() extends Component{
  val coordinate = new Bundle {
    val x = in UInt(10 bits)
    val y = in UInt(10 bits)
  }
  val color = new Bundle {
    val rgb = out UInt (16 bits)
  }

  val rAddr = RAddressGen(1024, 600)

  val ram = new Bundle {
    val color = in UInt(16 bits)
    val addr = out UInt (14 bits)
    val en = out Bits(5 bits)
  }

  val colorInRam = Reg(UInt(16 bits)) init 0
  colorInRam := ram.color
  val currYDiv = UInt(10 bits)
  val currXDiv = UInt(10 bits)
  currXDiv := (coordinate.x.asBits |>> 1).asUInt
  currYDiv := (coordinate.y.asBits |>> 1).asUInt

  val xLeft = 104
  val xRight = xLeft + 299
  val yTop = 40
  val yBottom = yTop + 256


  val yMiddle = (yTop + yBottom) / 2
  val xMiddle = (xLeft + xRight) / 2

  //  var picture : Array[Array[Int]]= Array.ofDim[Int](1024, 600)
  //  picture.foreach(x => 0)
  //  for(x <- 0 until 1024){
  //    for(y <- 0 until 600){
  //      picture(x)(y) = 0
  //      if((y == yTop || y == yBottom) && x >= xLeft && x <= xRight){
  //        picture(x)(y) = 0xffff
  //      }
  //    }
  //  }
  val font = Array[Array[Int]](
    Array(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x0C, 0x7F, 0xFC, 0x04, 0x40, 0x08, 0x04, 0x40, 0x08, 0x00, 0x40, 0x08, 0x41, 0x5F, 0xE8, 0x31, 0x40, 0x08, 0x12, 0x40, 0x08, 0x12, 0x4F, 0xC8, 0x02, 0x48, 0x48, 0x04, 0x48, 0x48, 0x04, 0x48, 0x48, 0x08, 0x48, 0x48, 0x08, 0x4F, 0xC8, 0x38, 0x48, 0x48, 0x18, 0x48, 0x08, 0x18, 0x40, 0x08, 0x18, 0x40, 0x08, 0x18, 0x40, 0x08, 0x00, 0x40, 0x38, 0x00, 0x40, 0x18, 0x00, 0x00, 0x00), /*"洞",0*/
    Array(0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, 0x00, 0x0F, 0xFF, 0xFC, 0x11, 0x00, 0x08, 0x33, 0x04, 0x10, 0x03, 0xFF, 0xF8, 0x04, 0x32, 0x10, 0x0F, 0x22, 0x20, 0x09, 0x41, 0x40, 0x19, 0xC3, 0x80, 0x24, 0xFF, 0xC0, 0x07, 0x00, 0x70, 0x04, 0x00, 0x5E, 0x1F, 0xFF, 0xE8, 0x20, 0x18, 0x10, 0x01, 0x99, 0x00, 0x03, 0x18, 0x80, 0x06, 0x18, 0x60, 0x08, 0x18, 0x30, 0x10, 0x78, 0x10, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00), /*"察",1*/
    Array(0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x03, 0xF8, 0x3F, 0x7C, 0x00, 0x22, 0x20, 0x10, 0x22, 0x32, 0x30, 0x22, 0x13, 0x20, 0x22, 0x12, 0x40, 0x3E, 0x7F, 0xFC, 0x22, 0x40, 0x0C, 0x22, 0xF0, 0x38, 0x22, 0x20, 0x28, 0x22, 0x3F, 0xFC, 0x3E, 0x4D, 0x20, 0x22, 0x89, 0x20, 0x23, 0xEB, 0x20, 0x22, 0x33, 0xFC, 0x22, 0x10, 0x20, 0x3E, 0x20, 0x20, 0x22, 0x40, 0x20, 0x20, 0x80, 0x20, 0x23, 0x00, 0x20, 0x04, 0x00, 0x20, 0x00, 0x00, 0x00), /*"瞬",2*/
    Array(0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x20, 0x00, 0x03, 0xFF, 0xE0, 0x02, 0x00, 0x40, 0x02, 0x00, 0x40, 0x03, 0xFF, 0xC0, 0x02, 0x00, 0x40, 0x02, 0x00, 0x40, 0x03, 0xFF, 0xC0, 0x02, 0x00, 0x40, 0x02, 0x00, 0x40, 0x03, 0xFF, 0xE0, 0x02, 0x20, 0x40, 0x00, 0x10, 0x00, 0x01, 0x18, 0x00, 0x09, 0x8C, 0x10, 0x09, 0x8C, 0x08, 0x09, 0x80, 0x4C, 0x19, 0x80, 0x44, 0x38, 0x80, 0xC4, 0x00, 0xFF, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00), /*"息",3*/
    Array(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x1F, 0xC3, 0x00, 0x10, 0xC3, 0x00, 0x10, 0x83, 0x00, 0x10, 0x83, 0x00, 0x11, 0x03, 0x00, 0x11, 0x03, 0x00, 0x12, 0x03, 0x00, 0x12, 0x02, 0x80, 0x11, 0x02, 0x80, 0x10, 0x86, 0x80, 0x10, 0xC4, 0x80, 0x10, 0x44, 0x80, 0x10, 0x44, 0x40, 0x10, 0x48, 0x40, 0x17, 0xC8, 0x60, 0x11, 0x90, 0x20, 0x10, 0x30, 0x30, 0x10, 0x60, 0x18, 0x10, 0x80, 0x0E, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00) /*"队",4*/
  )

  val fontVec = Vec(Vec(UInt(8 bits), font.flatten.length / font.length), font.length)


  print(font.flatten.length / font.length)
  for (i <- 0 until font.length) {
    for (j <- 0 until font.flatten.length / font.length) {
      fontVec(i)(j) := font(i)(j)
    }
  }

  def ShowFont(str: Int, curr_x: UInt, curr_y: UInt, x: Int, y: Int): Bool = {
    val temp = UInt(8 bits)
    val fontIndex = UInt(8 bits)
    val x_t = UInt(12 bits)
    val y_t = UInt(12 bits)
    val result = Bool()
    val nextRow = Bool()
    nextRow := False
    x_t := x
    y_t := y
    fontIndex := (7 - curr_x + x_t).resized
    temp := fontVec(str)((curr_y + curr_y + curr_y - y_t - y_t - y_t).resized)
    when(curr_x > x_t + 15) {
      fontIndex := (23 - curr_x + x_t).resized
      temp := fontVec(str)((2 + (curr_y + curr_y + curr_y - y_t - y_t - y_t)).resized)
    } elsewhen (curr_x > x_t + 7) {
      fontIndex := (15 - curr_x + x_t).resized
      temp := fontVec(str)((1 + (curr_y + curr_y + curr_y - y_t - y_t - y_t)).resized)
    }

    val currInRegion = curr_x >= x_t && curr_y >= y_t && curr_x < x_t + 24 && curr_y < y_t + 24
    when(currInRegion) {
      result := temp(fontIndex.resized)
    } otherwise {
      result := False
    }
    result
  }

  color.rgb := U"16'h0000" //+ dynamicCnt

  when(currYDiv > yTop - 1 && currYDiv < yBottom + 1 && currXDiv === xMiddle) {
    color.rgb := U"16'h6B4D"
  }
  for(i <- 1 until 11){
    for(j <- 1 until 64){
      when(currYDiv === yTop + j * 4 && currXDiv === xLeft - 1 + i * 30){
        color.rgb := U"16'h6B4D"
      }
    }
  }

  for (i <- 1 until 75) {
    for (j <- 1 until 8) {
      when(currYDiv === yTop + j * 32 && currXDiv === xLeft - 1 + i * 4) {
        color.rgb := U"16'h6B4D"
      }
    }
  }
  when((currYDiv === yTop - 1 || currYDiv === yBottom + 1) && currXDiv >= xLeft + 1 && currXDiv <= xRight) {
    color.rgb := U"16'hffff"
  }.elsewhen((currYDiv >= yTop - 1 && currYDiv <= yBottom + 1) && (currXDiv === xLeft + 1 || currXDiv === xRight)) {
    color.rgb := U"16'hffff"
  }.elsewhen(currXDiv > xLeft - 1 && currXDiv < xLeft + 299 && currYDiv > yTop - 1 && currYDiv < yTop + 256 && colorInRam > 0) {
    color.rgb := colorInRam
  }.elsewhen(currYDiv === yMiddle && currXDiv > xLeft && currXDiv <= xRight) {
    color.rgb := U"16'h6B4D"
  }


  rAddr.ram.addr <> ram.addr
  rAddr.ram.x := 0
  rAddr.ram.y := 0
  ram.en := rAddr.ram.en
  when(currXDiv > xLeft - 1 && currXDiv < xLeft + 300 && currYDiv > yTop - 1 && currYDiv < yTop + 256){
    rAddr.ram.x := currXDiv - xLeft
    rAddr.ram.y := currYDiv - yTop
  }otherwise {
    ram.en := 0
  }

  for(i <- 0 until font.length){
    when(ShowFont(i, coordinate.x, coordinate.y, i * 24 + 410, 15)){
      color.rgb := U"16'hffff"
    }
  }

}
