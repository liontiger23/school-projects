package liontiger.projecteuler

import org.scalatest.FlatSpec
import org.scalatest.matchers.ShouldMatchers

class ExampleSpec extends FlatSpec with ShouldMatchers {
  "2 + 2" should "equal to 4" in {
    (2 + 2) should be (4)

  }
}
