package com.pathcode.controller;
 
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.pathcode.model.LearningPath;
import com.pathcode.service.LearningPathService;
import com.pathcode.service.impl.LearningPathServiceImpl;
 
//@WebServlet("/learning-path/*")
public class LearningPathController extends HttpServlet {
    private LearningPathService learningPathService = new LearningPathServiceImpl();
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
 
        if (action == null) {
            action = "/list";
        }
 
        switch (action) {
            case "/list":
                listLearningPaths(request, response);
                break;
            case "/new":
                showNewForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteLearningPath(request, response);
                break;
            case "/view":
                viewLearningPath(request, response);
                break;
            default:
                listLearningPaths(request, response);
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
                insertLearningPath(request, response);
                break;
            case "/update":
                updateLearningPath(request, response);
                break;
            default:
                listLearningPaths(request, response);
                break;
        }
    }
 
    private void insertLearningPath(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int problemId = Integer.parseInt(request.getParameter("problemId"));
            int stage = Integer.parseInt(request.getParameter("stage"));
            int estimatedCompletionTime = Integer.parseInt(request.getParameter("estimatedCompletionTime"));
            String description = request.getParameter("description");
            boolean isRequired = request.getParameter("isRequired") != null;
           
            LearningPath learningPath = new LearningPath();
            learningPath.setUserId(userId);
            learningPath.setProblemId(problemId);
            learningPath.setStage(stage);
            learningPath.setEstimatedCompletionTime(estimatedCompletionTime);
            learningPath.setDescription(description);
            learningPath.setIsRequired(isRequired);
           
            learningPathService.addLearningPath(learningPath);
           
            request.getSession().setAttribute("successMessage", "Learning path was successfully created");
            response.sendRedirect(request.getContextPath() + "/learning-path/list");
           
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-form.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating learning path: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-form.jsp");
            dispatcher.forward(request, response);
        }
    }
 
    private void updateLearningPath(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int problemId = Integer.parseInt(request.getParameter("problemId"));
            int stage = Integer.parseInt(request.getParameter("stage"));
            int estimatedCompletionTime = Integer.parseInt(request.getParameter("estimatedCompletionTime"));
            String description = request.getParameter("description");
            boolean isRequired = request.getParameter("isRequired") != null;
            String assignedDateStr = request.getParameter("assignedDate");
           
            LearningPath learningPath = new LearningPath();
            learningPath.setId(id);
            learningPath.setUserId(userId);
            learningPath.setProblemId(problemId);
            learningPath.setStage(stage);
            learningPath.setEstimatedCompletionTime(estimatedCompletionTime);
            learningPath.setDescription(description);
            learningPath.setIsRequired(isRequired);
           
            if (assignedDateStr != null && !assignedDateStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date assignedDate = sdf.parse(assignedDateStr);
                    learningPath.setAssignedDate(assignedDate);
                } catch (ParseException e) {
                    request.setAttribute("errorMessage", "Invalid date format: " + e.getMessage());
                    showEditForm(request, response);
                    return;
                }
            }
           
            learningPathService.updateLearningPath(learningPath);
           
            request.getSession().setAttribute("successMessage", "Learning path was successfully updated");
            response.sendRedirect(request.getContextPath() + "/learning-path/list");
           
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            showEditForm(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error updating learning path: " + e.getMessage());
            showEditForm(request, response);
        }
    }
 
    private void listLearningPaths(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the user ID from the session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userID");
           
            // If userId is not in session, redirect to login
            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            }
           
            List<LearningPath> learningPaths = learningPathService.getLearningPathsByUser(userId); // Use actual userId from session
           
            // Get statistics for display
            int activeUsersCount = learningPathService.getActiveUsersCount();
            int avgCompletionTime = learningPathService.getAverageCompletionTime();
            double completionRate = learningPathService.getCompletionRate();
            Map<Integer, Integer> popularPaths = learningPathService.getPopularLearningPaths();
            Map<String, Double> difficultyDistribution = learningPathService.getPathDifficultyDistribution();
           
            // Set attributes for the JSP
            request.setAttribute("learningPaths", learningPaths);
            request.setAttribute("activeUsersCount", activeUsersCount);
            request.setAttribute("avgCompletionTime", avgCompletionTime);
            request.setAttribute("completionRate", completionRate);
            request.setAttribute("popularPaths", popularPaths);
            request.setAttribute("difficultyDistribution", difficultyDistribution);
           
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching learning paths: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
 
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-form.jsp");
        dispatcher.forward(request, response);
    }
 
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int learningPathId = Integer.parseInt(request.getParameter("id"));
            LearningPath learningPath = learningPathService.getLearningPathById(learningPathId);
           
            if (learningPath == null) {
                request.setAttribute("errorMessage", "Learning path with ID " + learningPathId + " not found");
                listLearningPaths(request, response);
                return;
            }
           
            request.setAttribute("learningPath", learningPath);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-form.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid learning path ID format");
            listLearningPaths(request, response);
        }
    }
 
    private void deleteLearningPath(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int learningPathId = Integer.parseInt(request.getParameter("id"));
           
            // Check if the learning path exists before attempting to delete
            LearningPath learningPath = learningPathService.getLearningPathById(learningPathId);
            if (learningPath == null) {
                request.setAttribute("errorMessage", "Cannot delete: Learning path with ID " + learningPathId + " not found");
                listLearningPaths(request, response);
                return;
            }
           
            learningPathService.deleteLearningPath(learningPathId);
           
            // Add a success message
            request.getSession().setAttribute("successMessage", "Learning path was successfully deleted");
            response.sendRedirect(request.getContextPath() + "/learning-path/list");
        } catch (NumberFormatException e) {
            System.err.println("Invalid learning path ID format in delete operation: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid learning path ID format");
            listLearningPaths(request, response);
        } catch (Exception e) {
            System.err.println("Error deleting learning path: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error deleting learning path: " + e.getMessage());
            listLearningPaths(request, response);
        }
    }
 
    private void viewLearningPath(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int learningPathId = Integer.parseInt(request.getParameter("id"));
            LearningPath learningPath = learningPathService.getLearningPathById(learningPathId);
           
            if (learningPath == null) {
                request.setAttribute("errorMessage", "Learning path with ID " + learningPathId + " not found");
                listLearningPaths(request, response);
                return;
            }
           
            request.setAttribute("learningPath", learningPath);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/LearningPath/learning-path-view.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid learning path ID format");
            listLearningPaths(request, response);
        }
    }
}