package projectname

import spinal.core._
import spinal.core.sim._

object MyTopLevelSim extends App {
  Config.sim.withWave.compile(RAddressGen(3,3)).doSim { dut =>
    // Fork a process to generate the reset and the clock on the dut
    dut.clockDomain.forkStimulus(period = 20)

    for (idx <- 0 to 100) {
      dut.ram.x #= idx * 10
      dut.ram.y #= 128
      // Wait a rising edge on the clock
      dut.clockDomain.waitRisingEdge()
    }
  }
}
