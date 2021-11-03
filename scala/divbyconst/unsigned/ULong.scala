package unsigned

final class ULong (val self: Long) extends AnyVal with Unsigned[ULong] {

  def toInt = self.toInt
  def toLong = self

  override def toString = self.toString

  def +(that: ULong): ULong = (this.self + that.self)
  def -(that: ULong): ULong = (this.self - that.self)
  def *(that: ULong): ULong = (this.self * that.self)

  def /(that: ULong): ULong = (this.self, that.self) match {
    case (a, b) if (this <  that)           => (0L)
    case (a, b) if (this <= Long.MaxValue)  => (a / b)
    case (a, b) => {
      val n = Long.MaxValue / b
      val m = n * b
      ((a - m) / b + n)
    }
  }

  def %(that: ULong): ULong = (this.self, that.self) match {
    case (a, b) if (this <  that)           => this
    case (a, b) if (this <= Long.MaxValue)  => (a % b)
    case (a, b) => {
      val n = Long.MaxValue % b
      val m = a - Long.MaxValue + n
      (m % b)
    }
  }

  def unary_-(): ULong = (- this.self)

  def << (that: ULong): ULong = (this.self << that.self)
  def >> (that: ULong): ULong = (this.self >>> that.self)
  def >>>(that: ULong): ULong = (this.self >>> that.self)

  def ==(that: ULong): Boolean = (this.self == that.self)
  def !=(that: ULong): Boolean = (this.self != that.self)
  def >=(that: ULong): Boolean = (this.self + Long.MinValue >= that.self + Long.MinValue)
  def <=(that: ULong): Boolean = (this.self + Long.MinValue <= that.self + Long.MinValue)
  def > (that: ULong): Boolean = (this.self + Long.MinValue >  that.self + Long.MinValue)
  def < (that: ULong): Boolean = (this.self + Long.MinValue <  that.self + Long.MinValue)

  def |(that: ULong): ULong = (this.self | that.self)
  def &(that: ULong): ULong = (this.self & that.self)
  def ^(that: ULong): ULong = (this.self ^ that.self)
}

object ULong {
  import language.implicitConversions

  implicit object ULongCtx extends UnsignedCtx[ULong] {
    implicit def fromInt(x: Int): ULong = ULong(x)
    implicit val Base = ULong.Base
    implicit val MaxSignedValue = ULong.MaxSignedValue
  }

  def apply(self: Long) = long2ulong(self)
  implicit def long2ulong(self: Long): ULong = new ULong(self)
  implicit def ulong2long(self: ULong): Long = self.toLong

  final val Base = 64
  final val MinValue = 0
  final val MaxSignedValue = ULong(Long.MaxValue + 1) //ULong(0x8000000000000000L)
  final val MaxValue = ULong(0xFFFFFFFFFFFFFFFFL)
}
