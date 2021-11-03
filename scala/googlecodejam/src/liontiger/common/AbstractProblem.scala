package liontiger.common

abstract class AbstractProblem(val outputFileName: String) extends App with FileUtils {

  using(NewFile(s"res/$outputFileName")) { out =>
    val testCaseNum = readInt()
    for (n <- 1 to testCaseNum) {
      val res = solve()
      out.println(s"Case #$n: $res")
    }
  }

  /**
   * Reads input for a single test case and returns solution string.
   */
  def solve(): String
}
