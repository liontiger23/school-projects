/**
 * @author liontiger
 */
trait SetTheory {
  trait Set {
    def contains(x: Set): Boolean
  }

  def set(f: Set => Boolean) = new Set {
    def contains(x: Set): Boolean = f(x)
  }

  /** Extended */

  /** Empty */
  val E = set(x => false)
  /** Universe */
  val U = set(x => true)

  trait Unionable { self: Set =>
    def union(that: Set): Set = set(x => this.contains(x) || that.contains(x))
  }

  trait Intersectable { self: Set =>
    def intersect(that: Set): Set = set(x => this.contains(x) && that.contains(x))
  }

}
