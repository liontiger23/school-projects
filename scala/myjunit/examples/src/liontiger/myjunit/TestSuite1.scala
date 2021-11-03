package liontiger.myjunit

import liontiger.myjunit.annotations.{After, Before, Test}
import liontiger.myjunit.reporting.Asserts

class TestSuite1 extends Asserts {

  @Before
  def before(): Unit = {
    println("before")
  }
  @After
  def after(): Unit = {
    println("after")
  }

  @Test
  def foo() = {
    assertEquals(5, fib(5))
  }

  @Test(expected = classOf[ArithmeticException])
  def bar() = {
    var x = 0
    var y = 5 / x
  }

  def fib(i: Int): Int = i match {
    case 0 => 0
    case 1 => 1
    case i => fib(i - 1) + fib(i - 2)
  }

}
