package division

import scala.annotation.tailrec

/**
  * @author liontiger
  */
trait ImmutableMagicComputation {
  class Modular(val d: Long, val q: Long, val r: Long) {
    assert(d > 0 && q > 0 && r > 0)

    def x2 = {
      if (r * 2 > d) {
        new Modular(d, q * 2 + 1, r * 2 - d)
      } else {
        new Modular(d, q * 2, r * 2)
      }
    }

    def compareRealQuotientTo(x: Long): Int = (q, r) match {
      case (`x`, 0)          => 0
      case (`x`, _)          => 1
      case (q,   _) if q > x => 1
      case (_,   _)          => -1
    }
  }

  def from(n: Long, d: Long): Modular = new Modular(d, n / d, n % d)

  type SearchCriteria = (Modular, Modular) => Boolean

  def search(d: Long, nc: Long)(f: SearchCriteria): (Int, Modular) = {
    @tailrec
    def recursiveSearch(p: Int, powD: Modular, powNc: Modular): (Int, Modular) = {
      if (f(powD, powNc)) {
        (p, powD)
      } else {
        recursiveSearch(p + 1, powD.x2, powNc.x2)
      }
    }

    val pow = 0x80000000L
    val powD = from(pow, d).x2
    val powNc = from(pow, nc).x2
    recursiveSearch(32, powD, powNc)
  }

  def computeMagicInt(d: Int): (Long, Int) = computeMagic(d.abs, d > 0)

  def computeMagic(d: Long, positive: Boolean): (Long, Int) = {
    val pow = 0x80000000L
    val t = pow + (if (positive) 0 else 1)
    val nc = t - 1 - t % d

    val (p, powD) = search(d, nc) { case (powD, powNc) =>
      /* 2**p / nc > d - (2**p % d) */
      powNc.compareRealQuotientTo(d - powD.r) > 0
    }

    val m = powD.q + 1
    val M = if (positive) m else -m
    val s = p - 32

    (M, s)
  }
}
