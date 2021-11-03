package liontiger.benchmarking

trait Timing {
  def runWithTiming[T](action: => T): (T, Long) = {
    TimedAction(action).valueAndTime
  }

  def runWithTimingOnly[T](action: => T): Long = {
    TimedAction(action).time
  }

  def runFor[T](estimate: Long)(action: => T) = {
    val warmUpStartTime = Timing.currentTime
    while(Timing.currentTime - warmUpStartTime <= estimate) {
      action
    }
  }
}

object Timing {
  var scale: Scale = Scale.Nano

  def currentTime = scale match {
    case Scale.Milli => currentMilliTime
    case Scale.Nano => currentNanoTime
  }
  def currentMilliTime = System.currentTimeMillis()
  def currentNanoTime = System.nanoTime()

  def seconds(value: Long) = value * scale.multiplier
  def milliseconds(value: Long) = value * scale.multiplier / Scale.Milli.multiplier

  def toSeconds(value: Long): Long = value / scale.multiplier
  def toMilliseconds(value: Long): Long = value / (scale.multiplier / Scale.Milli.multiplier)

  abstract class Scale(mult: Long) {
    val multiplier = mult
  }

  object Scale {
    case object Milli extends Scale(1000L)
    case object Nano extends Scale(1000000000L)
  }
}



class TimedAction[T](action: => T) {
  private def timeAction() = {
    val startTime = Timing.currentTime
    (action, Timing.currentTime - startTime)
  }

  val (value, time) = timeAction()
  def valueAndTime = (value, time)

  override def toString = {
    s"Result: $value\nTotal time: $time ms"
  }
}

object TimedAction {
  def apply[T](action: => T) = new TimedAction(action)
}
