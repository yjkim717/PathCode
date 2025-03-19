package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
  // Inserts a new user
  public void createUser(String username, String email) {
    String sql = "INSERT INTO User (Username, Email) VALUES (?, ?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setString(1, username);
      stmt.setString(2, email);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Retrieves all users
  public List<String> getUsers() {
    List<String> users = new ArrayList<>();
    String sql = "SELECT * FROM User";
    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {
      while (rs.next()) {
        users.add(rs.getInt("ID") + ": " + rs.getString("Username") + " - " + rs.getString("Email"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return users;
  }

  // Updates user's email
  public void updateUser(int userId, String newEmail) {
    String sql = "UPDATE User SET Email = ? WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setString(1, newEmail);
      stmt.setInt(2, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Deletes a user
  public void deleteUser(int userId) {
    String sql = "DELETE FROM User WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
