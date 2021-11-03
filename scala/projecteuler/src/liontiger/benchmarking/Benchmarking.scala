package liontiger.benchmarking

import scala.collection.mutable

trait Benchmarking extends Timing{
  private final val WARM_UP_TIME = 20
  private final val CLEAN_UP_TIME = 5

  lazy val results: mutable.HashMap[String, BenchmarkResults] = mutable.HashMap()

  def benchmark[T](name: String, runs: Int = 1)(f: => T) = {
    println(s"Benchmark '$name'")
    val (times, total) = runWithTiming {
      cleanUp()
      try {
        warmUp(f)
        runBenchmarks(runs)(f)
      } finally {
        cleanUp()
      }
    }
    this.results(name) = BenchmarkResults(Timing.toSeconds(total), runs, times.map(Timing.toMilliseconds)toList)
  }

  private def warmUp[T](f: => T) = {
    println("Warming up...")
    runFor(Timing.seconds(WARM_UP_TIME))(f)
  }

  private def runBenchmarks[T](runs: Int)(f: => T) = {
    println("Benchmarking...")
    for (i <- 1 to runs) yield {
      //print(s"Run #$i\r")
      runWithTimingOnly(f)
    }
  }

  private def cleanUp() = {
    println("Cleaning up...")
    runFor(Timing.seconds(CLEAN_UP_TIME)) {
      System.gc()
      System.runFinalization()
    }
  }
}
