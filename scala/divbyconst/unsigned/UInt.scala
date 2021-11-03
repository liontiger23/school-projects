package unsigned

final class UInt (val self: Int) extends AnyVal with Unsigned[UInt] {

  def toInt = self
  def toLong = self & 0xffffffffL

  override def toString = toLong.toString

  def +(that: UInt): UInt = (this.self + that.self)
  def -(that: UInt): UInt = (this.self - that.self)
  def *(that: UInt): UInt = (this.self * that.self)
  def /(that: UInt): UInt = (this.toLong / that.toLong).toInt
  def %(that: UInt): UInt = (this.toLong % that.toLong).toInt

  def unary_-(): UInt = (- this.self)

  def << (that: UInt): UInt = (this.self << that.self)
  def >> (that: UInt): UInt = (this.self >>> that.self)
  def >>>(that: UInt): UInt = (this.self >>> that.self)

  def ==(that: UInt): Boolean = (this.self == that.self)
  def !=(that: UInt): Boolean = (this.self != that.self)
  def >=(that: UInt): Boolean = (this.self + Int.MinValue >= that.self + Int.MinValue)
  def <=(that: UInt): Boolean = (this.self + Int.MinValue <= that.self + Int.MinValue)
  def > (that: UInt): Boolean = (this.self + Int.MinValue >  that.self + Int.MinValue)
  def < (that: UInt): Boolean = (this.self + Int.MinValue <  that.self + Int.MinValue)

  def |(that: UInt): UInt = (this.self | that.self)
  def &(that: UInt): UInt = (this.self & that.self)
  def ^(that: UInt): UInt = (this.self ^ that.self)
}

object UInt {
  import language.implicitConversions

  implicit object UIntCtx extends UnsignedCtx[UInt] {
    implicit def fromInt(x: Int): UInt = UInt(x)
    implicit val Base = UInt.Base
    implicit val MaxSignedValue = UInt.MaxSignedValue
  }

  def apply(self: Int) = int2uint(self)
  implicit def int2uint(self: Int): UInt = new UInt(self)
  implicit def uint2int(self: UInt): Int = self.toInt

  final val Base = 32
  final val MinValue = 0
  final val MaxSignedValue = UInt(Int.MaxValue + 1) //UInt(0x80000000)
  final val MaxValue = UInt(0xFFFFFFFF)
}
