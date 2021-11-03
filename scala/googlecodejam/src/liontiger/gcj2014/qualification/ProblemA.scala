package liontiger.gcj2014.qualification

import liontiger.common.AbstractProblem

import scala.collection.mutable

object ProblemA extends AbstractProblem("2014/qualification/a.txt") {
  /**
   * Reads input for a single test case and returns solution string.
   */
  override def solve(): String = {

    val cards1 = mutable.Set.empty[Int]

    val choice1 = readInt()
    for (i <- 1 to 4) {
      val in = readLine().split(" ").map(_.toInt)
      if (i == choice1) {
        cards1 ++= in
      }
    }

    val cards2 = mutable.Set.empty[Int]

    val choice2 = readInt()
    for (i <- 1 to 4) {
      val in = readLine().split(" ").map(_.toInt)
      if (i == choice2) {
        cards2 ++= in
      }
    }

    val common = cards1.intersect(cards2)

    if (common.isEmpty) {
      "Volunteer cheated!"
    } else if (common.size != 1) {
      "Bad magician!"
    } else {
      common.head.toString
    }
  }
}
