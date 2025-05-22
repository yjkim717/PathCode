package com.pathcode.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.pathcode.util.DatabaseInitializer;

import java.util.logging.Logger;

/**
 * Application Listener
 * Initializes resources when the application starts
 */
@WebListener
public class ApplicationListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(ApplicationListener.class.getName());
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Application starting up...");
        
        // Initialize the database
        DatabaseInitializer.initialize();
        
        LOGGER.info("Application initialization complete");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("Application shutting down...");
    }
} 