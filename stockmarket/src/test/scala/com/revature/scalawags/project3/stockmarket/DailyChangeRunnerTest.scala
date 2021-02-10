package com.revature.scalawags.project3.stockmarket

import org.scalatest.flatspec.AnyFlatSpec
import org.apache.spark.sql.SparkSession
import java.io.File

class DailyChangeRunnerTest extends AnyFlatSpec {
    val spark = SparkSession.builder()
            .appName("composite_test")
            .master("local[4]")
            .getOrCreate()

    "datalake" should "not be empty" in {
        val datalakeDir =  new File("./data/datalake");
        assert(datalakeDir.isDirectory() && datalakeDir.list().length == 0)
    }

    "dataFrameByRegion" should "return a nonempty dataframe" in {
        assert(DailyChangeRunner.dataFrameByRegion(spark, "Europe").rdd.isEmpty == 0)
    }
}