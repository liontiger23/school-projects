package liontiger.math.MathObject

import liontiger.math.Conversions._
import liontiger.math.Sequences._

import scala.annotation.tailrec

trait MathObjectImpl extends Any {

  protected def isPrime(n: BigInt): Boolean = n match {
    case _ if n < 2 => false
    case _ => primes.filter(n.divisibleBy).takeWhile(p => p * p <= n).isEmpty
  }

  protected def primeFactors(n: BigInt): List[BigInt] = {
    if (n < 1) return Nil

    @tailrec
    def listPrimeFactors(n: BigInt, factors: List[BigInt]): List[BigInt] = n.toInt match {
      case 1 => factors
      case _ =>
        val p = primes.find(n.divisibleBy).get
        listPrimeFactors(n / p, p :: factors)
    }
    listPrimeFactors(n, Nil)
  }

  protected def primeFactorsMap(n: BigInt): Map[BigInt, Int] = {
    primeFactors(n).groupBy(x => x).mapValues(x => x.length)
  }

  protected def factors(n: BigInt): List[BigInt] = {
    if (n < 1) return Nil

    @tailrec
    def accumulate(primeFactors: Map[BigInt, Int], foundFactors: List[BigInt]): List[BigInt] = primeFactors.keys.toList match {
      case Nil => foundFactors
      case p :: _ =>
        val k = primeFactors(p)
        val primePowers = List.iterate[BigInt](1, k + 1)(_ * p)
        val moreFactors = primePowers.map(p => foundFactors.map(_ * p)).flatten
        // primePowers = [1, p, p^2, p^3, ... p^k]
        // foundFactors are multiplied by each prime power, including p^0 = 1
        // so that already found factors are not lost
        accumulate(primeFactors - p, moreFactors)
    }
    accumulate(primeFactorsMap(n), List(1))
  }

  protected def properFactors(n: BigInt): List[BigInt] = factors(n).init

  protected def isPalindrome(n: BigInt, base: Int = 10): Boolean = n.toString(base) == n.toString(base).reverse

  protected def isPandigital(n: BigInt): Boolean = digits(n).sorted == List.range(1, digits(n).length)

  protected def digits(n: BigInt): List[Int] = n.toString().map(_.asDigit).toList

  protected def factorial(n: Int): BigInt = n match {
    case 0 => 1
    case n => naturals.take(n).reduceLeft[BigInt] { case (x, y) => x * y}
  }

}
