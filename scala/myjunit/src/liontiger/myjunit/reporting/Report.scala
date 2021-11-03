package liontiger.myjunit.reporting

import java.lang.reflect.Method

import scala.collection.mutable

/**
  * @author liontiger
  */
class Report(className: String) {

  trait Result
  case class Passed(method: Method)                           extends Result
  case class PassedWith[E <: Throwable](method: Method, exception: Class[E]) extends Result
  case class Failed(method: Method, exception: Throwable) extends Result
  case class Error(msg: String, exception: Throwable)         extends Result
  case class ErrorMsg(msg: String)                            extends Result

  private val results = mutable.Queue.empty[Result]

  def passed(method: Method) = results.enqueue(Passed(method))
  def passedWith[E <: Throwable](method: Method, exceptionClass: Class[E]) = results.enqueue(PassedWith(method, exceptionClass))
  def failed(method: Method, exception: Throwable) = results.enqueue(Failed(method, exception))
  def errorMsg(msg: String) = results.enqueue(ErrorMsg(msg))
  def error(msg: String, exception: Throwable) = results.enqueue(Error(msg, exception))

  def print() = {
    var errors = 0
    results foreach {
      case Passed(m)            => printMsg(m, "passed")
      case PassedWith(m, clazz) => printMsg(m, "passed with " + clazz.getName)

      case Failed(m, e) =>
        printMsg(m, "failed: " + e.getMessage)
        printStackTrace(e)
        errors += 1

      case ErrorMsg(msg) =>
        printMsg(s"ERROR: $msg")
        errors += 1

      case Error(msg, e) =>
        printMsg(s"ERROR: $msg")
        printStackTrace(e)
        errors += 1
    }

    printMsg(s"Testsuite: $className, " + (if (errors > 0) s"errors $errors" else "no errors"))
  }

  private def printMsg(method: Method, msg: String): Unit = printMsg(s"${method.getName}: $msg")
  private def printMsg(msg: String): Unit = println(s"[test] $msg")
  private def printStackTrace(exception: Throwable): Unit = {
    for (trace <- exception.getStackTrace) {
      printMsg("\t\t" + trace.toString)
    }

  }

}
