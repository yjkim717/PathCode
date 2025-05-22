package com.pathcode.dao;

import java.util.List;
import com.pathcode.model.Dashboard;

/**
 * Data Access Object interface for Dashboard entity
 * Defines CRUD operations for Dashboard table
 */
public interface DashboardDAO {
    
    /**
     * Save a new dashboard to the database
     * @param dashboard Dashboard object to save
     * @return true if successful, false otherwise
     */
    boolean save(Dashboard dashboard);
    
    /**
     * Update an existing dashboard in the database
     * @param dashboard Dashboard object with updated information
     * @return true if successful, false otherwise
     */
    boolean update(Dashboard dashboard);
    
    /**
     * Delete a dashboard from the database
     * @param dashboardId ID of the dashboard to delete
     * @return true if successful, false otherwise
     */
    boolean delete(int dashboardId);
    
    /**
     * Get a dashboard by ID
     * @param dashboardId ID of the dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    Dashboard get(int dashboardId);
    
    /**
     * Get a dashboard by user ID
     * @param userId ID of the user whose dashboard to retrieve
     * @return Dashboard object if found, null otherwise
     */
    Dashboard getByUserId(int userId);
    
    /**
     * Get all dashboards from the database
     * @return List of all dashboards
     */
    List<Dashboard> list();
    

    /**
     * refresh dashboards(from user progress data) to the database of dashboard
     */
    void refresh();
    

    /**
     * refresh dashboards(from user progress data) to the database for a particular user 
     */
    void refreshUser(int userId);
}