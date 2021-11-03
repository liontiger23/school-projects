package liontiger.myjunit.reporting

/**
  * @author liontiger
  */
trait Asserts {
  def assertTrue(b: Boolean): Unit = if (!b) fail()
  def assertFalse(b: Boolean): Unit = if (b) fail()

  def assertNull(o: Object): Unit = if (o != null) failWith(null, o)
  def assertNotNull(o: Object): Unit = if (o != null) failWith("not null", "null")

  def assertEquals(o1: Any, o2: Any): Unit = (o1, o2) match {
    case (null, null) =>
    case (null, o2) => failWith(null, o2)
    case (o1, o2) if o1 equals o2 =>
    case (o1, o2) => failWith(o1, o2)
  }
  def assertNotEquals(o1: Any, o2: Any): Unit = (o1, o2) match {
    case (null, null) => failWith(o1, o2)
    case (null, o2) =>
    case (o1, o2) if o1 equals o2 => failWith(o1, o2)
    case (o1, o2) =>
  }

  def failWith(o1: Any, o2: Any): Unit = failWith(format(o1), format(o2))
  def failWith(expectation: String, reality: String): Unit = fail(s"expected $expectation, but found $reality")

  def format(o: Any): String =
    if (o != null) s"${o.getClass.getName}($o)"
    else "null"

  def fail(): Unit = fail("")
  def fail(msg: String): Unit = {
    throw MyAssertionError(msg)
  }
}

/** To use from java code */
object Asserts

case class MyAssertionError(msg: String) extends AssertionError(msg)
