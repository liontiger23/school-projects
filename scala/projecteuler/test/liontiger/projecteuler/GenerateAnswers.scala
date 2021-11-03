package liontiger.projecteuler

import liontiger.file.{NewFile, FileUtils}

object GenerateAnswers extends App with FileUtils {
  using (NewFile("resource/answers.txt")) { out =>
    for (n <- 1 to 100 if Problems.solve.isDefinedAt(n)) {
      out.println(s"$n -> ${Problems.solve(n)}")
    }
  }
}
