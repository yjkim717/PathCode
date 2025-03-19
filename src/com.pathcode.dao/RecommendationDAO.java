package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecommendationDAO {

  // Finds the next problem based on difficulty and tag
  public int getNextProblem(int currentProblemId, boolean solved) {
    String sql = solved ?
        "SELECT ID FROM Problem WHERE Difficulty = (SELECT CASE Difficulty " +
            "WHEN 'Easy' THEN 'Medium' WHEN 'Medium' THEN 'Hard' ELSE 'Hard' END FROM Problem WHERE ID = ?) " +
            "AND ID != ? AND ID IN (SELECT Problem_ID FROM Problem_Tag WHERE Tag_ID = " +
            "(SELECT Tag_ID FROM Problem_Tag WHERE Problem_ID = ? LIMIT 1)) LIMIT 1"
        :
            "SELECT ID FROM Problem WHERE Difficulty = (SELECT CASE Difficulty " +
                "WHEN 'Hard' THEN 'Medium' WHEN 'Medium' THEN 'Easy' ELSE 'Easy' END FROM Problem WHERE ID = ?) " +
                "AND ID != ? AND ID IN (SELECT Problem_ID FROM Problem_Tag WHERE Tag_ID = " +
                "(SELECT Tag_ID FROM Problem_Tag WHERE Problem_ID = ? LIMIT 1)) LIMIT 1";

    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, currentProblemId);
      stmt.setInt(2, currentProblemId);
      stmt.setInt(3, currentProblemId);
      ResultSet rs = stmt.executeQuery();
      if (rs.next()) {
        return rs.getInt("ID");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return -1; // No recommendation found
  }

  // Creates a recommendation for a user
  public void createRecommendation(int userId, int problemId) {
    String sql = "INSERT INTO Recommendation (User_ID, Problem_ID, RecommendedDate) VALUES (?, NOW())";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.setInt(2, problemId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
