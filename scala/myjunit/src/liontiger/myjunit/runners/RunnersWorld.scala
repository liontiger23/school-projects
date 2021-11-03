package liontiger.myjunit.runners

import liontiger.myjunit.reporting.Report

import scala.collection.mutable

/**
  * @author linotiger
  */
class RunnersWorld(threadsCount: Int, classes: String*) {
  @volatile
  var runnersCount = threadsCount

  val classQueue = mutable.Queue[String](classes: _*)

  val reportsQueue = mutable.Queue.empty[Report]

  def print() = {
    while (runnersCount > 0 || reportsQueue.nonEmpty) {
      dequeueReport() match {
        case Some(report) =>
          assert(report != null)
          report.print()
          println
        case None =>
      }
    }
  }

  def dequeueReport(): Option[Report] = reportsQueue.synchronized {
    if (reportsQueue.nonEmpty) Some(reportsQueue.dequeue())
    else None
  }

  def dequeueClass(): Option[String] = classQueue.synchronized {
    if (classQueue.nonEmpty) Some(classQueue.dequeue())
    else None
  }
}
