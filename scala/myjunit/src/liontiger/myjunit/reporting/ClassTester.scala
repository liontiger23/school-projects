package liontiger.myjunit.reporting

import java.lang.reflect.{InvocationTargetException, Method}

import liontiger.myjunit.annotations.{After, Before, Test}

import scala.collection.mutable.ListBuffer

/**
  * @author liontiger
  */
class ClassTester(className: String) {
  private val report = new Report(className)

  def test() = {
    try {
      val clazz: Class[_] = Class.forName(className)
      //println(s"[TEST] Class $className loaded")
      testClass(clazz)
    } catch {
      case e: ClassNotFoundException =>
        report.error(s"Unable to load class $className:", e)
    }
    report
  }


  private def testClass(clazz: Class[_]): Unit = {
    var before: Option[Method] = None
    var after: Option[Method] = None
    var tests = ListBuffer.empty[Method]

    // TODO: check method args and multiple test annotations!
    for (method <- clazz.getMethods) {
      method.getDeclaredAnnotations foreach {
        case _: Before if before.isEmpty => before = Some(method)
        case _: Before =>
          report.errorMsg("Multiple @Before annotations found")
          return

        case _: After if after.isEmpty => after = Some(method)
        case _: After =>
          report.errorMsg("Multiple @After annotations found")
          return

        case _: Test => tests += method

        case _ =>
      }
    }

    for (method <- tests) {
      testMethod(clazz, method, before, after)
    }
  }

  private def testMethod(clazz: Class[_], method: Method, before: Option[Method], after: Option[Method]) = {
    val annotation = method.getAnnotation(classOf[Test])
    val obj = clazz.newInstance()

    for (beforeMethod <- before) {
      beforeMethod.invoke(obj)
    }
    try {
      method.invoke(obj)
      report.passed(method)
    } catch {
      case e: InvocationTargetException => e.getTargetException match {
        case e if e.getClass == annotation.expected() => report.passedWith(method, annotation.expected())
        case e: MyAssertionError => report.failed(method, e)
        case e: Throwable => report.error(e.getMessage, e)
      }
    }

    for (afterMethod <- after) {
      afterMethod.invoke(obj)
    }
  }
}
