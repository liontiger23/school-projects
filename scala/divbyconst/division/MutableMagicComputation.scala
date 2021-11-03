package division

import scala.annotation.tailrec

/**
  * @author liontiger
  */
trait MutableMagicComputation {
  private class Modular(var d: Long, var q: Long, var r: Long) {
    assert(d > 0 && q > 0 && r > 0)

    def x2() = {
      if (r * 2 > d) {
        q = q * 2 + 1
        r = r * 2 - d
      } else {
        q *= 2
        r *= 2
      }
    }

    def compareRealQuotientTo(x: Long): Int = (q, r) match {
      case (`x`, 0) => 0
      case (`x`, _) => 1
      case (q, _) if q > x => 1
      case _ => -1
    }
  }

  private object Modular {
    def apply(d: Long, q: Long, r: Long) = new Modular(d, q ,r)
  }

  private def from(x: Long, d: Long): Modular = Modular(d, x / d, x % d)

  private type SearchCriteria = (Modular, Modular) => Boolean

  private def search(d: Long, nc: Long)(f: SearchCriteria): (Int, Modular) = {

    val pow = 0x80000000L
    val powD = from(pow, d)
    val powNc = from(pow, nc)
    powD.x2()
    powNc.x2()

    @tailrec
    def recursiveSearch(p: Int): (Int, Modular) = {
      if (f(powD, powNc)) {
        (p, powD)
      } else {
        powD.x2()
        powNc.x2()
        recursiveSearch(p + 1)
      }
    }

    recursiveSearch(32)
  }

  private def computeMagic(d: Long, positive: Boolean): (Long, Int) = {
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

  def computeMagicInt(d: Int): (Long, Int) = computeMagic(d.abs, d > 0)
}
