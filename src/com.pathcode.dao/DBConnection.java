package com.pathcode.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for establishing a connection to the MySQL database.
 */
public class DBConnection {
  private static final String URL = "jdbc:mysql://localhost:3306/";
  private static final String USER = "root"; // MySQL username
  private static final String PASSWORD = "ghkdlxld"; // MySQL password

  /**
   * Establishes and returns a connection to the database.
   *
   * @return Connection object or null if connection fails
   */
  public static Connection getConnection() {
    try {
      return DriverManager.getConnection(URL, USER, PASSWORD);
    } catch (SQLException e) {
      e.printStackTrace();
      return null;
    }
  }
}
