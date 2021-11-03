package liontiger.benchmarking

import liontiger.file._

abstract class Benchmark(name: String) extends App with Benchmarking with FileUtils with JsonUtils {
  final val EXT = "bench"

  def end() = {
    using (NewFile(s"resource/$name.$EXT")) { out =>
      out.print(toJson(results.toMap))
    }
  }
}
