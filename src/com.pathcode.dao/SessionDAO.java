package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;

public class SessionDAO {
  // Inserts a new session start time
  public void createSession(int userId) {
    String sql = "INSERT INTO Session (User_ID) VALUES (?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Ends a session by updating the end time
  public void endSession(int sessionId) {
    String sql = "UPDATE Session SET EndTime = NOW() WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, sessionId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
