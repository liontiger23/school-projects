package liontiger.benchmarking

import org.json4s._
import org.json4s.native.JsonMethods._

trait JsonUtils {
  implicit lazy val formats = DefaultFormats

  def toJson[A](value: A)(implicit formats : org.json4s.Formats): String = {
    pretty(render(Extraction.decompose(value)))
  }

  def fromJson[A](json: String)(implicit formats : org.json4s.Formats, mf : scala.reflect.Manifest[A]): A = {
    parse(json).extract[A]
  }
}
