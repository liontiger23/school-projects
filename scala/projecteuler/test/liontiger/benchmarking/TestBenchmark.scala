package liontiger.benchmarking

import liontiger.file.ReadFile
import liontiger.math.Conversions._
import liontiger.math.Sequences._

object TestBenchmark extends Benchmark("test") {

  benchmark ("10001th prime", 100) {
    primes(10001)
  }

  end()

  using (ReadFile("resource/test.bench")) { in =>
    println(fromJson[Map[String, BenchmarkResults]](in.getText))
  }
}
