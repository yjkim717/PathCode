package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import com.pathcode.model.Dashboard;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class DashboardDAO {

  // Inserts a new dashboard entry for a user
  public void createDashboard(int userId) {
    String sql = "INSERT INTO Dashboard (User_ID) VALUES (?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Retrieves dashboard data for a specific user
  public Dashboard getDashboard(int userId) {
    String sql = "SELECT * FROM Dashboard WHERE User_ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        return new Dashboard(
            rs.getInt("ID"),
            rs.getInt("User_ID"),
            rs.getInt("Total_Problems_Attempted"),
            rs.getInt("Total_Problems_Solved"),
            rs.getDouble("Success_Rate"),
            rs.getInt("Average_Time_Per_Problem"),
            rs.getInt("Current_Stage"),
            rs.getInt("Problems_In_Progress"),
            rs.getTimestamp("Last_Active_Date"),
            rs.getInt("Weekly_Solved_Count"),
            rs.getInt("Monthly_Solved_Count"),
            rs.getInt("Favorite_Tag_ID"),
            rs.getInt("Current_Streak"),
            rs.getInt("Longest_Streak")
        );
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return null;
  }

  // Updates dashboard statistics for a user
  public void updateDashboard(int userId, int totalSolved, int totalAttempted, double successRate, int currentStreak, int longestStreak) {
    String sql = "UPDATE Dashboard SET Total_Problems_Solved = ?, Total_Problems_Attempted = ?, Success_Rate = ?, " +
        "Current_Streak = ?, Longest_Streak = ?, Last_Active_Date = NOW() WHERE User_ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, totalSolved);
      stmt.setInt(2, totalAttempted);
      stmt.setDouble(3, successRate);
      stmt.setInt(4, currentStreak);
      stmt.setInt(5, longestStreak);
      stmt.setInt(6, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Deletes a user's dashboard entry (rarely needed)
  public void deleteDashboard(int userId) {
    String sql = "DELETE FROM Dashboard WHERE User_ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
