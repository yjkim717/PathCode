package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;

public class ProblemTagDAO {
  // Links a problem to a tag
  public void linkProblemToTag(int problemId, int tagId) {
    String sql = "INSERT INTO Problem_Tag (Problem_ID, Tag_ID) VALUES (?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, problemId);
      stmt.setInt(2, tagId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Removes the link between a problem and a tag
  public void unlinkProblemFromTag(int problemId, int tagId) {
    String sql = "DELETE FROM Problem_Tag WHERE Problem_ID = ? AND Tag_ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, problemId);
      stmt.setInt(2, tagId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
