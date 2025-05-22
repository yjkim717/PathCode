package com.pathcode.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.pathcode.dao.LearningPathDAO;
import com.pathcode.model.LearningPath;
import com.pathcode.util.DBConnectionUtil;

public class LearningPathDAOImpl implements LearningPathDAO {
    @Override
    public void addLearningPath(LearningPath learningPath) {
        String sql = "INSERT INTO Learning_Path (User_ID, Problem_ID, Stage, AssignedDate) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, learningPath.getUserId());
            stmt.setInt(2, learningPath.getProblemId());
            stmt.setInt(3, learningPath.getStage());
            stmt.setTimestamp(4, new Timestamp(learningPath.getAssignedDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<LearningPath> getLearningPathsByUser(int userId) {
        List<LearningPath> learningPaths = new ArrayList<>();
        String sql = "SELECT * FROM Learning_Path WHERE User_ID = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LearningPath lp = new LearningPath(
                    rs.getInt("ID"),
                    rs.getInt("User_ID"),
                    rs.getInt("Problem_ID"),
                    rs.getInt("Stage"),
                    rs.getTimestamp("AssignedDate")
                );
                learningPaths.add(lp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return learningPaths;
    }

    @Override
    public LearningPath getLearningPathById(int id) {
        String sql = "SELECT * FROM Learning_Path WHERE ID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new LearningPath(
                    rs.getInt("ID"),
                    rs.getInt("User_ID"),
                    rs.getInt("Problem_ID"),
                    rs.getInt("Stage"),
                    rs.getTimestamp("AssignedDate")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving learning path with ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
        
        return null;
    }

    @Override
    public void updateLearningPath(LearningPath learningPath) {
        String sql = "UPDATE Learning_Path SET User_ID = ?, Problem_ID = ?, Stage = ?, AssignedDate = ? WHERE ID = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, learningPath.getUserId());
            stmt.setInt(2, learningPath.getProblemId());
            stmt.setInt(3, learningPath.getStage());
            stmt.setTimestamp(4, new Timestamp(learningPath.getAssignedDate().getTime()));
            stmt.setInt(5, learningPath.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteLearningPath(int id) {
        String sql = "DELETE FROM Learning_Path WHERE ID = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<LearningPath> getAllLearningPaths() {
        List<LearningPath> learningPaths = new ArrayList<>();
        String sql = "SELECT * FROM Learning_Path";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                LearningPath lp = new LearningPath(
                    rs.getInt("ID"),
                    rs.getInt("User_ID"),
                    rs.getInt("Problem_ID"),
                    rs.getInt("Stage"),
                    rs.getTimestamp("AssignedDate")
                );
                // Set other properties if available
                try {
                    lp.setDescription(rs.getString("Description"));
                } catch (SQLException e) {
                    // Column might not exist, ignore
                }
                
                try {
                    lp.setEstimatedCompletionTime(rs.getInt("EstimatedCompletionTime"));
                } catch (SQLException e) {
                    // Column might not exist, ignore
                }
                
                try {
                    lp.setIsRequired(rs.getBoolean("IsRequired"));
                } catch (SQLException e) {
                    // Column might not exist, ignore
                }
                
                learningPaths.add(lp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return learningPaths;
    }
}