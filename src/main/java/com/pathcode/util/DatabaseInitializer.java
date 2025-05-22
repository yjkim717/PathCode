package com.pathcode.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Database Initializer
 * This class initializes the database with sample data if needed
 */
public class DatabaseInitializer {
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializer.class.getName());
    
    /**
     * Initialize the database with sample data
     */
    public static void initialize() {
        Connection conn = null;
        try {
            conn = DBConnectionUtil.getConnection();
            if (conn == null) {
                LOGGER.severe("Failed to get database connection for initialization");
                return;
            }
            
            // Check and initialize tables
            initializeTables(conn);
            
            // Check and insert sample user data
            if (isTableEmpty(conn, "User")) {
                LOGGER.info("Initializing User table with sample data");
                insertSampleUsersFromSqlFile(conn);
            }
            
            // Check and insert sample problem data
            if (isTableEmpty(conn, "Problem")) {
                LOGGER.info("Initializing Problem table with sample data");
                insertSampleProblems(conn);
            }
            
            // Check and insert sample recommendation data
            if (isTableEmpty(conn, "Recommendation")) {
                LOGGER.info("Initializing Recommendation table with sample data");
                insertSampleRecommendations(conn);
            }
            
            LOGGER.info("Database initialization completed successfully");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing database: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Error closing connection: " + e.getMessage(), e);
                }
            }
        }
    }
    
    /**
     * Check if a table is empty
     * @param conn Database connection
     * @param tableName Name of the table to check
     * @return True if table is empty, false otherwise
     */
    private static boolean isTableEmpty(Connection conn, String tableName) {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + tableName)) {
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error checking if table " + tableName + " is empty: " + e.getMessage(), e);
        }
        return true;
    }
    
    /**
     * Initialize database tables if they don't exist
     * @param conn Database connection
     */
    private static void initializeTables(Connection conn) {
        try (Statement stmt = conn.createStatement()) {
            // User table
            stmt.execute("CREATE TABLE IF NOT EXISTS User (" +
                         "ID INT AUTO_INCREMENT PRIMARY KEY, " +
                         "Username VARCHAR(50) NOT NULL UNIQUE, " +
                         "Email VARCHAR(100) NOT NULL UNIQUE, " +
                         "JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP)");
            
            // Problem table
            stmt.execute("CREATE TABLE IF NOT EXISTS Problem (" +
                         "ID INT PRIMARY KEY, " +
                         "Title VARCHAR(255) NOT NULL, " +
                         "Acceptance DECIMAL(5,2) NOT NULL, " +
                         "isPremium BOOLEAN NOT NULL DEFAULT FALSE, " +
                         "Difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL, " +
                         "Question_Link VARCHAR(255) NOT NULL, " +
                         "Solution_Link VARCHAR(255) NOT NULL, " +
                         "Next_Easier_Problem INT NULL)");
            
            // Recommendation table
            stmt.execute("CREATE TABLE IF NOT EXISTS Recommendation (" +
                         "ID INT AUTO_INCREMENT PRIMARY KEY, " +
                         "User_ID INT, " +
                         "Problem_ID INT, " +
                         "RecommendedDate DATETIME DEFAULT CURRENT_TIMESTAMP)");
            
            // Check if ConfidenceScore column exists in Recommendation table
            try {
                ResultSet rs = conn.getMetaData().getColumns(null, null, "Recommendation", "ConfidenceScore");
                if (!rs.next()) {
                    LOGGER.info("Adding ConfidenceScore column to Recommendation table");
                    stmt.execute("ALTER TABLE Recommendation ADD COLUMN ConfidenceScore DOUBLE DEFAULT 75.0");
                }
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error checking ConfidenceScore column: " + e.getMessage());
            }
            
            // Check if CreatedDate column exists in Recommendation table
            try {
                ResultSet rs = conn.getMetaData().getColumns(null, null, "Recommendation", "CreatedDate");
                if (!rs.next()) {
                    LOGGER.info("Adding CreatedDate column to Recommendation table");
                    stmt.execute("ALTER TABLE Recommendation ADD COLUMN CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP");
                    // Update existing rows to set CreatedDate equal to RecommendedDate
                    stmt.execute("UPDATE Recommendation SET CreatedDate = RecommendedDate WHERE CreatedDate IS NULL");
                }
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error checking CreatedDate column: " + e.getMessage());
            }
            
            LOGGER.info("Tables created successfully");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error initializing tables: " + e.getMessage(), e);
        }
    }
    
    /**
     * Insert sample users from SQL file in resources folder
     * @param conn Database connection
     */
    private static void insertSampleUsersFromSqlFile(Connection conn) {
        try {
            // Load SQL file from resources
            String sqlContent = loadResourceFile("user-insert.sql");
            if (sqlContent == null || sqlContent.trim().isEmpty()) {
                LOGGER.warning("SQL file content is empty or file not found");
                // Fall back to the old method if file can't be loaded
                insertSampleUsers(conn);
                return;
            }
            
            // Execute SQL statements from the file
            try (Statement stmt = conn.createStatement()) {
                stmt.execute(sqlContent);
                LOGGER.info("Sample users inserted successfully from SQL file");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error executing SQL from file: " + e.getMessage(), e);
            // Fall back to the old method if execution fails
            insertSampleUsers(conn);
        }
    }
    
    /**
     * Load a resource file from the classpath
     * @param resourceName Name of the resource file
     * @return Content of the resource file as String
     */
    private static String loadResourceFile(String resourceName) {
        try (InputStream inputStream = DatabaseInitializer.class.getClassLoader().getResourceAsStream(resourceName)) {
            if (inputStream == null) {
                LOGGER.warning("Resource not found: " + resourceName);
                return null;
            }
            
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                return reader.lines().collect(Collectors.joining("\n"));
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading resource file: " + e.getMessage(), e);
            return null;
        }
    }
    
    /**
     * Insert sample users (fallback method)
     * @param conn Database connection
     */
    private static void insertSampleUsers(Connection conn) {
        String sql = "INSERT INTO User (Username, Email, JoinDate) VALUES (?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // User 1
            stmt.setString(1, "John Smith");
            stmt.setString(2, "john.smith@email.com");
            stmt.executeUpdate();
            
            // User 2
            stmt.setString(1, "Sarah Johnson");
            stmt.setString(2, "sarah.j@email.com");
            stmt.executeUpdate();
            
            // User 3
            stmt.setString(1, "Michael Brown");
            stmt.setString(2, "michael.b@email.com");
            stmt.executeUpdate();
            
            // User 4
            stmt.setString(1, "Emily Davis");
            stmt.setString(2, "emily.davis@email.com");
            stmt.executeUpdate();
            
            // User 5
            stmt.setString(1, "Robert Wilson");
            stmt.setString(2, "robert.w@email.com");
            stmt.executeUpdate();
            
            LOGGER.info("Sample users inserted successfully (fallback method)");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting sample users: " + e.getMessage(), e);
        }
    }
    
    /**
     * Insert sample problems
     * @param conn Database connection
     */
    private static void insertSampleProblems(Connection conn) {
        String sql = "INSERT INTO Problem (ID, Title, Acceptance, isPremium, Difficulty, Question_Link, Solution_Link) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Problem 1
            stmt.setInt(1, 1);
            stmt.setString(2, "Two Sum");
            stmt.setDouble(3, 75.5);
            stmt.setBoolean(4, false);
            stmt.setString(5, "Easy");
            stmt.setString(6, "https://example.com/problems/two-sum");
            stmt.setString(7, "https://example.com/solutions/two-sum");
            stmt.executeUpdate();
            
            // Problem 2
            stmt.setInt(1, 2);
            stmt.setString(2, "Valid Parentheses");
            stmt.setDouble(3, 68.3);
            stmt.setBoolean(4, false);
            stmt.setString(5, "Easy");
            stmt.setString(6, "https://example.com/problems/valid-parentheses");
            stmt.setString(7, "https://example.com/solutions/valid-parentheses");
            stmt.executeUpdate();
            
            // Problem 3
            stmt.setInt(1, 3);
            stmt.setString(2, "Merge Two Sorted Lists");
            stmt.setDouble(3, 79.2);
            stmt.setBoolean(4, false);
            stmt.setString(5, "Easy");
            stmt.setString(6, "https://example.com/problems/merge-two-sorted-lists");
            stmt.setString(7, "https://example.com/solutions/merge-two-sorted-lists");
            stmt.executeUpdate();
            
            // Problem 4
            stmt.setInt(1, 4);
            stmt.setString(2, "Best Time to Buy and Sell Stock");
            stmt.setDouble(3, 72.1);
            stmt.setBoolean(4, false);
            stmt.setString(5, "Easy");
            stmt.setString(6, "https://example.com/problems/best-time-to-buy-and-sell-stock");
            stmt.setString(7, "https://example.com/solutions/best-time-to-buy-and-sell-stock");
            stmt.executeUpdate();
            
            // Problem 5
            stmt.setInt(1, 5);
            stmt.setString(2, "Valid Palindrome");
            stmt.setDouble(3, 66.9);
            stmt.setBoolean(4, false);
            stmt.setString(5, "Easy");
            stmt.setString(6, "https://example.com/problems/valid-palindrome");
            stmt.setString(7, "https://example.com/solutions/valid-palindrome");
            stmt.executeUpdate();
            
            LOGGER.info("Sample problems inserted successfully");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting sample problems: " + e.getMessage(), e);
        }
    }
    
    /**
     * Insert sample recommendations
     * @param conn Database connection
     */
    private static void insertSampleRecommendations(Connection conn) {
        String sql = "INSERT INTO Recommendation (User_ID, Problem_ID, RecommendedDate, ConfidenceScore, CreatedDate) " +
                     "VALUES (?, ?, NOW(), ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Recommendation 1
            stmt.setInt(1, 1);
            stmt.setInt(2, 3);
            stmt.setDouble(3, 87.5);
            stmt.executeUpdate();
            
            // Recommendation 2
            stmt.setInt(1, 1);
            stmt.setInt(2, 5);
            stmt.setDouble(3, 92.3);
            stmt.executeUpdate();
            
            // Recommendation 3
            stmt.setInt(1, 2);
            stmt.setInt(2, 4);
            stmt.setDouble(3, 78.6);
            stmt.executeUpdate();
            
            // Recommendation 4
            stmt.setInt(1, 2);
            stmt.setInt(2, 1);
            stmt.setDouble(3, 65.2);
            stmt.executeUpdate();
            
            // Recommendation 5
            stmt.setInt(1, 3);
            stmt.setInt(2, 2);
            stmt.setDouble(3, 89.7);
            stmt.executeUpdate();
            
            // Recommendation 6
            stmt.setInt(1, 4);
            stmt.setInt(2, 5);
            stmt.setDouble(3, 94.8);
            stmt.executeUpdate();
            
            // Recommendation 7
            stmt.setInt(1, 5);
            stmt.setInt(2, 4);
            stmt.setDouble(3, 76.5);
            stmt.executeUpdate();
            
            LOGGER.info("Sample recommendations inserted successfully");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting sample recommendations: " + e.getMessage(), e);
        }
    }
} 