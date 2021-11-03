package liontiger.gcj2014.qualification

import liontiger.common.AbstractProblem

import scala.annotation.tailrec

object ProblemB extends AbstractProblem("2014/qualification/b.txt") {
  /**
   * Reads input for a single test case and returns solution string.
   */
  override def solve(): String = {
    val in = readLine().split(" ").map(_.toDouble).toList
    val (c, f, x) = (in(0), in(1), in(2))

    @tailrec
    def run(init: Double, s: Double): Double = {
      val est1 = x / s
      val est2 = c / s + x / (s+f)
      if (est1 < est2) {
        init + est1
      } else {
        run(init + c / s, s + f)
      }
    }

    run(0, 2).toString

  }
}
