package com.pathcode.dao.impl;

import com.pathcode.dao.DashboardDAO;
import com.pathcode.model.Dashboard;
import com.pathcode.util.DBConnectionUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of DashboardDAO interface
 * Provides CRUD operations for Dashboard entity
 */
public class DashboardDAOImpl implements DashboardDAO {
    
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private Statement statement = null;
    UserProgressForDashboardDAO userProgressForDashboardDAO = new UserProgressForDashboardDAO();
    
    /**
     * Save a new dashboard to the database
     * @param dashboard Dashboard object to save
     * @return true if successful, false otherwise
     */
    @Override
    public boolean save(Dashboard dashboard) {
        boolean flag = false;
        java.sql.Timestamp timestamp = null;
        try {
            String sql = "INSERT INTO Dashboard(User_ID, Total_Problems_Attempted, Total_Problems_Solved, " +
                         "Success_Rate, Average_Time_Per_Problem, Current_Stage, Problems_In_Progress, " +
                         "Last_Active_Date, Weekly_Solved_Count, Monthly_Solved_Count, Favorite_Tag_ID, " +
                         "Current_Streak, Longest_Streak) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, dashboard.getUserId());
            preparedStatement.setInt(2, dashboard.getTotalProblemsAttempted());
            preparedStatement.setInt(3, dashboard.getTotalProblemsSolved());
            preparedStatement.setDouble(4, dashboard.getSuccessRate());
            preparedStatement.setInt(5, dashboard.getAverageTimePerProblem());
            preparedStatement.setInt(6, dashboard.getCurrentStage());
            preparedStatement.setInt(7, dashboard.getProblemsInProgress());
            if (dashboard.getLastActiveDate() != null) {
                timestamp = new java.sql.Timestamp(dashboard.getLastActiveDate().getTime());
            } else {
                timestamp = new java.sql.Timestamp(System.currentTimeMillis());  
                }
            preparedStatement.setTimestamp(8, timestamp);

            preparedStatement.setInt(9, dashboard.getWeeklySolvedCount());
            preparedStatement.setInt(10, dashboard.getMonthlySolvedCount());
            
            // Handle nullable favoriteTagId
            if (dashboard.getFavoriteTagId() != null) {
                preparedStatement.setInt(11, dashboard.getFavoriteTagId());
            } else {
                preparedStatement.setNull(11, java.sql.Types.INTEGER);
            }

            preparedStatement.setInt(12, dashboard.getCurrentStreak());
            preparedStatement.setInt(13, dashboard.getLongestStreak());
            preparedStatement.executeUpdate();
            flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
    
    /**
     * Update an existing dashboard in the database
     * @param dashboard Dashboard object with updated information
     * @return true if successful, false otherwise
     */
    @Override
    public boolean update(Dashboard dashboard) {
        boolean flag = false;
        try {
            String sql = "UPDATE Dashboard SET User_ID = ?, Total_Problems_Attempted = ?, " +
                         "Total_Problems_Solved = ?, Success_Rate = ?, Average_Time_Per_Problem = ?, " +
                         "Current_Stage = ?, Problems_In_Progress = ?, Last_Active_Date = ?, " +
                         "Weekly_Solved_Count = ?, Monthly_Solved_Count = ?, Favorite_Tag_ID = ?, " +
                         "Current_Streak = ?, Longest_Streak = ? WHERE User_ID = ?"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, dashboard.getUserId());
            preparedStatement.setInt(2, dashboard.getTotalProblemsAttempted());
            preparedStatement.setInt(3, dashboard.getTotalProblemsSolved());
            preparedStatement.setDouble(4, dashboard.getSuccessRate());
            preparedStatement.setInt(5, dashboard.getAverageTimePerProblem());
            preparedStatement.setInt(6, dashboard.getCurrentStage());
            preparedStatement.setInt(7, dashboard.getProblemsInProgress());
            preparedStatement.setTimestamp(8, new java.sql.Timestamp(dashboard.getLastActiveDate().getTime()));
            preparedStatement.setInt(9, dashboard.getWeeklySolvedCount());
            preparedStatement.setInt(10, dashboard.getMonthlySolvedCount());
            
            // Handle nullable favoriteTagId
            if (dashboard.getFavoriteTagId() != null) {
                preparedStatement.setInt(11, dashboard.getFavoriteTagId());
            } else {
                preparedStatement.setNull(11, java.sql.Types.INTEGER);
            }
            
            preparedStatement.setInt(12, dashboard.getCurrentStreak());
            preparedStatement.setInt(13, dashboard.getLongestStreak());
            preparedStatement.setInt(14, dashboard.getUserId());
            preparedStatement.executeUpdate();
            flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
    
    /**
     * Delete a dashboard from the database
     * @param dashboardId ID of the dashboard to delete
     * @return true if successful, false otherwise
     */
    @Override
    public boolean delete(int dashboardId) {
        boolean flag = false;
        try {
            String sql = "DELETE FROM Dashboard WHERE ID = ?"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, dashboardId);
            preparedStatement.executeUpdate();
            flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
    
    /**
     * Get a dashboard by ID
     * @param dashboardId ID of the dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    @Override
    public Dashboard get(int dashboardId) {
        Dashboard dashboard = null;
        try {
            String sql = "SELECT * FROM Dashboard WHERE ID = ?"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, dashboardId);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                dashboard = mapResultSetToDashboard(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dashboard;
    }
    
    /**
     * Get a dashboard by user ID
     * @param userId ID of the user whose dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    @Override
    public Dashboard getByUserId(int userId) {
        Dashboard dashboard = null;
        try {
            String sql = "SELECT * FROM Dashboard WHERE User_ID = ?"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                dashboard = mapResultSetToDashboard(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dashboard;
    }
    
    /**
     * Get all dashboards from the database
     * @return List of all dashboards
     */
    @Override
    public List<Dashboard> list() {
        List<Dashboard> dashboardList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Dashboard"; 
            connection = DBConnectionUtil.getConnection();
            
            if (connection == null) {
                System.err.println("ERROR: Database connection is null in list() method of DashboardDAOImpl");
                return dashboardList; // Return empty list instead of NPE
            }
            
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);
            
            while (resultSet.next()) {
                Dashboard dashboard = mapResultSetToDashboard(resultSet);
                dashboardList.add(dashboard);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dashboardList;
    }
    
    /**
     * Helper method to map ResultSet to Dashboard object
     * @param resultSet ResultSet containing dashboard data
     * @return Dashboard object
     * @throws SQLException if a database access error occurs
     */
    private Dashboard mapResultSetToDashboard(ResultSet resultSet) throws SQLException {
        Dashboard dashboard = new Dashboard();
        dashboard.setId(resultSet.getInt("ID"));
        dashboard.setUserId(resultSet.getInt("User_ID"));
        dashboard.setTotalProblemsAttempted(resultSet.getInt("Total_Problems_Attempted"));
        dashboard.setTotalProblemsSolved(resultSet.getInt("Total_Problems_Solved"));
        dashboard.setSuccessRate(resultSet.getDouble("Success_Rate"));
        dashboard.setAverageTimePerProblem(resultSet.getInt("Average_Time_Per_Problem"));
        dashboard.setCurrentStage(resultSet.getInt("Current_Stage"));
        dashboard.setProblemsInProgress(resultSet.getInt("Problems_In_Progress"));
        dashboard.setLastActiveDate(resultSet.getTimestamp("Last_Active_Date"));
        dashboard.setWeeklySolvedCount(resultSet.getInt("Weekly_Solved_Count"));
        dashboard.setMonthlySolvedCount(resultSet.getInt("Monthly_Solved_Count"));
        
        // Handle nullable favoriteTagId
        int favoriteTagId = resultSet.getInt("Favorite_Tag_ID");
        if (!resultSet.wasNull()) {
            dashboard.setFavoriteTagId(favoriteTagId);
        }
        
        dashboard.setCurrentStreak(resultSet.getInt("Current_Streak"));
        dashboard.setLongestStreak(resultSet.getInt("Longest_Streak"));
        return dashboard;
    }
    
    @Override
    public void refresh() {
        List<Dashboard> dashboardList = new ArrayList<>();
        try {
            String sql = "SELECT Id FROM User"; 
            connection = DBConnectionUtil.getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);
            
            while (resultSet.next()) {
                Dashboard dashboard = helperRefresh(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return;
    }
  
    @Override
    public void refreshUser(int userId) {
        List<Dashboard> dashboardList = new ArrayList<>();
        try {
            String sql = "SELECT Id FROM User WHERE id = ?"; 
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();

            
            while (resultSet.next()) {
                Dashboard dashboard = helperRefresh(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                DBConnectionUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return;
    }
    
    
    private Dashboard helperRefresh(ResultSet resultSet) throws SQLException {
    	 int userId = resultSet.getInt("Id");
        Dashboard dashboard = new Dashboard();
        dashboard.setUserId(userId);

        
        // Fetch data from the DAO
        dashboard.setTotalProblemsAttempted(userProgressForDashboardDAO.getTotalAttempted(userId));
        dashboard.setTotalProblemsSolved(userProgressForDashboardDAO.getTotalSolved(userId));
        dashboard.setSuccessRate(userProgressForDashboardDAO.getSuccessRate(userId));
        dashboard.setAverageTimePerProblem(userProgressForDashboardDAO.getAverageTimePerProblem(userId));
        dashboard.setCurrentStage(userProgressForDashboardDAO.getCurrentStage(userId));
        dashboard.setProblemsInProgress(userProgressForDashboardDAO.getProblemsInProgress(userId));
        dashboard.setLastActiveDate(userProgressForDashboardDAO.getLastActiveDate(userId));
        dashboard.setWeeklySolvedCount(userProgressForDashboardDAO.getWeeklySolvedCount(userId));
        dashboard.setMonthlySolvedCount(userProgressForDashboardDAO.getMonthlySolvedCount(userId));
        dashboard.setCurrentStreak(userProgressForDashboardDAO.getCurrentStreak(userId));
        dashboard.setLongestStreak(userProgressForDashboardDAO.getLongestStreak(userId));
        
        if (dashboardExists(dashboard.getUserId())) {
            update(dashboard);
        } else {
            save(dashboard);
        }
        return dashboard;
    }
    
    private boolean dashboardExists(int userId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM Dashboard WHERE User_ID = ?";
        
        try (
            Connection conn = DBConnectionUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return exists;
    }
    
}