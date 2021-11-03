package liontiger.math

import liontiger.math.MathObject.MathObject

object Conversions {

  implicit def bigIntToMathObject(x: BigInt): MathObject = new MathObject(x)
  implicit def intToMathObject(x: Int): MathObject = new MathObject(x)
  implicit def longToMathObject(x: Long): MathObject = new MathObject(x)
  implicit def mathObjectToBigInt(x: MathObject): BigInt = x.toBigInt
  implicit def mathObjectToInt(x: MathObject): Int = x.toInt
  implicit def mathObjectToLong(x: MathObject): Long = x.toLong

  def toBigInt(x: TraversableOnce[Int]): BigInt = BigInt(x.mkString)

  def toWords(n: Int, useAnd: Boolean = true): String = n match {
    case 0 => "zero"
    case 1 => "one"
    case 2 => "two"
    case 3 => "three"
    case 4 => "four"
    case 5 => "five"
    case 6 => "six"
    case 7 => "seven"
    case 8 => "eight"
    case 9 => "nine"
    case 10 => "ten"
    case 11 => "eleven"
    case 12 => "twelve"
    case 13 => "thirteen"
    case 14 => "fourteen"
    case 15 => "fifteen"
    case 16 => "sixteen"
    case 17 => "seventeen"
    case 18 => "eighteen"
    case 19 => "nineteen"
    case 20 => "twenty"
    case 30 => "thirty"
    case 40 => "forty"
    case 50 => "fifty"
    case 60 => "sixty"
    case 70 => "seventy"
    case 80 => "eighty"
    case 90 => "ninety"
    case n if n < 100 => n % 10 match {
      case 0 => toWords(n)
      case r => toWords(n - r) + "-" + toWords(r)
    }
    case n if n < 1000 => n % 100 match {
      case 0 => toWords(n / 100) + " hundred"
      case r if useAnd => toWords(n - r) + " and " + toWords(r)
      case r           => toWords(n - r) + " " + toWords(r)
    }
    case n if n < 1000000 => n % 1000 match {
      case 0 => toWords(n / 1000, useAnd = false) + " thousand"
      case r => toWords(n - r, useAnd = false) + " " + toWords(r)
    }
  }

}
