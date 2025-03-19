package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;

public class UserStatsDAO {
  // Inserts a new user stats entry
  public void createUserStats(int userId) {
    String sql = "INSERT INTO User_Stats (User_ID) VALUES (?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Updates user stats
  public void updateUserStats(int userId, int totalSolved, double avgAcceptance) {
    String sql = "UPDATE User_Stats SET Total_Solved = ?, Avg_Acceptance = ? WHERE User_ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, totalSolved);
      stmt.setDouble(2, avgAcceptance);
      stmt.setInt(3, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
