package com.pathcode.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pathcode.model.Dashboard;
import com.pathcode.model.ProgressChartData;
import com.pathcode.model.UserProgress;
import com.pathcode.service.DashboardService;
import com.pathcode.service.UserProgressService;
import com.pathcode.service.impl.DashboardServiceImpl;
import com.pathcode.service.impl.UserProgressServiceImpl;

/**
 * Controller for Dashboard entity
 * Handles HTTP requests for Dashboard CRUD operations
 */
// Comment out WebServlet annotation since we're using web.xml for mapping
// @WebServlet("/dashboard/*")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DashboardService dashboardService;
    private UserProgressService userProgressService;
    
    public DashboardController() {
        dashboardService = new DashboardServiceImpl();
        userProgressService = new UserProgressServiceImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        switch (action) {
            case "/new":
                showNewForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteDashboard(request, response);
                break;
            case "/view":
            	viewDashboardByUser(request, response);
                break;
            default:
                listDashboards(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        switch (action) {
            case "/insert":
                insertDashboard(request, response);
                break;
            case "/update":
                updateDashboard(request, response);
                break;
            default:
                listDashboards(request, response);
                break;
        }
    }
    
    private void listDashboards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the logged-in user's ID from the session
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userID") != null) {
            int userId = (int) session.getAttribute("userID");
            
            // Option 1: Redirect to the user's specific dashboard view
            response.sendRedirect(request.getContextPath() + "/dashboard/view?userID=" + userId);
            return;
            
            // Option 2 (commented out): Filter the list to only show the user's dashboard
            /*
            Dashboard userDashboard = dashboardService.getDashboardByUserId(userId);
            List<Dashboard> dashboardList = new ArrayList<>();
            if (userDashboard != null) {
                dashboardList.add(userDashboard);
            }
            request.setAttribute("dashboardList", dashboardList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-list.jsp");
            dispatcher.forward(request, response);
            */
        } else {
            // For admin users or if user is not logged in, show all dashboards (or redirect to login)
            List<Dashboard> dashboardList = dashboardService.getAllDashboards();
            request.setAttribute("dashboardList", dashboardList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-list.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-form.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int dashboardId = Integer.parseInt(request.getParameter("id"));
        Dashboard dashboard = dashboardService.getDashboard(dashboardId);
        request.setAttribute("dashboard", dashboard);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-form.jsp");
        dispatcher.forward(request, response);
    }
    
    private void viewDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int dashboardId = Integer.parseInt(request.getParameter("id"));
        Dashboard dashboard = dashboardService.getDashboard(dashboardId);
        request.setAttribute("dashboard", dashboard);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-view.jsp");
        dispatcher.forward(request, response);
    }
    
    private void viewDashboardByUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID either from request parameter or from session
        Integer userId = null;
        String userIdParam = request.getParameter("userID");
        
        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                // Invalid userID parameter, will try to get from session
            }
        }
        
        // If userID not provided in request or invalid, get from session
        if (userId == null) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userID") != null) {
                userId = (Integer) session.getAttribute("userID");
            } else {
                // No user ID found, redirect to login
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            }
        }
        
        Dashboard dashboard = dashboardService.getDashboardByUserId(userId);
        List<UserProgress> listUserProgress = dashboardService.getUserProgresByUserId(userId);
        List<ProgressChartData> progressData = dashboardService.getWeeklyProgressData(userId);
        List<Integer> problemsSolvedList = new ArrayList<>();
        List<Double> successRateList = new ArrayList<>();
        for (ProgressChartData data : progressData) {
            problemsSolvedList.add(data.getProblemsSolved());
            successRateList.add(data.getSuccessRate());
        }
        request.setAttribute("dashboard", dashboard);
        request.setAttribute("listUserProgress", listUserProgress);
        request.setAttribute("problemsSolvedList", problemsSolvedList);
        request.setAttribute("successRateList", successRateList);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard-view.jsp");
        dispatcher.forward(request, response);
    }
    
    private void insertDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int totalProblemsAttempted = Integer.parseInt(request.getParameter("totalProblemsAttempted"));
        int totalProblemsSolved = Integer.parseInt(request.getParameter("totalProblemsSolved"));
        double successRate = Double.parseDouble(request.getParameter("successRate"));
        int averageTimePerProblem = Integer.parseInt(request.getParameter("averageTimePerProblem"));
        int currentStage = Integer.parseInt(request.getParameter("currentStage"));
        int problemsInProgress = Integer.parseInt(request.getParameter("problemsInProgress"));
        Date lastActiveDate = new Date(); // Current date
        int weeklySolvedCount = Integer.parseInt(request.getParameter("weeklySolvedCount"));
        int monthlySolvedCount = Integer.parseInt(request.getParameter("monthlySolvedCount"));
        
        // Handle nullable favoriteTagId
        Integer favoriteTagId = null;
        String favoriteTagIdStr = request.getParameter("favoriteTagId");
        if (favoriteTagIdStr != null && !favoriteTagIdStr.isEmpty()) {
            favoriteTagId = Integer.parseInt(favoriteTagIdStr);
        }
        
        int currentStreak = Integer.parseInt(request.getParameter("currentStreak"));
        int longestStreak = Integer.parseInt(request.getParameter("longestStreak"));
        
        Dashboard dashboard = new Dashboard();
        dashboard.setUserId(userId);
        dashboard.setTotalProblemsAttempted(totalProblemsAttempted);
        dashboard.setTotalProblemsSolved(totalProblemsSolved);
        dashboard.setSuccessRate(successRate);
        dashboard.setAverageTimePerProblem(averageTimePerProblem);
        dashboard.setCurrentStage(currentStage);
        dashboard.setProblemsInProgress(problemsInProgress);
        dashboard.setLastActiveDate(lastActiveDate);
        dashboard.setWeeklySolvedCount(weeklySolvedCount);
        dashboard.setMonthlySolvedCount(monthlySolvedCount);
        dashboard.setFavoriteTagId(favoriteTagId);
        dashboard.setCurrentStreak(currentStreak);
        dashboard.setLongestStreak(longestStreak);
        
        dashboardService.saveDashboard(dashboard);
        response.sendRedirect(request.getContextPath() + "/dashboard/list");
    }
    
    private void updateDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int totalProblemsAttempted = Integer.parseInt(request.getParameter("totalProblemsAttempted"));
        int totalProblemsSolved = Integer.parseInt(request.getParameter("totalProblemsSolved"));
        double successRate = Double.parseDouble(request.getParameter("successRate"));
        int averageTimePerProblem = Integer.parseInt(request.getParameter("averageTimePerProblem"));
        int currentStage = Integer.parseInt(request.getParameter("currentStage"));
        int problemsInProgress = Integer.parseInt(request.getParameter("problemsInProgress"));
        
        // Parse date if provided, otherwise use current date
        Date lastActiveDate;
        String lastActiveDateStr = request.getParameter("lastActiveDate");
        if (lastActiveDateStr != null && !lastActiveDateStr.isEmpty()) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                lastActiveDate = dateFormat.parse(lastActiveDateStr);
            } catch (ParseException e) {
                lastActiveDate = new Date(); // Use current date if parsing fails
            }
        } else {
            lastActiveDate = new Date();
        }
        
        int weeklySolvedCount = Integer.parseInt(request.getParameter("weeklySolvedCount"));
        int monthlySolvedCount = Integer.parseInt(request.getParameter("monthlySolvedCount"));
        
        // Handle nullable favoriteTagId
        Integer favoriteTagId = null;
        String favoriteTagIdStr = request.getParameter("favoriteTagId");
        if (favoriteTagIdStr != null && !favoriteTagIdStr.isEmpty()) {
            favoriteTagId = Integer.parseInt(favoriteTagIdStr);
        }
        
        int currentStreak = Integer.parseInt(request.getParameter("currentStreak"));
        int longestStreak = Integer.parseInt(request.getParameter("longestStreak"));
        
        Dashboard dashboard = new Dashboard();
        dashboard.setId(id);
        dashboard.setUserId(userId);
        dashboard.setTotalProblemsAttempted(totalProblemsAttempted);
        dashboard.setTotalProblemsSolved(totalProblemsSolved);
        dashboard.setSuccessRate(successRate);
        dashboard.setAverageTimePerProblem(averageTimePerProblem);
        dashboard.setCurrentStage(currentStage);
        dashboard.setProblemsInProgress(problemsInProgress);
        dashboard.setLastActiveDate(lastActiveDate);
        dashboard.setWeeklySolvedCount(weeklySolvedCount);
        dashboard.setMonthlySolvedCount(monthlySolvedCount);
        dashboard.setFavoriteTagId(favoriteTagId);
        dashboard.setCurrentStreak(currentStreak);
        dashboard.setLongestStreak(longestStreak);
        
        dashboardService.updateDashboard(dashboard);
        response.sendRedirect(request.getContextPath() + "/dashboard/list");
    }
    
    private void deleteDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int dashboardId = Integer.parseInt(request.getParameter("id"));
        dashboardService.deleteDashboard(dashboardId);
        response.sendRedirect(request.getContextPath() + "/dashboard/list");
    }
}