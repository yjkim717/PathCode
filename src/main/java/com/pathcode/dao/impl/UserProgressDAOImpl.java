package com.pathcode.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.pathcode.dao.UserProgressDAO;
import com.pathcode.model.SolvedProblem;
import com.pathcode.model.UserProgress;
import com.pathcode.util.DBConnectionUtil;

public class UserProgressDAOImpl implements UserProgressDAO {

    @Override
    public UserProgress getUserProgress(int userId, int problemId) {
        UserProgress progress = null;
        String sql = "SELECT * FROM User_Progress WHERE User_ID = ? AND Problem_ID = ?";

        System.out.println("\n===== DATABASE OPERATION - GET USER PROGRESS =====");
        System.out.println("Checking for existing progress for User ID: " + userId + ", Problem ID: " + problemId);
        System.out.println("SQL: " + sql);
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, problemId);
            
            System.out.println("Executing query: SELECT * FROM User_Progress WHERE User_ID = " + userId + " AND Problem_ID = " + problemId);
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
                
                System.out.println("RESULT: Found existing progress record with ID: " + progress.getId());
                System.out.println("  User_ID: " + progress.getUserId());
                System.out.println("  Problem_ID: " + progress.getProblemId());
                System.out.println("  Solved: " + progress.isSolved());
                System.out.println("  Attempts: " + progress.getAttempts());
                System.out.println("  TimeTaken: " + progress.getTimeTaken());
                System.out.println("  LastAttemptDate: " + progress.getLastAttemptDate());
            } else {
                System.out.println("RESULT: No existing progress record found");
            }

        } catch (SQLException e) {
            System.err.println("Error getting user progress: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("===== END DATABASE OPERATION =====\n");
        return progress;
    }

    @Override
    public List<UserProgress> getAllProgressForUser(int userId) {
        List<UserProgress> progressList = new ArrayList<>();
        String sql = "SELECT * FROM User_Progress WHERE User_ID = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserProgress progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
                progressList.add(progress);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return progressList;
    }

    @Override
    public void markSolved(int userId, int problemId) {
        // Validate problemId
        if (problemId <= 0) {
            System.err.println("ERROR in DAO: Invalid problemId " + problemId + ". Problem ID must be greater than 0.");
            return; // Exit the method without attempting database operation
        }
        
        try {
            // Check if progress record already exists
            UserProgress existingProgress = getUserProgress(userId, problemId);
            
            if (existingProgress != null) {
                // Calculate time taken in minutes since last attempt if problem was in progress
                Date now = new Date();
                Date lastAttempt = existingProgress.getLastAttemptDate();
                int timeTakenMinutes = 0;
                
                if (lastAttempt != null && !existingProgress.isSolved()) {
                    long diffInMillis = now.getTime() - lastAttempt.getTime();
                    int timeTakenSeconds = (int)(diffInMillis / 1000); // Convert to seconds
                    timeTakenMinutes = timeTakenSeconds / 60; // Convert to minutes
                    System.out.println("Time taken since last attempt: " + timeTakenMinutes + " minutes");
                    
                    // Add to existing time if any
                    timeTakenMinutes += existingProgress.getTimeTaken() / 60;
                    
                    // Store time in seconds
                    existingProgress.setTimeTaken(timeTakenMinutes * 60);
                }
                
                // Update as solved
                existingProgress.setSolved(true);
                existingProgress.setLastAttemptDate(now);
                
                boolean updateSuccess = updateUserProgressAndGetResult(existingProgress);
                
                if (updateSuccess) {
                    System.out.println("Marked problem " + problemId + " as solved for user " + userId + 
                                      ", time taken: " + existingProgress.getTimeTaken() / 60 + " minutes");
                }
            } else {
                // Create new record as solved with no time calculation
                UserProgress progress = new UserProgress(userId, problemId, true);
                progress.setAttempts(1);
                progress.setTimeTaken(0); // No previous record to calculate time from
                progress.setLastAttemptDate(new Date());
                addUserProgress(progress);
                // Success message is printed inside addUserProgress only if operation succeeds
            }
        } catch (Exception e) {
            System.err.println("Error in markSolved for user " + userId + ", problem " + problemId + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void markInProgress(int userId, int problemId) {
        // Validate problemId
        if (problemId <= 0) {
            System.err.println("ERROR in DAO: Invalid problemId " + problemId + ". Problem ID must be greater than 0.");
            return; // Exit the method without attempting database operation
        }
        
        try {
            // Check if progress record already exists
            UserProgress existingProgress = getUserProgress(userId, problemId);
            Date now = new Date();
            
            if (existingProgress != null) {
                // If record exists, increment attempts and reset time tracking for this new attempt
                existingProgress.setAttempts(existingProgress.getAttempts() + 1);
                existingProgress.setSolved(false);
                
                // If user clicks "In Progress" after "Solved", we start fresh time tracking
                // and don't include the previous time
                if (existingProgress.isSolved()) {
                    // We keep the existing time (won't reset it) but start tracking new time
                    System.out.println("User is starting a new attempt after previously solving the problem");
                }
                
                existingProgress.setLastAttemptDate(now);
                
                boolean updateSuccess = updateUserProgressAndGetResult(existingProgress);
                
                if (updateSuccess) {
                    System.out.println("Updated existing progress for user " + userId + ", problem " + problemId + 
                                      ", attempts now: " + existingProgress.getAttempts());
                }
            } else {
                // Create new record with attempts = 1
                UserProgress progress = new UserProgress(userId, problemId, false);
                progress.setAttempts(1);
                progress.setTimeTaken(0);
                progress.setLastAttemptDate(now);
                addUserProgress(progress);
                // Success message is printed inside addUserProgress only if operation succeeds
            }
        } catch (Exception e) {
            System.err.println("Error in markInProgress for user " + userId + ", problem " + problemId + ": " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Helper method that returns success/failure
    private boolean updateUserProgressAndGetResult(UserProgress progress) {
        String sql = "UPDATE User_Progress SET Solved = ?, Attempts = ?, TimeTaken = ?, LastAttemptDate = ? " +
                "WHERE User_ID = ? AND Problem_ID = ?";
        boolean success = false;

        System.out.println("\n===== DATABASE OPERATION - UPDATE USER PROGRESS =====");
        System.out.println("SQL: " + sql);
        System.out.println("Parameters:");
        System.out.println("  Solved = " + progress.isSolved());
        System.out.println("  Attempts = " + progress.getAttempts());
        System.out.println("  TimeTaken = " + progress.getTimeTaken());
        System.out.println("  LastAttemptDate = " + progress.getLastAttemptDate());
        System.out.println("  User_ID = " + progress.getUserId());
        System.out.println("  Problem_ID = " + progress.getProblemId());
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, progress.isSolved());
            stmt.setInt(2, progress.getAttempts());
            stmt.setInt(3, progress.getTimeTaken());
            stmt.setTimestamp(4, new Timestamp(progress.getLastAttemptDate().getTime()));
            stmt.setInt(5, progress.getUserId());
            stmt.setInt(6, progress.getProblemId());

            // Log the executed SQL with actual values
            System.out.println("Executing SQL with values: UPDATE User_Progress SET Solved = " + 
                progress.isSolved() + ", Attempts = " + 
                progress.getAttempts() + ", TimeTaken = " + 
                progress.getTimeTaken() + ", LastAttemptDate = '" + 
                new Timestamp(progress.getLastAttemptDate().getTime()) + "' " +
                "WHERE User_ID = " + progress.getUserId() + " AND Problem_ID = " + progress.getProblemId());
            
            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
            
            success = (rowsUpdated > 0);
            System.out.println("Update operation " + (success ? "successful" : "failed"));
            System.out.println("===== END DATABASE OPERATION =====\n");

        } catch (SQLException e) {
            System.err.println("Error updating user progress: " + e.getMessage());
            e.printStackTrace();
        }
        
        return success;
    }
    
    @Override
    public void updateUserProgress(UserProgress progress) {
        updateUserProgressAndGetResult(progress);
    }

    @Override
    public void insertOrUpdateProgress(UserProgress progress) {
        String sql = "INSERT INTO User_Progress (User_ID, Problem_ID, Solved, Attempts, TimeTaken, LastAttemptDate) " +
                "VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE Solved = ?, Attempts = ?, TimeTaken = ?, LastAttemptDate = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, progress.getUserId());
            stmt.setInt(2, progress.getProblemId());
            stmt.setBoolean(3, progress.isSolved());
            stmt.setInt(4, progress.getAttempts());
            stmt.setInt(5, progress.getTimeTaken());
            stmt.setTimestamp(6, new Timestamp(progress.getLastAttemptDate().getTime()));

            stmt.setBoolean(7, progress.isSolved());
            stmt.setInt(8, progress.getAttempts());
            stmt.setInt(9, progress.getTimeTaken());
            stmt.setTimestamp(10, new Timestamp(progress.getLastAttemptDate().getTime()));

            System.out.println("===== User Progress Update =====");
            System.out.println("SQL: " + sql);
            System.out.println("User ID: " + progress.getUserId());
            System.out.println("Problem ID: " + progress.getProblemId());
            System.out.println("Solved: " + progress.isSolved());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            System.out.println("===============================");

        } catch (SQLException e) {
            System.err.println("Error in insertOrUpdateProgress: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void addUserProgress(UserProgress progress) {
        // Validate progress object and its IDs
        if (progress == null) {
            System.err.println("ERROR: Cannot add null progress");
            return;
        }
        
        if (progress.getUserId() <= 0) {
            System.err.println("ERROR: Invalid userId " + progress.getUserId() + ". User ID must be greater than 0.");
            return;
        }
        
        if (progress.getProblemId() <= 0) {
            System.err.println("ERROR: Invalid problemId " + progress.getProblemId() + ". Problem ID must be greater than 0.");
            return;
        }
        
        String sql = "INSERT INTO User_Progress (User_ID, Problem_ID, Solved, Attempts, TimeTaken, LastAttemptDate) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        
        System.out.println("\n===== DATABASE OPERATION - ADD USER PROGRESS =====");
        System.out.println("SQL: " + sql);
        System.out.println("Parameters:");
        System.out.println("  User_ID = " + progress.getUserId());
        System.out.println("  Problem_ID = " + progress.getProblemId());
        System.out.println("  Solved = " + progress.isSolved());
        System.out.println("  Attempts = " + progress.getAttempts());
        System.out.println("  TimeTaken = " + progress.getTimeTaken());
        System.out.println("  LastAttemptDate = " + progress.getLastAttemptDate());
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, progress.getUserId());
            stmt.setInt(2, progress.getProblemId());
            stmt.setBoolean(3, progress.isSolved());
            stmt.setInt(4, progress.getAttempts());
            stmt.setInt(5, progress.getTimeTaken());
            stmt.setTimestamp(6, new Timestamp(progress.getLastAttemptDate().getTime()));

            // Log the executed SQL with actual values
            System.out.println("Executing SQL with values: INSERT INTO User_Progress (User_ID, Problem_ID, Solved, Attempts, TimeTaken, LastAttemptDate) " +
                "VALUES (" + 
                progress.getUserId() + ", " + 
                progress.getProblemId() + ", " + 
                progress.isSolved() + ", " + 
                progress.getAttempts() + ", " + 
                progress.getTimeTaken() + ", '" + 
                new Timestamp(progress.getLastAttemptDate().getTime()) + "')");

            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Successfully inserted new progress for user " + progress.getUserId() + 
                                  ", problem " + progress.getProblemId());
            } else {
                System.err.println("No rows affected when trying to insert progress for user " + 
                                  progress.getUserId() + ", problem " + progress.getProblemId());
            }
            System.out.println("===== END DATABASE OPERATION =====\n");

        } catch (SQLException e) {
            System.err.println("Database error when adding user progress: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUserProgress(int id) {
        String sql = "DELETE FROM User_Progress WHERE ID = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public UserProgress getUserProgressById(int id) {
        UserProgress progress = null;
        String sql = "SELECT * FROM User_Progress WHERE ID = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return progress;
    }

    @Override
    public List<UserProgress> getUserProgressByUser(int userId) {
        List<UserProgress> progressList = new ArrayList<>();
        String sql = "SELECT up.*, p.Title, p.difficulty FROM User_Progress up " +
                "JOIN Problem p ON up.problem_id = p.id " +
                "WHERE up.user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserProgress progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setTitle(rs.getString("Title"));
                progress.setDifficulty(rs.getString("Difficulty"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
                progressList.add(progress);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user progress: " + e.getMessage());
            e.printStackTrace();
        }

        return progressList;
    }

    @Override
    public List<UserProgress> getUserProgressByProblem(int problemId) {
        List<UserProgress> progressList = new ArrayList<>();
        String sql = "SELECT * FROM User_Progress WHERE Problem_ID = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, problemId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserProgress progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
                progressList.add(progress);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return progressList;
    }

    @Override
    public List<UserProgress> getAllUserProgress() {
        List<UserProgress> progressList = new ArrayList<>();
        String sql = "SELECT * FROM User_Progress";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                UserProgress progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setSolved(rs.getBoolean("Solved"));
                progress.setAttempts(rs.getInt("Attempts"));
                progress.setTimeTaken(rs.getInt("TimeTaken"));
                progress.setLastAttemptDate(rs.getTimestamp("LastAttemptDate"));
                progressList.add(progress);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return progressList;
    }
    @Override
    public List<SolvedProblem> getUserSolvedProblems(int userId) {
        List<SolvedProblem> solvedProblems = new ArrayList<>();
        String sql = "SELECT p.ID, p.Title, p.Difficulty, pt.Tag_ID, t.Name AS Tag " +
                     "FROM User_Progress up " +
                     "JOIN Problem p ON up.Problem_ID = p.ID " +
                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
                     "WHERE up.User_ID = ? AND up.Solved = TRUE";

        try (Connection conn = DBConnectionUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
        	
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                SolvedProblem solvedProblem = new SolvedProblem();
                solvedProblem.setProblemId(rs.getInt("ID"));
                solvedProblem.setProblemName(rs.getString("Title"));
                solvedProblem.setDifficulty(rs.getString("Difficulty"));
                solvedProblem.setTag(rs.getString("Tag"));
                solvedProblems.add(solvedProblem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return solvedProblems;
    }

}
