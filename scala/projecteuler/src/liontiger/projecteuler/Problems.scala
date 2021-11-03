package liontiger.projecteuler


import com.github.nscala_time.time.Imports._
import liontiger.file.FileUtils
import liontiger.math.{NumberTheory, Sequences, Conversions}

import scala.annotation.tailrec
import scala.collection.mutable
import helpers._
import Sequences._
import Conversions._

object Problems extends FileUtils with NumberTheory {

  /**
   * Partial function!
   * Receives a number of the problem to be solved.
   */
  val solve: PartialFunction[Any, Any] = {

    case 1 => {
      val sum = (1 to 999).filter(x => x.divisibleBy(3) || x.divisibleBy(5)).sum
      sum
    }

    case 2 => {
      val sum = fibonacci.filter(_.even).takeWhile(_ < 4000000).sum
      sum
    }

    case 3 => {
      600851475143L.primeFactors.max
    }

    case 4 => {
      val palindromes = for (a <- 999 to 100 by -1;
                             b <- 999 to 100 by -1
                             if (a * b).isPalindrome) yield a * b
      palindromes.max
    }

    case 5 => {
      val allPrimeFactors = mutable.HashMap.empty[BigInt, Int]
      for (m <- (2 to 20).map(_.primeFactorsMap);
           p <- m.keys if allPrimeFactors.getOrElse(p, 0) < m(p)) {
        allPrimeFactors += (p -> m(p))
      }

      val sum = (allPrimeFactors map { case (p, k) => p.pow(k) }).product
      sum
    }

    case 6 => {
      val sumOfSquares = (1 to 100).map(BigInt(_).pow(2)).sum
      val squareOfSum = BigInt((1 to 100).sum).pow(2)

      squareOfSum - sumOfSquares
    }

    case 7 => {
      /** @note indices start from zero! */
      primes(10001 - 1)
    }

    case 8 => withProblemFile(8) { in =>
      val digits = in.getLines.mkString("").map(_.toString.toInt).map(BigInt(_)).toList

      @tailrec
      def findMaxProduct(max: BigInt, digits: List[BigInt]): BigInt = digits match {
        case _ if digits.length < 13 => max
        case _ => digits.take(13).product match {
            case product if max < product => findMaxProduct(product, digits.tail)
            case _ => findMaxProduct(max, digits.tail)
          }
      }

      val max = findMaxProduct(0, digits)
      max
    }

    case 9 => {
      val (a, b, c) = pythagoreanTriples(1000).head
      a * b * c
    }

    case 10 => {
      val sum = primes.takeWhile(_ < 2000000).sum
      sum
    }

    case 11 => withProblemFile(11) { in =>
      val table = in.getLines.map(_.split(" ").map(x => x.toInt).toVector).toVector

      var max = 0
      val (n, m) = (table.length, table.head.length)
      val k = 4
      for (i <- 0 to n - 1; j <- 0 to m - 1) {
        if (n > end(j) && line(i, j) > max) max = line(i, j)
        if (n > end(i) && column(i, j) > max) max = column(i, j)
        if (n > end(i) && n > end(j) && mainDiagonal(i, j) > max) max = mainDiagonal(i, j)
        if (n > end(i) && 0 <= start(j) && subDiagonal(i, j) > max) max = subDiagonal(i, j)
      }

      def end(i: Int) = i + k - 1
      def start(i: Int) = i - k + 1

      def line(i: Int, j: Int) =          (j to end(j)).map(table(i)(_)).product
      def column(i: Int, j: Int) =        (i to end(i)).map(table(_)(j)).product
      def mainDiagonal(i: Int, j: Int) =  (i to end(i)).zip(j to end(j)).map(x => table(x._1)(x._2)).product
      def subDiagonal(i: Int, j: Int) =   (i to end(i)).zip(j to start(j) by -1).map(x => table(x._1)(x._2)).product

      max
    }

    case 12 => {
      val triangleNumbersSeq = triangleNumbers
      val result = triangleNumbersSeq.dropWhile(_.factors.length <= 500).head
      result
    }

    case 13 => withProblemFile(13) { in =>
      val sum = in.getLines(13).map(BigInt(_)).sum
      sum.toString().take(10)
    }

    case 14 => {
      /**
       * @note though using ArraySeq and Int types gives better performance
       *       Map usage provides clearer code and combined with BigInt is suitable for larger tasks.
       */
      val lengths = mutable.HashMap.empty[BigInt, BigInt]
      lengths += BigInt(1) -> BigInt(0)
      val n = 1000000

      def add(x: BigInt, length: BigInt): BigInt = {
        lengths += x -> length
        length + 1
      }

      for (i <- 1 to n - 1) {
        collatz(i).span(!lengths.contains(_)) match {
          case (seq, term #:: _) => seq.foldRight(lengths(term) + 1)(add)
        }
      }

      val max = lengths.maxBy(_._2)._1
      max
    }

    case 15 => {
      val n = 20
      val matrix = mutable.ArraySeq.fill[BigInt](n + 1, n + 1)(0)
      for (i <- 1 to n) {
        matrix(0)(i) = 1
        matrix(i)(0) = 1
      }

      for (i <- 1 to n; j <- 1 to n) {
        matrix(i)(j) = matrix(i - 1)(j) + matrix(i)(j - 1)
      }
      matrix(n)(n)
    }

    case 16 => {
      val sum = BigInt(2).pow(1000).digits.sum
      sum
    }

    case 17 => {
      val sum = (1 to 1000).map(_.toWords.count(c => c.isLetter)).sum
      sum
    }

    case n @ (18 | 67) => withProblemFile(n.asInstanceOf[Int]) { in =>

      abstract class Tree {
        val sum: BigInt = this match {
          //case Leaf() => 0
          case Root(x) => x
          case SideBranch(x, c: Tree) => x + c.sum
          case Branch(x, a: Tree, b: Tree) => x + (a.sum max b.sum)
        }
      }
      //case class Leaf() extends Tree
      case class Root(value: BigInt) extends Tree
      case class SideBranch(value: BigInt, child: Tree) extends Tree
      case class Branch(value: BigInt, left: Tree, right: Tree) extends Tree

      @tailrec
      def processTree(lines: List[List[BigInt]], children: Vector[Tree] = Vector()): Vector[Tree] = {

        @tailrec
        def processBranches(values: List[BigInt], parents: Vector[Tree], children: Vector[Tree] = Vector()): Vector[Tree] = values match {
          case Nil => children
          case x :: xs => children match {
            case Vector() => parents match {
              case Vector() => Vector(Root(x))
              case b +: _ => processBranches(xs, parents, Vector(SideBranch(x, b)))
            }
            case _ => parents match {
              case Vector() => children
              case l +: (rest @ r +: _) => processBranches(xs, rest, children :+ Branch(x, l, r))
              case b +: rest => processBranches(xs, rest, children :+ SideBranch(x, b))
            }
          }
        }

        lines match {
          case Nil => children
          case x :: xs => processTree(xs, processBranches(x, children))
        }
      }

      val lines: List[List[BigInt]] = in.getLines.toList.map(_.split(" ").map(BigInt(_)).toList)
      val max = processTree(lines).map(_.sum).max
      max
    }

    case 19 => {
      val start = DateTime.now.withDate(1901, 1, 1)
      val end = start + 100.years - 1.day
      val days = Stream.iterate(start)(_ + 1.month)
      val res = days.takeWhile(_ <= end).count(_.dayOfWeek().getAsString == "7")
      res
    }

    case 20 => {
      val sum = 100.factorial.digits.sum
      sum
    }

    case 21 => {
      val n = 10000

      def d(x: Int): Int = x match {
        case 0 => 0
        case x => x.properFactors.sum.toInt
      }

      def isAmicable(x: Int): Boolean = {
        val y = d(x)
        y < n && y != x && d(y) == x
      }

      val sum = (1 to n - 1).filter(isAmicable).sum
      sum
    }

    case 22 => withProblemFile(22) { in =>
      def score(p: (String, Int)): BigInt = p match {
        case (s, n) => s.map(_ - 'A' + 1).sum * (n + 1)
      }

      val names = in.getText.tail.split("(\",\"|\")").sorted
      val sum = names.zipWithIndex.map(score).sum
      sum
    }

    case 23 => {
      val n = 28123
      val nonAbundant = mutable.ArraySeq.fill(n + 1)(true)
      val abundantNumbers = naturals.filter(x => x.properFactors.sum > x).takeWhile(_ < n)
      for (x <- abundantNumbers; y <- abundantNumbers) {
        if (x + y <= n) {
          nonAbundant(x + y toInt) = false
        }
      }
      val sum = nonAbundant.zipWithIndex.filter(_._1).map(_._2).sum
      sum
    }

    case 24 => {
      val res = (0 to 9).permutations.toStream(1000000 - 1).mkString
      res
    }

    case 25 => {
      /** @note indices start from zero! And takeWhile is not inclusive. */
      val i = fibonacci.indexWhere(_.toString().length >= 1000) + 1
      i
    }

    case 26 => {
      def reciprocal(x: Int): Int = {
        val rems = mutable.ArraySeq.fill(x)(-1)
        @tailrec
        def reciprocalCycle(r: Int, cycle: List[Int] = Nil): List[Int] = r match {
          case 0 => Nil
          case _ if rems(r) > 0 => cycle.dropWhile(_ != rems(r))
          case _ if r * 10 < x =>
            rems(r) = 0
            reciprocalCycle(r * 10, 0 :: cycle)
          case _ =>
            val (d, n) = (r * 10 / x, r * 10 % x)
            rems(r) = d
            reciprocalCycle(n, d :: cycle)
        }
        reciprocalCycle(1).length
      }

      val max = (2 until 1000).map(x => (reciprocal(x), x)).maxBy(_._1)._2
      max
    }

    case 27 => {
      def check(a: BigInt, b: BigInt): Int = {
        naturalsFrom(0).map(n => n * n + a * n + b).takeWhile(_.isPrime).length
      }

      val m = 1000
      var max = 0
      var pair = (0, 0)
      for (b <- primes.takeWhile(_ < m); a <- -m + 1 to m - 1) {
        val n = check(a, b)
        if (n > max) {
          max = n
          pair = (a, b.toInt)
        }
      }
      pair._1 * pair._2
    }

    case 28 => {
      val sum = spiralDiagonals.takeWhile(_ <= 1001 * 1001).sum
      sum
    }

    case 29 => {
      val seq = for(a <- 2 to 100; b <- 2 to 100) yield a.pow(b)
      seq.distinct.length
    }

    case 30 => {
      def digitFifthPowerSum(n: BigInt): BigInt = n.digits.map(x => x.pow(5)).sum
      val sum = naturalsFrom(10).takeWhile(_ < 1000000).filter(x => x == digitFifthPowerSum(x)).sum
      sum
    }

    case 31 => {
      val coins = List(1, 2, 5, 10, 20, 50, 100, 200)
      // Using memoization
      lazy val mem: Stream[Map[Int, Int]] = {
        def next(n: Int): Map[Int, Int] = {
          coins.takeWhile(_ <= n).map {
            case `n` => n -> 1
            case x   => x -> mem(n - x).filterKeys(_ <= x).values.sum
          } toMap
        }

        Map.empty[Int, Int] #:: naturals.map(_.toInt).map(next)
      }

      val total = mem(200).values.sum
      total
    }

    case 34 => {
      val factorials = (0 to 9).map(_.factorial).toVector
      val n = 10000000

      val res = {
        for (x <- 10 until n;
             s = x.digits.map(factorials).sum
             if s < n && s == x.toBigInt)
        yield x
      }
      res.sum
    }

    case 35 => {
      def rotations(x: BigInt): List[BigInt] = {
        List.iterate(x.digits, x.digits.length)(xs => xs.tail :+ xs.head).map(toBigInt)
      }
      val n = 1000000
      val sums = mutable.ArraySeq.fill(n)(-1)

      def valid(p: BigInt): Boolean = p match {
        case _ if p < 10 => true
        case _ if sums(p.toInt) < 0 => p.digits.forall {
          case x if x.even => false
          case 5 => false
          case _ => true
        }
        case _ => false
      }

      for (p <- primes.takeWhile(_ < n) if valid(p)) rotations(p) match {
        case ps if ps.forall (_.isPrime) => for (p <- ps) sums(p.toInt) = 1
        case ps => for (p <- ps) sums(p.toInt) = 0
      }

      sums.count(_ == 1)
    }

    case 36 => {
      val sum = naturals.take(1000000).filter(x => x.isPalindrome && x.isPalindrome(2)).sum
      sum
    }

    case "37" => {
      // TODO: Make it work!
      @tailrec
      def isLeftPrime(digits: List[Int]): Boolean = digits match {
        case Nil => true
        case _ if toBigInt(digits).isPrime => digits.last.isPrime && isLeftPrime(digits.init)
        case _ => false
      }

      // http://www.mathblog.dk/project-euler-37-truncatable-primes/#comment-246907
      val validDigits = List(1, 2, 3, 7, 9)
      val startDigits = List(3, 7)

      def findAll(): List[BigInt] = {
        @tailrec
        def find(candidates: List[List[Int]], result: List[BigInt] = Nil): List[BigInt] = candidates match {
          case Nil => result
          case digits :: rest =>
            val newResult = if (isLeftPrime(digits)) {
              toBigInt(digits) :: result
            } else {
              result
            }

            find(validDigits.map(_ :: digits).filter(x => toBigInt(x).isPrime) ::: rest, newResult)
        }

        find(startDigits.map(List(_)))
      }

      val sum = findAll().filter(_ > 9).sum
      sum
    }

    case "38" => {
      // TODO: Make it work!
      def isConcatProduct(n: BigInt): Boolean = {
        !n.digits.inits.toStream.tail.init.map(toBigInt)
          .exists(x => Stream.iterate(x)(_ + x)
            .takeWhile(_ < n).mkString
            .startsWith(n.toString()))
      }

      val max = (9 to 1 by -1).permutations.toStream.map(toBigInt).find(isConcatProduct).get
      max
    }

    case 39 => {
      val max = (1 to 1000).map(x => x -> pythagoreanTriples(x).length).maxBy(_._2)._1
      max
    }

    case 40 => {
      val product = List.iterate(1, 7)(_ * 10).map(x => champernownesFraction(x - 1)).product
      product
    }

    case 41 => {
      /**
       * @note if (1+..+n) is divisible by 3 then any number produced by permutation of 1..n is divisible by
       *       (Property of divisibility by 3)
       * @see Problem 12 for more information on triangle numbers
       */
      def firstPrimePermutation(n: Int) = (n to 1 by -1).permutations.toStream.map(toBigInt).find(_.isPrime)
      val max = (9 to 1 by -1).toStream.filter(n => !triangleNumbers(n - 1).divisibleBy(3)).map(firstPrimePermutation).find(_.isDefined).get.get
      max
    }

    case 42 => withProblemFile(42) { in =>
      def score(p: String): BigInt = p match {
        case s => s.map(_ - 'A' + 1).sum
      }
      def isTriangle(n: BigInt): Boolean = {
        triangleNumbers.find(_ >= n).get == n
      }

      val names = in.getText.tail.split("(\",\"|\")").sorted
      val total = names.map(score).count(isTriangle)
      total
    }

    case 48 => {
      def sumWithMod(x: BigInt, y: BigInt): BigInt = BigInt((x + y).toString().takeRight(10))
      val sum = naturals.map(x => x.pow(x.toInt)).take(1000).reduce(sumWithMod)
      sum
    }
  }
}
