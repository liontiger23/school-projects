package liontiger.myjunit.runners

import liontiger.myjunit.reporting.{DebugOptions, ClassTester}

/**
  * @author liontiger
  */
class ClassRunner(id: Int, world: RunnersWorld) extends Runnable {

  override def run(): Unit = {
    while (world.classQueue.nonEmpty) {
      world.dequeueClass() match {
        case Some(className) =>
          runnerMsg(s"Testing class $className\n")
          val report = new ClassTester(className).test()
          assert(report != null)
          world.reportsQueue.synchronized {
            world.reportsQueue += report
          }
        case None =>
      }
    }
    runnerMsg("All tasks done")
    world.runnersCount -= 1
  }

  private def runnerMsg(msg: String) = {
    if (DebugOptions.verboseRunners) {
      println(s"\n[RUNNER #$id] $msg")
    }
  }
}
