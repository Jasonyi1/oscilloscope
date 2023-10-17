package projectname

import spinal.lib._
import spinal.core._

import Math._
import scala.util.Random
case class DdsModule(interval : Int) extends Component{
  val io = new Bundle{
    val signalOut = out SInt(8 bits)
  }
//  val inc = CounterFreeRun(2)
  val noise1 = CounterFreeRun(3)
  val noise3 = CounterFreeRun(4)
  io.signalOut.setAsReg().init(0)
//  io.signalOut := 128
  val inc = CounterFreeRun(1024 / interval)
  val sinFunc = Vec(SInt(8 bits), 1024 / interval)
  for(i <- 0 until 1024 / interval){
//    if(i > 512 / interval){
//      sinFunc(i) := 127
//    }else{
//      sinFunc(i) := -128
//    }
//    if(i < 512 / interval){
      sinFunc(i) := (((sin(i * interval / 512.0 * PI)) * 64.0)).toInt + (random() * 3).toInt
//    }else if(i < 512 / interval + 256 / interval){
//      sinFunc(i) := 64 + (random() * 3).toInt
//    }else{
//      sinFunc(i) := -64 + (random() * 3).toInt
//    }
  }
  io.signalOut := sinFunc((inc).resized) + noise1.value.asSInt - noise3.value.asSInt//noise.value.asSIntsinFunc((inc))//
}

object DdsVerilog extends App {
  Config.spinal.generateVerilog(DdsModule(11))
}