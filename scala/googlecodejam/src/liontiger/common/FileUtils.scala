package liontiger.common

import java.io.FileWriter

import scala.io.Source

trait FileUtils {

  def using[F <: File, T](resource: F)(f: F => T): T =
    try f(resource) finally resource.close()
}

abstract class File {
  def close()
}

abstract class IOFile[F <: {def close(): Unit}](val resource: F) extends File {
  override def close() = resource.close()
}

abstract class WriteFile(name: String, append: Boolean) extends IOFile(new FileWriter(name, append)) {
  def print(x: Any) = resource.write(x.toString)
  def println(x: Any) = print(x.toString + "\n")
}

case class NewFile(name: String) extends WriteFile(name, false)

case class AppendFile(name: String) extends WriteFile(name, true)

case class ReadFile(name: String) extends IOFile(Source.fromFile(name)) {
  def getLines = resource.getLines().toStream
  def getText = getLines.mkString("\n")
}
