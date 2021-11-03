import unsigned._

object Test {
  def main(args: Array[String]) {
    //val n = 36
    /*for (d <- List(-5, -3, 3, 5, 6, 7, 9, 10, 11, 12, 25, 125, 625)) {
      //val n = 36
      //val (m,s) = Magic.magicInt(d)
      //println(s"$d -> (${hex(m)},$s) :: ${n/d} :: ${magicDivInt(n, d, m, s)}")
      val n: UInt = 36
      val (m,a,s) = Magic.magicUInt(d)
      println(s"$d -> (${hex(m)},$a,$s) :: ${n/d} :: ${magicDivUInt(n, d, m, a, s)}")
    }*/

    println("Int\n")

    println("Signed")
    for (n <- -1000 to 1000) {
      for (d <- 2 to 1000) {
        val (m,s) = Magic.magicInt(d)
        if (n/d != magicDivInt(n, d, m, s))
          println(s"FAILED: (n,d)=($n,$d)")
      }
    }
    println("Done\n")

    println("Unsigned")
    for (n <- 0 to 1000) {
      for (d <- 2 to 1000) {
        val (m,a,s) = Magic.magicUInt(d)
        if (n/d != magicDivUInt(n, d, m, a, s).toInt)
          println(s"FAILED: (n,d)=($n,$d)")
      }
    }
    println("Done\n")

    println("Long\n")

    println("Signed")
    for (n <- -1000 to 1000) {
      for (d <- 2 to 1000) {
        val (m,s) = Magic.magicLong(d)
        if (n/d != magicDivLong(n, d, m, s))
          println(s"FAILED: (n,d)=($n,$d)")
      }
    }
    println("Done\n")

    println("Unsigned")
    for (n <- 0 to 1000) {
      for (d <- 2 to 1000) {
        val (m,a,s) = Magic.magicULong(d)
        if (n/d != magicDivULong(n, d, m, a, s).toLong)
          println(s"FAILED: (n,d)=($n,$d)")
      }
    }
    println("Done\n")
  }


  def hex(n: Int): String = {
    String.format("%8s", n.toHexString).replace(' ', '0').toUpperCase
  }

  def hex(n: Long): String = {
    String.format("%8s", n.toHexString).replace(' ', '0').toUpperCase
  }

  /*** Testing ***/


  def magicDivInt(n: Int, d: Int, m: Int, s: Int): Int = {
    var q = mulhs(n,m)        // mulhs  q, n, m
    if (d > 0 && m < 0)
      q = q + n               // add    q, q, n
    else if (d < 0 && m > 0)
      q = q - n               // sub    q, q, n
    q = q >> s                // shrsi  q, q, s
    if (q < 0)                // shri   t, q, 31
      q += 1                  // add    q, q, t
    q
  }

  def magicDivUInt(n: UInt, d: UInt, m: UInt, a: Boolean, s: Int): UInt = {
    var q = mulhu(n,m)        // mulhu  q, n, m
    if (a) {
      var t = n - q           // sub    t, n, q
      t = t >>> 1             // shri   t, t, 1
      t = t + q               // add    t, t, q
      q = t >>> (s-1)         // shri   q, t, (s-1)
    } else {
      q = q >>> s             // shri   q, q, s
    }
    q
  }

  def magicDivLong(n: Long, d: Long, m: Long, s: Int): Long = {
    var q = mulhs(n,m)        // mulhs  q, n, m
    if (d > 0 && m < 0)
      q = q + n               // add    q, q, n
    else if (d < 0 && m > 0)
      q = q - n               // sub    q, q, n
    q = q >> s                // shrsi  q, q, s
    if (q < 0)                // shri   t, q, 31
      q += 1                  // add    q, q, t
    q
  }

  def magicDivULong(n: ULong, d: ULong, m: ULong, a: Boolean, s: Int): ULong = {
    var q = mulhu(n,m)        // mulhu  q, n, m
    if (a) {
      var t = n - q           // sub    t, n, q
      t = t >>> 1             // shri   t, t, 1
      t = t + q               // add    t, t, q
      q = t >>> (s-1)         // shri   q, t, (s-1)
    } else {
      q = q >>> s             // shri   q, q, s
    }
    q
  }

  def mulhs(x: Int, y: Int): Int = ((x.toLong * y.toLong) >> 32).toInt
  def mulhu(x: UInt, y: UInt): UInt = UInt(((x.toLong * y.toLong) >> 32).toInt)

  def mulhs(x: Long, y: Long): Long = ((BigInt(x) * BigInt(y)) >> 64).toLong
  def mulhu(x: ULong, y: ULong): ULong =
    ULong(((BigInt(x.toLong.toBinaryString, 2) * BigInt(y.toLong.toBinaryString, 2)) >> 64).toLong)

}
