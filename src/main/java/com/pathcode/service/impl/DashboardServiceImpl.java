package com.pathcode.service.impl;

import java.util.List;

import com.pathcode.dao.DashboardDAO;
import com.pathcode.dao.impl.DashboardDAOImpl;
import com.pathcode.dao.impl.UserProgressForDashboardDAO;
import com.pathcode.model.Dashboard;
import com.pathcode.model.ProgressChartData;
import com.pathcode.model.UserProgress;
import com.pathcode.service.DashboardService;

/**
 * Implementation of DashboardService interface
 * Provides business operations for Dashboard entity
 */
public class DashboardServiceImpl implements DashboardService {
    
    private DashboardDAO dashboardDAO;
    private UserProgressForDashboardDAO userProgressForDashboardDAO;
    
    // Constructor
    public DashboardServiceImpl() {
        this.dashboardDAO = new DashboardDAOImpl();
        this.userProgressForDashboardDAO = new UserProgressForDashboardDAO();
    }
    
    /**
     * Save a new dashboard
     * @param dashboard Dashboard object to save
     * @return true if successful, false otherwise
     */
    @Override
    public boolean saveDashboard(Dashboard dashboard) {
        return dashboardDAO.save(dashboard);
    }
    
    /**
     * Update an existing dashboard
     * @param dashboard Dashboard object with updated information
     * @return true if successful, false otherwise
     */
    @Override
    public boolean updateDashboard(Dashboard dashboard) {
        return dashboardDAO.update(dashboard);
    }
    
    /**
     * Delete a dashboard
     * @param dashboardId ID of the dashboard to delete
     * @return true if successful, false otherwise
     */
    @Override
    public boolean deleteDashboard(int dashboardId) {
        return dashboardDAO.delete(dashboardId);
    }
    
    /**
     * Get a dashboard by ID
     * @param dashboardId ID of the dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    @Override
    public Dashboard getDashboard(int dashboardId) {
        return dashboardDAO.get(dashboardId);
    }
    
    /**
     * Get a dashboard by user ID
     * @param userId ID of the user whose dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    @Override
    public Dashboard getDashboardByUserId(int userId) {
    	dashboardDAO.refreshUser(userId);
        return dashboardDAO.getByUserId(userId);
    }
    
    /**
     * Get a dashboard by user ID
     * @param userId ID of the user whose dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    @Override
    public List<UserProgress> getUserProgresByUserId(int userId) {
        return userProgressForDashboardDAO.getUserProgressByUser(userId);
    }
    
    /**
     * Get a WeeklyProgressData by user ID
     * @param userId ID of the user whose WeeklyProgressData to retrieve
     * @return WeeklyProgressData object if found, null otherwise
     */
    @Override
    public List<ProgressChartData> getWeeklyProgressData(int userId){
        return userProgressForDashboardDAO.getWeeklyProgressData(userId);
    }
    
    
    /**
     * Get all dashboards
     * @return List of all dashboards
     */
    @Override
    public List<Dashboard> getAllDashboards() {
        return dashboardDAO.list();
    }
}