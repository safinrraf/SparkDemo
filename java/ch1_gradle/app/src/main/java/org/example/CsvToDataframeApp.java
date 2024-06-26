package org.example;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

/**
 * CSV ingestion in a dataframe.
 * 
 * @author jgp
 */
public final class CsvToDataframeApp {

  /**
   * main() is your entry point to the application.
   * 
   * @param args
   */
  public static void main(String[] args) {
    final var app = new CsvToDataframeApp();
    app.start();
  }

  /**
   * The processing code.
   */
  private void start() {
    // Creates a session on a local master
    final var spark = SparkSession.builder()
        .appName("CSV to Dataset")
        .master("local")
        .getOrCreate();

    // Reads a CSV file with header, called books.csv, stores it in a
    // dataframe
    final Dataset<Row> df = spark.read().format("csv")
        .option("header", "true")
        .load("data/books.csv");

    // Shows at most 5 rows from the dataframe
    df.show(5);
  }

  public String getGreeting() {
    return "Hello World!";
}
}
