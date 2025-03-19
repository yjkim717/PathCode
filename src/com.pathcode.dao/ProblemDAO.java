package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProblemDAO {
  // Inserts a new problem
  public void createProblem(int id, String title, double acceptance, String difficulty, String questionLink, String solutionLink) {
    String sql = "INSERT INTO Problem (ID, Title, Acceptance, Difficulty, Question_Link, Solution_Link) VALUES (?, ?, ?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, id);
      stmt.setString(2, title);
      stmt.setDouble(3, acceptance);
      stmt.setString(4, difficulty);
      stmt.setString(5, questionLink);
      stmt.setString(6, solutionLink);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Retrieves all problems
  public List<String> getProblems() {
    List<String> problems = new ArrayList<>();
    String sql = "SELECT * FROM Problem";
    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {
      while (rs.next()) {
        problems.add(rs.getInt("ID") + ": " + rs.getString("Title") + " (" + rs.getString("Difficulty") + ")");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return problems;
  }

  // Updates problem difficulty
  public void updateProblemDifficulty(int problemId, String newDifficulty) {
    String sql = "UPDATE Problem SET Difficulty = ? WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setString(1, newDifficulty);
      stmt.setInt(2, problemId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Deletes a problem
  public void deleteProblem(int problemId) {
    String sql = "DELETE FROM Problem WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, problemId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
