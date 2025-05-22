package com.pathcode.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pathcode.dao.DashboardDAO;
import com.pathcode.model.Dashboard;
import com.pathcode.model.ProgressChartData;
import com.pathcode.model.UserProgress;
import com.pathcode.util.DBConnectionUtil;


public class UserProgressForDashboardDAO {
    
    /**
     * Get the total number of problems attempted by a user.
     * @param userId User ID
     * @return Total problems attempted
     * @throws SQLException if a database access error occurs
     */
	public int getTotalAttempted(int userId) throws SQLException {
	    String sql = "SELECT COUNT(*) AS total_attempted FROM User_Progress WHERE user_id = ? AND attempts > 0";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("total_attempted");
	            }
	        }
	    }
	    return 0;
	}

    /**
     * Get the total number of problems solved by a user.
     * @param userId User ID
     * @return Total problems solved
     * @throws SQLException if a database access error occurs
     */
	public int getTotalSolved(int userId) throws SQLException {
	    String sql = "SELECT COUNT(*) AS total_solved FROM User_Progress WHERE user_id = ? AND solved = TRUE";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("total_solved");
	            }
	        }
	    }
	    return 0;
	}

    /**
     * Get the success rate of a user.
     * @param userId User ID
     * @return Success rate
     * @throws SQLException if a database access error occurs
     */
	public double getSuccessRate(int userId) throws SQLException {
	    String sql = "SELECT COUNT(*) AS total_attempted, " +
	                 "SUM(CASE WHEN solved = TRUE THEN 1 ELSE 0 END) AS total_solved " +
	                 "FROM User_Progress WHERE user_id = ?";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                int totalAttempted = rs.getInt("total_attempted");
	                int totalSolved = rs.getInt("total_solved");
	                double successRate =  totalAttempted > 0 ? (double) (totalSolved / totalAttempted)*100 : 0;
	                
	                DecimalFormat df = new DecimalFormat("#.##");
	                return Double.parseDouble(df.format(successRate));
	            }
	        }
	    }
	    return 0;
	}

    /**
     * Get the average time per problem solved by the user.
     * @param userId User ID
     * @return Average time per problem
     * @throws SQLException if a database access error occurs
     */
	public int getAverageTimePerProblem(int userId) throws SQLException {
	    String sql = "SELECT AVG(timetaken) AS avg_time_per_problem " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = TRUE";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("avg_time_per_problem");
	            }
	        }
	    }
	    return 0;
	}

  

    /**
     * Get the count of problems currently in progress for a user.
     * @param userId User ID
     * @return Count of problems in progress
     * @throws SQLException if a database access error occurs
     */
	public int getProblemsInProgress(int userId) throws SQLException {
	    String sql = "SELECT COUNT(*) AS problems_in_progress " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = FALSE AND attempts > 0";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("problems_in_progress");
	            }
	        }
	    }
	    return 0;
	}
    /**
     * Get the last active date of a user.
     * @param userId User ID
     * @return Last active date
     * @throws SQLException if a database access error occurs
     */
	public java.sql.Timestamp getLastActiveDate(int userId) throws SQLException {
	    String sql = "SELECT MAX(LastAttemptDate) AS last_active_date " +
	                 "FROM User_Progress WHERE user_id = ?";
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getTimestamp("last_active_date");
	            }
	        }
	    }
	    return new java.sql.Timestamp(System.currentTimeMillis()); // Default to current timestamp if no data found
	}


    /**
     * Get the weekly solved problem count of a user.
     * @param userId User ID
     * @return Weekly solved count
     * @throws SQLException if a database access error occurs
     */
	public int getWeeklySolvedCount(int userId) throws SQLException {
	    // Get the current date and subtract 7 days to find the "start of the week"
	    LocalDateTime oneWeekAgo = LocalDateTime.now().minusDays(7);
	    Timestamp oneWeekAgoTimestamp = Timestamp.valueOf(oneWeekAgo);
	    
	    String sql = "SELECT COUNT(*) AS weekly_solved_count " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = TRUE " +
	                 "AND LastAttemptDate >= ?";
	    
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        stmt.setTimestamp(2, oneWeekAgoTimestamp);
	        
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("weekly_solved_count");
	            }
	        }
	    }
	    return 0;
	}

    /**
     * Get the monthly solved problem count of a user.
     * @param userId User ID
     * @return Monthly solved count
     * @throws SQLException if a database access error occurs
     */
    public int getMonthlySolvedCount(int userId) throws SQLException{
    	LocalDateTime oneMonthAgo = LocalDateTime.now().minusDays(30);
	    Timestamp oneMonthAgoTimestamp = Timestamp.valueOf(oneMonthAgo);
	    
	    String sql = "SELECT COUNT(*) AS monthly_solved_count " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = TRUE " +
	                 "AND LastAttemptDate >= ?";
	    
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        stmt.setTimestamp(2, oneMonthAgoTimestamp);
	        
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt("monthly_solved_count");
	            }
	        }
	    }
	    return 0;
    }
    
    

	public int getCurrentStage(int userId) {
    	return 1;

	}
	
	  /**
     * Get the current streak of a user.
     * @param userId User ID
     * @return Current streak
     * @throws SQLException if a database access error occurs
     */
	public int getCurrentStreak(int userId) throws SQLException {
	    String sql = "SELECT DATEDIFF(CURRENT_DATE, LastAttemptDate) AS streak_days " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = TRUE " +
	                 "ORDER BY LastAttemptDate DESC";
	    
	    int currentStreak = 0;
	    int prevDayDiff = -1;
	    
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                int dayDiff = rs.getInt("streak_days");
	                
	                // If consecutive day, increment current streak
	                if (prevDayDiff == -1 || dayDiff == prevDayDiff + 1) {
	                    currentStreak++;
	                    prevDayDiff = dayDiff;
	                } else {
	                    // Streak ended, break out
	                    break;
	                }
	            }
	        }
	    }
	    return currentStreak;
	}


    /**
     * Get the longest streak of a user.
     * @param userId User ID
     * @return Longest streak
     * @throws SQLException if a database access error occurs
     */
	public int getLongestStreak(int userId) throws SQLException {
	    String sql = "SELECT DATEDIFF(CURRENT_DATE, LastAttemptDate) AS streak_days " +
	                 "FROM User_Progress WHERE user_id = ? AND solved = TRUE " +
	                 "ORDER BY LastAttemptDate DESC";
	    
	    int longestStreak = 0;
	    int currentStreak = 0;
	    int prevDayDiff = -1;
	    
	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	         
	        stmt.setInt(1, userId);
	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                int dayDiff = rs.getInt("streak_days");
	                
	                // If consecutive day, increment current streak
	                if (prevDayDiff == -1 || dayDiff == prevDayDiff + 1) {
	                    currentStreak++;
	                    prevDayDiff = dayDiff;
	                } else {
	                    // Streak ended, compare with longest streak
	                    longestStreak = Math.max(longestStreak, currentStreak);
	                    currentStreak = 1;  // Reset for new streak
	                    prevDayDiff = dayDiff;
	                }
	            }
	            // Final check to account for streak that ends with the latest date
	            longestStreak = Math.max(longestStreak, currentStreak);
	        }
	    }
	    return longestStreak;
	}

    public List<UserProgress> getUserProgressByUser(int userId) {
        List<UserProgress> progressList = new ArrayList<>();
        String sql = "SELECT up.*, p.title FROM User_Progress up " +
                "JOIN Problem p ON up.problem_id = p.id " +
                "WHERE up.user_id = ? " +
                "ORDER BY up.LastAttemptDate DESC " +
                "LIMIT 3";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                UserProgress progress = new UserProgress();
                progress.setId(rs.getInt("ID"));
                progress.setUserId(rs.getInt("User_ID"));
                progress.setProblemId(rs.getInt("Problem_ID"));
                progress.setDifficulty(rs.getString("Title"));
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
    public List<ProgressChartData> getWeeklyProgressData(int userId) {
        List<ProgressChartData> chartDataList = new ArrayList<>();
        
        // SQL to get the last 6 weeks' data
        String sql = "SELECT " +
                     "  WEEK(up.lastAttemptDate) AS week, " +
                     "  COUNT(up.id) AS problemsSolved, " +
                     "  AVG(CASE WHEN up.solved = TRUE THEN 1 ELSE 0 END) * 100 AS successRate " +
                     "FROM User_Progress up " +
                     "WHERE up.user_id = ? " +
                     "AND up.lastAttemptDate >= CURDATE() - INTERVAL 6 WEEK " +
                     "GROUP BY week " +
                     "ORDER BY week DESC LIMIT 6";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            // Create a map of week to data for easy lookup
            Map<Integer, ProgressChartData> weekDataMap = new HashMap<>();
            
            // Process result set and store the data
            while (rs.next()) {
                int week = rs.getInt("week");
                int problemsSolved = rs.getInt("problemsSolved");
                double successRate = rs.getDouble("successRate");

                ProgressChartData data = new ProgressChartData(week, problemsSolved, successRate);
                weekDataMap.put(week, data);
            }

            // Ensure all weeks from the last 6 weeks are present, even if missing in the data
            for (int i = 0; i < 6; i++) {
                int week = getWeekFromOffset(-i);
                if (!weekDataMap.containsKey(week)) {
                    // If no data exists for this week, create an entry with 0 values
                    weekDataMap.put(week, new ProgressChartData(week, 0, 0));
                }
            }

            // Add data to chartDataList sorted by week
            for (int i = 0; i < 6; i++) {
                int week = getWeekFromOffset(-i);
                chartDataList.add(weekDataMap.get(week));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return chartDataList;
    }

    // Helper method to get the week for a given offset (e.g., current week is 0, previous week is -1, etc.)
    private int getWeekFromOffset(int offset) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_YEAR, offset);
        return calendar.get(Calendar.WEEK_OF_YEAR);
    }


}
