package com.pathcode.listener;

import java.util.logging.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.pathcode.util.DatabaseInitializer;

/**
 * Application Lifecycle Listener for database initialization
 */
@WebListener
public class DatabaseInitializerListener implements ServletContextListener {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializerListener.class.getName());
    
    /**
     * Initialize database when the web application is starting up
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Initializing database at application startup...");
        try {
            DatabaseInitializer.initialize();
            LOGGER.info("Database initialization completed successfully");
        } catch (Exception e) {
            LOGGER.severe("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Clean up when the web application is shutting down
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("Application shutting down");
    }
} 