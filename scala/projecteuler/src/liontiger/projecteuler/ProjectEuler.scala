package liontiger.projecteuler

import liontiger.benchmarking.TimedAction

object ProjectEuler extends App {

  def invalidProblem() = {
    println("Error: Invalid Problem")
  }

  readInt() match {
    case n if Problems.solve.isDefinedAt(n) => print(TimedAction(Problems.solve(n)))
    case _ => invalidProblem()
  }
}
