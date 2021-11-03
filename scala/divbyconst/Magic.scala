
import unsigned._

object Magic {

  // Class is used to incrementally compute quotient and remainder
  // of 2**P by `d` without exceeding single word size (W)
  //   `q` = 2**P / `d`
  //   `r` = 2**P % `d`
  // where
  //    P  = W .. 2W
  //   `m` = 2**W
  class IncrementalIterator[U <: Unsigned[U] : UnsignedCtx](m: U, d: U) extends Iterator[(U, U)] {
    val ctx = implicitly[UnsignedCtx[U]]
    import ctx._
    var q: U = m / d
    var r: U = m - q * d
    def hasNext: Boolean = true
    def next(): (U, U) = {
      q *= 2
      r *= 2
      if (r >= d) {
        q += 1
        r -= d
      }
      (q,r)
    }
  }

  def magicInt(d: Int): (Int, Int) = {
    val maxValue: UInt = UInt.MaxSignedValue

    val ad: UInt = d.abs
    val t = maxValue + (if (d > 0) 0 else 1)
    val anc = t - 1 - t % ad
    val adIterator = new IncrementalIterator[UInt](maxValue, ad)
    val ancIterator = new IncrementalIterator[UInt](maxValue, anc)

    def delta = ad - adIterator.r
    var p = 32
    adIterator.next()
    ancIterator.next()
    while (ancIterator.q < delta || (ancIterator.q == delta && ancIterator.r.toInt == 0)) {
      p += 1
      adIterator.next()
      ancIterator.next()
    }

    val m = d.signum * (adIterator.q + 1)
    val s = p - 32

    (m,s)
  }

  def magicLong(d: Long): (Long, Int) = {
    val maxValue: ULong = ULong.MaxSignedValue

    val ad: ULong = d.abs
    val t = maxValue + (if (d > 0) 0 else 1)
    val anc = t - 1 - t % ad
    val adIterator = new IncrementalIterator[ULong](maxValue, ad)
    val ancIterator = new IncrementalIterator[ULong](maxValue, anc)

    def delta = ad - adIterator.r
    var p = 64
    adIterator.next()
    ancIterator.next()
    while (ancIterator.q < delta || (ancIterator.q == delta && ancIterator.r.toLong == 0)) {
      p += 1
      adIterator.next()
      ancIterator.next()
    }

    val m = d.signum * (adIterator.q + 1)
    val s = p - 64

    (m,s)
  }


  def magicu[U <: Unsigned[U] : UnsignedCtx](d: U): (U, Boolean, Int) = {
    val ctx = implicitly[UnsignedCtx[U]]
    import ctx._

    val w = ctx.Base
    val w2 = w * 2
    val maxValue: U = ctx.MaxSignedValue
    val maxValue1: U = maxValue - 1

    var a = false
    val nc: U = (-1 : U) - (-d) % d
    val dIterator = new IncrementalIterator[U](maxValue1, d) {
      override def next(): (U, U) = {
        if (r + 1 >= d - r) {
          if (q >= maxValue1) a = true
          q = q * 2 + 1
          r = r * 2 + 1 - d
        } else {
          if (q >= maxValue) a = true
          q = q * 2
          r = r * 2 + 1
        }
        (q,r)
      }
    }
    val ncIterator = new IncrementalIterator[U](maxValue, nc) {
      override def next(): (U, U) = {
        if (r >= nc - r) {
          q = q * 2 + 1
          r = r * 2 - nc
        } else {
          q = q * 2
          r = r * 2
        }
        (q,r)
      }
    }

    def delta: U = d - 1 - dIterator.r
    var p = w
    dIterator.next()
    ncIterator.next()
    while (p < w2 && (ncIterator.q < delta || (ncIterator.q == delta && ncIterator.r == (0: U)))) {
      p += 1
      dIterator.next()
      ncIterator.next()
    }

    val m: U = dIterator.q + 1
    val s = p - w

    (m,a,s)
  }

  def magicUInt(d: UInt): (UInt, Boolean, Int) = {
   magicu[UInt](d)
  }

  def magicULong(d: ULong): (ULong, Boolean, Int) = {
    magicu[ULong](d)
  }



}
