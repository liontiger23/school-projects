package liontiger.benchmarking

case class BenchmarkResults(time: Long, runs: Int, results: List[Long]) {
  lazy val best = results.min
  lazy val worst = results.max
  lazy val average = results.sum / runs
}
