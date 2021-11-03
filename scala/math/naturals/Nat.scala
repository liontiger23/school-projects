package naturals

/**
 * @author liontiger
 */
abstract class Nat {
  def isZero: Boolean
  def successor: Nat = new Succ(this)
  def predecessor: Nat
  def +(that: Nat): Nat
  def -(that: Nat): Nat
}

object Zero extends Nat {
  override def isZero: Boolean = true

  override def predecessor: Nat = throw new Error("0.predecessor")

  override def +(that: Nat): Nat = that

  override def -(that: Nat): Nat =
    if (that.isZero) Zero
    else throw new Error("0 - nonZero")

  override def toString = "0"
}

class Succ(n: Nat) extends Nat {
  override def isZero: Boolean = false

  override def predecessor: Nat = n

  override def +(that: Nat): Nat = new Succ(n + that)

  override def -(that: Nat): Nat =
    if (that.isZero) this
    else n - that.predecessor

  override def toString = n + " + 1"
}