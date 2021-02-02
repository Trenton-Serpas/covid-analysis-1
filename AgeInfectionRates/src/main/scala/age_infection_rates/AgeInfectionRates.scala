package age_infection_rates

import org.apache.spark.sql.functions.{bround, count, desc, when}
import org.apache.spark.sql.{SparkSession, Column}

object AgeInfectionRates {

    

    /**
      * 
      *
      * @param args
      */
    def main(args: Array[String]): Unit = {
        // Declaring spark session at global scope
        val spark = SparkSession.builder()
            .appName("Infection-Rates")
            .master("local[4]")
            .getOrCreate()

        // Setting up spark
        spark.sparkContext.setLogLevel("ERROR")
        import spark.implicits._

        createTodayTable(spark)
    }

    /** Reads in the JSON from S3 - https://disease.sh/v3/covid-19/countries?yesterday=false&allowNull=false
      * Provides a temp view for todays disease info to be used later
      * 
      * @param spark SparkContext for this application
      */
    def createTodayTable(spark: SparkSession):Unit = {
        import spark.implicits._

        // Reads in a JSON from S3
        //val todayJson = spark.read.option("true", "multiline").json("s3a://adam-king-848/data/today.json")

        // Reads in a local json file
        val todayJson = spark.read.json("datalake/InfectionRates/today.json")

        // Makes a DataFrame with a schema for columns
        val today = todayJson.toDF

        // Creates the today table
        today.createOrReplaceTempView("today")
    }
}
