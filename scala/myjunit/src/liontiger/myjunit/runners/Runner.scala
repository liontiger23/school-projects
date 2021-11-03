package liontiger.myjunit.runners

/**
  * @author liontiger
  */
object Runner extends App {
  if (args.length == 0) sys.exit()

  private val threadsCount = args(0).toInt

  @volatile
  var world = args match {
    case Array(_, classes @ _*) => new RunnersWorld(threadsCount, classes: _*)
  }

  for (i <- 1 to threadsCount) {
    new Thread(new ClassRunner(i, world)).start()
  }

  world.print()
}
