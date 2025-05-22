package com.pathcode.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * Database Connection Utility class
 * Provides methods to establish connection with the MySQL database
 */
public class DBConnectionUtil {

    // Database connection parameters


	private static final String URL = "jdbc:mysql://localhost:3306/LeetAdapt?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "password";       // TODO: Change this to the actual password


    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    // JNDI name
    private static final String JNDI_NAME = "java:comp/env/jdbc/LeetAdapt";
    // Logger for this class
    private static final Logger LOGGER = Logger.getLogger(DBConnectionUtil.class.getName());
    
    /**
     * Get database connection
     * @return Connection object
     */
    public static Connection getConnection() {
        Connection connection = null;
        
        try {
            // First try to get connection from JNDI
            LOGGER.info("Attempting to get connection from JNDI data source: " + JNDI_NAME);
            Context initContext = new InitialContext();
            DataSource ds = (DataSource) initContext.lookup(JNDI_NAME);
            connection = ds.getConnection();
            
            if (connection != null) {
                LOGGER.info("Database connection established successfully using JNDI");
                return connection;
            }
        } catch (NamingException e) {
            LOGGER.log(Level.WARNING, "JNDI lookup failed, falling back to direct connection: " + e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Could not get JNDI connection, falling back to direct connection: " + e.getMessage());
        }
        
        // If JNDI connection failed, fall back to direct connection
        try {
            // Load the database driver
            Class.forName(DRIVER);
            LOGGER.info("Database driver loaded successfully: " + DRIVER);
            
            // Create a new connection each time
            LOGGER.info("Attempting to connect to database directly at: " + URL);
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            if (connection != null) {
                LOGGER.info("Database connection established successfully");
                
//<<<<<<< HEAD
////<<<<<<< HEAD
////                // Test the connection with a simple query
////                try {
////                    java.sql.Statement stmt = connection.createStatement();
////                    java.sql.ResultSet rs = stmt.executeQuery("SHOW DATABASES");
////                    LOGGER.info("Available databases:");
////                    while (rs.next()) {
////                        LOGGER.info(" - " + rs.getString(1));
////                    }
////                    rs.close();
////                    stmt.close();
////                } catch (SQLException e) {
////                    LOGGER.log(Level.WARNING, "Could not list databases: " + e.getMessage());
////=======
//                // Add debug info to verify database access
//                try (java.sql.Statement stmt = connection.createStatement()) {
//                    LOGGER.info("Testing database access by querying Recommendation table...");
//                    java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Recommendation");
//                    if (rs.next()) {
//                        int count = rs.getInt(1);
//                        LOGGER.info("Number of recommendations found: " + count);
//                    }
//                } catch (SQLException e) {
//                    LOGGER.log(Level.SEVERE, "Database access test failed: " + e.getMessage());
////>>>>>>> 8f612aa81c174fa28d13380e5778e0914962b5c0
//=======
                // Test the connection with a simple query
                try {
                    java.sql.Statement stmt = connection.createStatement();
                    java.sql.ResultSet rs = stmt.executeQuery("SHOW DATABASES");
                    LOGGER.info("Available databases:");
                    while (rs.next()) {
                        LOGGER.info(" - " + rs.getString(1));
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Could not list databases: " + e.getMessage());
//>>>>>>> f4ea52b33d00f1c1e2b9b914ebcaa4a40c279360
                }
            } else {
                LOGGER.severe("Failed to establish database connection - connection is null");
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database Driver not found: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "", e);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error: " + e.getMessage() + 
                       ", SQL State: " + e.getSQLState() + 
                       ", Error Code: " + e.getErrorCode());
            LOGGER.log(Level.SEVERE, "", e);
            
            // Try alternative connections if first attempt fails
            if (e.getMessage().contains("Access denied") || e.getMessage().contains("Unknown database")) {
                // Try alternative connection methods
                tryAlternativeConnections();
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error establishing connection: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "", e);
        }
        
        return connection;
    }
    
    /**
     * Try alternative connection methods if the primary one fails
     */
    private static Connection tryAlternativeConnections() {
        Connection connection = null;
        
        // Try with various common password combinations
        String[] commonPasswords = {"", "root", "password", "admin", "mysql"};
        String[] databaseNames = {"LeetAdapt", "leetadapt"};
        
        for (String dbName : databaseNames) {
            for (String pwd : commonPasswords) {
                try {
                    String testUrl = "jdbc:mysql://localhost:3306/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                    LOGGER.info("Trying alternative connection to: " + testUrl + " with password: " + (pwd.isEmpty() ? "[empty]" : "[set]"));
                    connection = DriverManager.getConnection(testUrl, USERNAME, pwd);
                    
                    if (connection != null) {
                        LOGGER.info("Alternative connection successful with database: " + dbName + " and password: " + (pwd.isEmpty() ? "[empty]" : "[set]"));
                        
                        // Verify the User table exists
                        try {
                            java.sql.Statement stmt = connection.createStatement();
                            java.sql.ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'User'");
                            if (rs.next()) {
                                LOGGER.info("User table exists in database: " + dbName);
                                
                                // Check for users
                                rs = stmt.executeQuery("SELECT COUNT(*) FROM User");
                                if (rs.next()) {
                                    int count = rs.getInt(1);
                                    LOGGER.info("Found " + count + " users in the User table");
                                    
                                    if (count > 0) {
                                        // This is the right database with users!
                                        LOGGER.info("This appears to be the correct database with user records");
                                        rs.close();
                                        stmt.close();
                                        return connection;
                                    }
                                }
                            } else {
                                LOGGER.info("User table does not exist in database: " + dbName);
                            }
                            rs.close();
                            stmt.close();
                        } catch (SQLException e) {
                            LOGGER.log(Level.WARNING, "Error checking User table: " + e.getMessage());
                        }
                        
                        connection.close(); // Not the right database, close and try next
                    }
                } catch (SQLException ex) {
                    // Just continue to the next attempt
                }
            }
        }
        
        // Try connecting to MySQL without specifying a database
        try {
            String baseUrl = "jdbc:mysql://localhost:3306?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            LOGGER.info("Attempting basic connection to: " + baseUrl);
            connection = DriverManager.getConnection(baseUrl, "root", "");
            
            if (connection != null) {
                LOGGER.info("Basic connection successful. Listing available databases:");
                java.sql.Statement stmt = connection.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SHOW DATABASES");
                while (rs.next()) {
                    LOGGER.info(" - " + rs.getString(1));
                }
                rs.close();
                stmt.close();
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Basic connection also failed: " + ex.getMessage());
        }
        
        return null;
    }
    
    /**
     * Close the database connection
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Database connection closed successfully");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing database connection: " + e.getMessage());
                LOGGER.log(Level.SEVERE, "", e);
            }
        }
    }
}