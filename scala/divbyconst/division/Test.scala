package division

/**
  * @author liontiger
  */
object Test extends App with ImmutableMagicComputation {

  val stime = System.currentTimeMillis()

  for (d <- List(3, 5, 6, 7, 9, 10, 11, 12)) {
    val (m, s) = computeMagicInt(d)
    printf("%d:\t%X\t%d\n", d, m, s)
  }

  println()
  println(System.currentTimeMillis() - stime)
}
