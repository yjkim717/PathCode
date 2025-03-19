package com.pathcode.dao;
import com.pathcode.db.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TagDAO {
  // Inserts a new tag
  public void createTag(String tagName) {
    String sql = "INSERT INTO Tag (Name) VALUES (?)";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setString(1, tagName);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Retrieves all tags
  public List<String> getTags() {
    List<String> tags = new ArrayList<>();
    String sql = "SELECT * FROM Tag";
    try (Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {
      while (rs.next()) {
        tags.add(rs.getInt("ID") + ": " + rs.getString("Name"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return tags;
  }

  // Updates a tag name
  public void updateTag(int tagId, String newTagName) {
    String sql = "UPDATE Tag SET Name = ? WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setString(1, newTagName);
      stmt.setInt(2, tagId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Deletes a tag
  public void deleteTag(int tagId) {
    String sql = "DELETE FROM Tag WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
      stmt.setInt(1, tagId);
      stmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}
