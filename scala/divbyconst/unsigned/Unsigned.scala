package unsigned

trait Unsigned[U] extends Any {
  def toInt: Int
  def toLong: Long

  def toString: String

  def +(that: U): U
  def -(that: U): U
  def *(that: U): U
  def /(that: U): U
  def %(that: U): U

  def unary_-(): U

  def << (that: U): U
  def >> (that: U): U
  def >>>(that: U): U

  //def ==(that: U): Boolean
  //def !=(that: U): Boolean
  def >=(that: U): Boolean
  def <=(that: U): Boolean
  def > (that: U): Boolean
  def < (that: U): Boolean

  def |(that: U): U
  def &(that: U): U
  def ^(that: U): U
}

trait UnsignedCtx[U <: Unsigned[U]] {
  implicit def fromInt(x: Int): U
  implicit val Base: Int
  implicit val MaxSignedValue: U
}