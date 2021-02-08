package TweetCovid19Percentage

import org.apache.log4j._
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.{DataFrameReader,DataFrame,Row,SparkSession}
import org.scalatest.flatspec.AnyFlatSpec

/**
  * A class full of unit tests for testing the functionality of the various functions
  * in the Runner.scala class
  */
class RunnerSpec extends AnyFlatSpec{
    // Set the log level to only print errors
    Logger.getLogger("org").setLevel(Level.ERROR)
    // Grab the Spark Session object, set the app Name option, EMR will handle the rest of the config
    val spark = SparkSession.builder().master("local").appName("TweetCovid19Percentage").getOrCreate()
    // TODO: Learn more about spark implicits because you know nothing atm 
    import spark.implicits._
    // The path to the input test data file
    val testFilePath = "test-data.txt"
    // A test DataSet for comparison to DataSet returned by reader function
    val testDS = spark.read.text(testFilePath).as[Runner.Tweet]
    // Some test strings for testing the covid related terms matching function
    val testString1 = "Testing basic string"
    val testString2 = "A string containing a Covid match"
    val testString3 = "Pandemic-induced Netflix fugue?"
    val testString4 = "breaking down #COVID!"

    // The ReadInputFileToDS function should parse the input data into a DataFrame for processing
    // The DataSet should have a single column with values being the text of the individual tweets
    "ReadInputFileToDS case 0" should "return a DataFrame containing the input test data" in {
        assert(Runner.ReadInputFileToDS(testFilePath, spark).collect().equals(testDS.collect()))
    }

    // The ReadInputFileToDS function should parse the input data into a DataFrame for processing
    // The DataSet should have a single column with values being the text of the individual tweets
    "ReadInputFileToDS case 1" should "return a DataFrame containing the input test data" in {
        assert(Runner.ReadInputFileToDS(testFilePath, spark).collect().equals(testDS.collect()))
    }

    // The input test data contains half covid related and half non-covid related tweets
    // The tweetCovid19Percentage function should return an integer value of 50 represeting the percentage
    "tweetCovid19Percentage case 0" should "return 50 percent with the test input data" in {
        assert(Runner.tweetCovid19Percentage(testFilePath, spark) == 50)
    }

    // The IsCovidRelatedText function takes a tweet text string as input and loops through
    // the list of Covid terms. The test string here is not a covid term so it should return false
    "IsCovidRelatedText case 0" should "return false for input test string 1 (english noncovid single word)" in {
        assert(Runner.IsCovidRelatedText(testString1) == false)
    }

    // The IsCovidRelatedText function takes a tweet text string as input and loops through
    // the list of Covid terms. The test string here is a covid term so it should return true
    "IsCovidRelatedText case 1" should "return true for input test string 2 (english covid single word)" in {
        assert(Runner.IsCovidRelatedText(testString2) == true)
    }
    
    // The IsCovidRelatedText function takes a tweet text string as input and loops through
    // the list of Covid terms. The test string here is a covid term so it should return true
    "IsCovidRelatedText case 2" should "return true for input test string 3 (english covid single word with no space)" in {
        assert(Runner.IsCovidRelatedText(testString3) == true)
    }

    // The IsCovidRelatedText function takes a tweet text string as input and loops through
    // the list of Covid terms. The test string here is a covid term so it should return true
    "IsCovidRelatedText case 3" should "return true for input test string 4 (english covid single word with hashtag/punctuation)" in {
        assert(Runner.IsCovidRelatedText(testString3) == true)
    }
}