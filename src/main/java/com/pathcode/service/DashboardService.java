package com.pathcode.service;

import java.util.List;

import com.pathcode.model.Dashboard;
import com.pathcode.model.ProgressChartData;
import com.pathcode.model.UserProgress;

/**
 * Service interface for Dashboard entity
 * Defines business operations for Dashboard
 */
public interface DashboardService {
    
    /**
     * Save a new dashboard
     * @param dashboard Dashboard object to save
     * @return true if successful, false otherwise
     */
    boolean saveDashboard(Dashboard dashboard);
    
    /**
     * Update an existing dashboard
     * @param dashboard Dashboard object with updated information
     * @return true if successful, false otherwise
     */
    boolean updateDashboard(Dashboard dashboard);
    
    /**
     * Delete a dashboard
     * @param dashboardId ID of the dashboard to delete
     * @return true if successful, false otherwise
     */
    boolean deleteDashboard(int dashboardId);
    
    /**
     * Get a dashboard by ID
     * @param dashboardId ID of the dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    Dashboard getDashboard(int dashboardId);
    
    /**
     * Get a dashboard by user ID
     * @param userId ID of the user whose dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    Dashboard getDashboardByUserId(int userId);
    
    /**
     * Get a userprogree by user ID
     * @param userId ID of the user whose userprogress to retrieve
     * @return userprogress object if found, null otherwise
     */
    List<UserProgress> getUserProgresByUserId(int userId);
    
    /**
     * Get a WeeklyProgressData by user ID
     * @param userId ID of the user whose WeeklyProgressData to retrieve
     * @return WeeklyProgressData object if found, null otherwise
     */
    List<ProgressChartData> getWeeklyProgressData(int userId);
    		
    
    /**
     * Get all dashboards
     * @return List of all dashboards
     */
    List<Dashboard> getAllDashboards();
    
    
}