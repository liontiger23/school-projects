package liontiger.math.MathObject

import liontiger.math.Conversions

class MathObject(val x: BigInt) extends AnyVal with MathObjectImpl {

  def toBigInt: BigInt = x
  def toInt: Int = x.toInt
  def toLong: Long = x.toLong
  def toWords: String = Conversions.toWords(x.toInt)

  def max(y: BigInt): BigInt = if (x > y) x else y
  def min(y: BigInt): BigInt = if (x < y) x else y

  def pow(y: Int): BigInt = x.pow(y)

  def isZero: Boolean = x == BigInt(0)
  def even: Boolean = divisibleBy(2)
  def odd: Boolean = !even
  def divisibleBy(y: BigInt): Boolean = x % y == BigInt(0)

  /** NumberTheory **/
  def isPrime: Boolean = isPrime(x)
  def primeFactors: List[BigInt] = primeFactors(x)
  def primeFactorsMap: Map[BigInt, Int] = primeFactorsMap(x)
  def factors: List[BigInt] = factors(x)
  def properFactors: List[BigInt] = properFactors(x)
  def isPalindrome: Boolean = isPalindrome(x)
  def isPalindrome(base: Int): Boolean = isPalindrome(x, base)
  def isPandigital: Boolean = isPandigital(x)
  def digits: List[Int] = digits(x)
  def factorial: BigInt = factorial(x.toInt)
}
