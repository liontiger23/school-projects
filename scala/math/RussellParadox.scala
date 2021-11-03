/**
 * @author liontiger
 */
object RussellParadox extends App with SetTheory {
  def simple(x: Set) = !x.contains(x)
  val R = set(simple)

  simple(R)
}
