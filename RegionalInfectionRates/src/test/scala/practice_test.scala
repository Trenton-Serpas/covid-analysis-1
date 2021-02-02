package infection_rates

import java.io.ByteArrayOutputStream
import org.scalatest.flatspec.AnyFlatSpec
import org.apache.spark.sql.functions.{bround, count, desc, when}
import org.apache.spark.sql.{SparkSession, Column}

//import RegionalInfectionRates/src/main/scala/infection_rates/InfectionRates.scala

class practice_test extends AnyFlatSpec {
  //Create spark session
  val spark = SparkSession
    .builder()
    .appName("Infection-Rates")
    .master("local[4]")
    .getOrCreate()

  // Setting up spark
  spark.sparkContext.setLogLevel("ERROR")
  import spark.implicits._

  //Create data resources

  "createTodayTable" should "return valid json" in {
    InfectionRates.createTodayTable(spark)

    var allData = spark.sql("SELECT * FROM today")

    assert(allData.columns.contains("Region"))
    assert(allData.columns.contains("country"))
  }
}
