package projectname

import spinal.core._
import spinal.lib._
case class AddressGen(width : Int, height : Int) extends Component {
  val ram = new Bundle{
    val en = in Bool()
    val x = in UInt(10 bits)
    val y = in UInt(10 bits)
    val addr = out UInt(14 bits)
  }

  ram.addr := (ram.en) ? ((255 - ram.y).resize(8) ## ram.x.resize(6)).asUInt | (U"0").resized
}

case class RAddressGen(width : Int, height : Int) extends Component {
  val ram = new Bundle{
    val en = out Bits(5 bits)
    val x = in UInt(10 bits)
    val y = in UInt(10 bits)
    val addr = out UInt(14 bits)
  }

  val filmSel = ram.x(8) ## ram.x(7) ## ram.x(6)

  val en = Reg(Bits(5 bits)) init 0
  switch(filmSel.asUInt){
    is(0){
      en := B"5'B00001"
    }
    is(1){
      en := B"5'B00010"
    }
    is(2){
      en := B"5'B00100"
    }
    is(3){
      en := B"5'B01000"
    }
    default{
      en := B"5'B10000"
    }
  }
//  en := (filmSel.asUInt === 0) ? B"5'B00001" |
//    ((filmSel.asUInt === 1) ? B"5'B00010" |
//      ((filmSel.asUInt === 2) ? B"5'B00100" |
//        ((filmSel.asUInt === 3) ? B"5'B01000" | B"5'B10000")))
  ram.en := en

  ram.addr := (ram.en.orR) ? (ram.y.resize(8) ## ram.x.resize(6)).asUInt | (U"0").resized
}
object RotateVerilog extends App {
  Config.spinal.generateVerilog(AddressGen(1024, 600))
}
