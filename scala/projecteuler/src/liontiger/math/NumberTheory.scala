package liontiger.math

import liontiger.math.Conversions._
import liontiger.math.Sequences._

import scala.annotation.tailrec

trait NumberTheory {

  /**
   * Generates all pythagorean triples for given perimeter
   * @param p - perimeter (p = a + b + c)
   */
  protected def pythagoreanTriples(p: BigInt): List[(BigInt, BigInt, BigInt)] = {
    def isValidParameter(a: BigInt): Boolean = (p / 2) * (p - 2 * a) % (p - a) isZero
    def triple(a: BigInt): (BigInt, BigInt, BigInt) = {
      val b = (p / 2) * (p - 2 * a) / (p - a)
      val c = p - (a + b)
      (a, b, c)
    }

    p match {
      case _ if p.odd => Nil
      case _ => naturals.takeWhile(_ < p).toList.filter(isValidParameter).map(triple).distinct
    }
  }

}
