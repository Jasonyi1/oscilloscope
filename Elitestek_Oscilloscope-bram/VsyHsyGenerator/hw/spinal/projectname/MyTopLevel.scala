package projectname

import spinal.lib._
import spinal.core._


// Hardware definition
case class VsyHsyGenerator(width : Int, height : Int) extends Component {
  val io = new Bundle {
    val de = out  Bool()
    val color = out UInt (16 bits)
    val nextFrame = in Bool()
  }
  val ram = new Bundle {
    val addr = out UInt(14 bits)
    val color = in UInt(16 bits)
    val en = out Bits(5 bits)
  }

  val hCnt = Counter(height + 1)
  val pCnt = Counter(width)

  val frameInterval = Reg(Bool()) init True
  io.de := False
  when(!frameInterval){
    io.de := True
    pCnt.increment()
  }

  when(pCnt.willOverflow){
    hCnt.increment()
    pCnt.clear()
  }
  when(hCnt.willOverflow){
    frameInterval := True
    hCnt.clear()
  }

  when(frameInterval) {
    when(io.nextFrame) {
      frameInterval := False
    }
  }

//  io.color := pCnt.resized
  val picture = PictureGenerator()
  picture.coordinate.y <> hCnt
  picture.coordinate.x <> pCnt
  picture.color.rgb <> io.color
  picture.ram.en <> ram.en
  picture.ram.color <> ram.color
  picture.ram.addr <> ram.addr


}

object MyTopLevelVerilog extends App {
  Config.spinal.generateVerilog(VsyHsyGenerator(1024, 600))
}

