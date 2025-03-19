package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;

public class UserHistoryDAO {
  // Inserts a new history entry
  public void createUserHistory(int userId, int problemId, boolean solved, int attempts) {
    String sql = "INSERT INTO User_History (User_ID, Problem_ID, Solved, Attempts) VALUES (?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.setInt(2, problemId);
      stmt.setBoolean(3, solved);
      stmt.setInt(4, attempts);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Deletes a user history entry
  public void deleteUserHistory(int historyId) {
    String sql = "DELETE FROM User_History WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, historyId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
