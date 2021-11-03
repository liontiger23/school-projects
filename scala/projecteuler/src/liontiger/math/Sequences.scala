package liontiger.math

import liontiger.math.Conversions._

import scala.collection.mutable

object Sequences {

  /** Natural numbers */
  def naturals = naturalsFrom(1)
  def naturalsFrom(n: BigInt) = Stream.iterate(n)(_ + 1)

  /** Prime numbers */
  def primes = {
    val sieve = mutable.PriorityQueue[Stream[BigInt]]()(Ordering.by[Stream[BigInt], BigInt](x => x.head).reverse)
    def isPrime(x: BigInt) = sieve.isEmpty || sieve.head.head > x

    def filterPrimes(input: Stream[BigInt]): Stream[BigInt] = input match {
      case x #:: xs if isPrime(x) =>
        sieve.enqueue(input map (_ * x))
        x #:: filterPrimes(xs)
      case x #:: xs =>
        while (sieve.head.head <= x) sieve.enqueue(sieve.dequeue().tail)
        filterPrimes(xs)
    }

    2 #:: filterPrimes(naturals.tail.filter(_.odd))
  }


  /**
   * Special sequences
   */

  /** Fibonacci sequence */
  def fibonacci = {
    def fib(a: BigInt, b: BigInt): Stream[BigInt] = a #:: fib(b, a + b)
    fib(1, 1)
  }

  def collatz(n: Int) = Stream.iterate(BigInt(n)) {
    case x if x.even => x / 2
    case x            => 3 * x + 1
  }

  //lazy val triangleNumbers = naturals.inits.toStream.map(_.sum)
  def triangleNumbers = {
    var acc: BigInt = 1
    Stream.iterate[BigInt](1) { n =>
      acc += 1
      n + acc
    }
  }

  /**
   * @note this sequence is specifically for problem 28. Spiral is formed like this:
   *       21 22 23 24 25
   *       20  7  8  9 10
   *       19  6  1  2 11
   *       18  5  4  3 12
   *       17 16 15 14 13
   *
   *       But we need only diagonals:
   *       21 .. .. .. 25
   *       ..  7 ..  9 ..
   *       .. ..  1 .. ..
   *       ..  5 ..  3 ..
   *       17 .. .. .. 13
   */
  def spiralDiagonals = {
    var step: BigInt = 2
    Stream.iterate[BigInt](1) { n =>
      if (n == (step + 1).pow(2)) step += 2
      n + step
    }
  }

  /**
   * Champernowne's constant
   *
   * An irrational decimal fraction is created by concatenating the positive integers:
   * 0.123456789101112131415161718192021...
   */
  def champernownesFraction = naturals.map(_.digits).flatten

}
