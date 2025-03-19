package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;

public class LearningPathDAO {
  // Inserts a new learning path entry
  public void createLearningPath(int userId, int problemId, int stage) {
    String sql = "INSERT INTO Learning_Path (User_ID, Problem_ID, Stage) VALUES (?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.setInt(2, problemId);
      stmt.setInt(3, stage);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
