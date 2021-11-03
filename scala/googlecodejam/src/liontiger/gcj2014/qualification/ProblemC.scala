package liontiger.gcj2014.qualification

import liontiger.common.AbstractProblem

import scala.annotation.tailrec

object ProblemC extends AbstractProblem("2014/qualification/c.txt") {
  /**
   * Reads input for a single test case and returns solution string.
   */
  override def solve(): String = {
    val in = readLine().split(" ").map(_.toInt).toList
    val (r, c, m) = (in(0), in(1), in(2))

    def isPossible = (m % r, m / r + 1) match {
      case (0, 1) => true
      case (x, y) if x < r - 1 && y < c - 1 => true
      case (x, y) if x == r - 1 && y == c => true
      case (x, y) if x == 0 && y == c - 1 => true
      case _ => false
    }

    if (isPossible) {
      val res = StringBuilder.newBuilder
      for (i <- 1 to r) {
        res.append("\n")
        for (j <- 1 to c) {
          if (i == r && j == c) {
            res.append("c")
          } else {
            if (j < m / r + 1) {
              res.append("*")
            } else if (j == m / r + 1) {
              if (i <= m % r) {
                res.append("*")
              } else {
                res.append(".")
              }
            } else {
              res.append(".")
            }
          }
        }
      }

      res.toString()
    } else {
      "\nImpossible"
    }
  }
}
