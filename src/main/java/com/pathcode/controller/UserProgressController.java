package com.pathcode.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pathcode.dao.UserProgressDAO;
import com.pathcode.dao.impl.UserProgressDAOImpl;
import com.pathcode.model.UserProgress;

//@WebServlet("/progress/*")
public class UserProgressController extends HttpServlet {

    private UserProgressDAO progressDAO;

    public void init() {
        progressDAO = new UserProgressDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/view":
                    viewProgress(request, response);
                    break;
                case "/user":
                    listByUser(request, response);
                    break;
                case "/problem":
                    listByProblem(request, response);
                    break;
                case "/mark-solved":
                    markAsSolved(request, response);
                    break;
                case "/mark-inprogress":
                    markAsInProgress(request, response);
                    break;
                case "/list":
                default:
                    listAllProgress(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        try {
            switch (action) {
                case "/update":
                    updateProgress(request, response);
                    break;
                case "/mark-solved":
                    markAsSolved(request, response);
                    break;
                case "/mark-inprogress":
                    markAsInProgress(request, response);
                    break;
                case "/delete":
                    deleteProgress(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listAllProgress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<UserProgress> progressList = progressDAO.getAllUserProgress();
        request.setAttribute("progressList", progressList);
        request.getRequestDispatcher("/WEB-INF/views/progress/progress-list.jsp").forward(request, response);
    }

    private void listByUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        List<UserProgress> progressList = progressDAO.getUserProgressByUser(userId);
        request.setAttribute("progressList", progressList);
        request.getRequestDispatcher("/WEB-INF/views/progress/user-progress.jsp").forward(request, response);
    }

    private void listByProblem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int problemId = Integer.parseInt(request.getParameter("problemId"));
        List<UserProgress> progressList = progressDAO.getUserProgressByProblem(problemId);
        request.setAttribute("progressList", progressList);
        request.getRequestDispatcher("/WEB-INF/views/progress/problem-progress.jsp").forward(request, response);
    }

    private void viewProgress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        UserProgress progress = progressDAO.getUserProgressById(id);
        request.setAttribute("progress", progress);
        request.getRequestDispatcher("/WEB-INF/views/progress/progress-view.jsp").forward(request, response);
    }

    private void updateProgress(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        UserProgress progress = new UserProgress(
            Integer.parseInt(request.getParameter("userId")),
            Integer.parseInt(request.getParameter("problemId")),
            Boolean.parseBoolean(request.getParameter("solved"))
        );
        
        progress.setAttempts(Integer.parseInt(request.getParameter("Attempts")));
        progress.setTimeTaken(Integer.parseInt(request.getParameter("TimeTaken")));
        progress.setLastAttemptDate(new Date());
        
        progressDAO.insertOrUpdateProgress(progress);
        response.sendRedirect(request.getContextPath() + "/progress/view?id=" + progress.getId());
    }

    private void markAsSolved(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Log all request parameters and headers for debugging
            System.out.println("\n==== PROGRESS TRACKING - MARK AS SOLVED ====");
            System.out.println("REQUEST URL: " + request.getRequestURL() + "?" + request.getQueryString());
            System.out.println("REMOTE IP: " + request.getRemoteAddr());
            System.out.println("USER AGENT: " + request.getHeader("User-Agent"));
            System.out.println("REFERER: " + request.getHeader("Referer"));
            
            // Log all parameters
            System.out.println("\nREQUEST PARAMETERS:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println(key + " = " + String.join(", ", value));
            });
            
            // Log session attributes
            System.out.println("\nSESSION ATTRIBUTES:");
            java.util.Enumeration<String> sessionAttrs = request.getSession().getAttributeNames();
            while (sessionAttrs.hasMoreElements()) {
                String attrName = sessionAttrs.nextElement();
                System.out.println(attrName + " = " + request.getSession().getAttribute(attrName));
            }
            
            String userIdParam = request.getParameter("userId");
            String problemIdParam = request.getParameter("problemId");
            
            System.out.println("\nPARSED PARAMETERS:");
            System.out.println("userId parameter: " + userIdParam);
            System.out.println("problemId parameter: " + problemIdParam);
            
            if (userIdParam == null || userIdParam.isEmpty() || problemIdParam == null || problemIdParam.isEmpty()) {
                System.err.println("ERROR: Missing userId or problemId parameter");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId or problemId parameter");
                return;
            }
            
            int userId = Integer.parseInt(userIdParam);
            int problemId = Integer.parseInt(problemIdParam);
            
            System.out.println("Parsed userId: " + userId);
            System.out.println("Parsed problemId: " + problemId);
            
            // Add validation to ensure problemId is valid
            if (problemId <= 0) {
                System.err.println("ERROR: Invalid problemId " + problemId + ". Problem ID must be greater than 0.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid problemId. Problem ID must be greater than 0.");
                return;
            }
            
            System.out.println("UserProgressController: Marking problem " + problemId + " as SOLVED for user " + userId);
            
            progressDAO.markSolved(userId, problemId);
            System.out.println("==== END PROGRESS TRACKING ====\n");
            
            // Redirect back to the problem list
            response.sendRedirect(request.getContextPath() + "/problem/list");
        } catch (Exception e) {
            System.err.println("Error in markAsSolved: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing your request: " + e.getMessage());
        }
    }

    private void markAsInProgress(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Log all request parameters and headers for debugging
            System.out.println("\n==== PROGRESS TRACKING - MARK IN PROGRESS ====");
            System.out.println("REQUEST URL: " + request.getRequestURL() + "?" + request.getQueryString());
            System.out.println("REMOTE IP: " + request.getRemoteAddr());
            System.out.println("USER AGENT: " + request.getHeader("User-Agent"));
            System.out.println("REFERER: " + request.getHeader("Referer"));
            
            // Log all parameters
            System.out.println("\nREQUEST PARAMETERS:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println(key + " = " + String.join(", ", value));
            });
            
            // Log session attributes
            System.out.println("\nSESSION ATTRIBUTES:");
            java.util.Enumeration<String> sessionAttrs = request.getSession().getAttributeNames();
            while (sessionAttrs.hasMoreElements()) {
                String attrName = sessionAttrs.nextElement();
                System.out.println(attrName + " = " + request.getSession().getAttribute(attrName));
            }
            
            String userIdParam = request.getParameter("userId");
            String problemIdParam = request.getParameter("problemId");
            
            System.out.println("\nPARSED PARAMETERS:");
            System.out.println("userId parameter: " + userIdParam);
            System.out.println("problemId parameter: " + problemIdParam);
            
            if (userIdParam == null || userIdParam.isEmpty() || problemIdParam == null || problemIdParam.isEmpty()) {
                System.err.println("ERROR: Missing userId or problemId parameter");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId or problemId parameter");
                return;
            }
            
            int userId = Integer.parseInt(userIdParam);
            int problemId = Integer.parseInt(problemIdParam);
            
            System.out.println("Parsed userId: " + userId);
            System.out.println("Parsed problemId: " + problemId);
            
            // Add validation to ensure problemId is valid
            if (problemId <= 0) {
                System.err.println("ERROR: Invalid problemId " + problemId + ". Problem ID must be greater than 0.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid problemId. Problem ID must be greater than 0.");
                return;
            }
            
            System.out.println("UserProgressController: Marking problem " + problemId + " as IN PROGRESS for user " + userId);
            
            progressDAO.markInProgress(userId, problemId);
            System.out.println("==== END PROGRESS TRACKING ====\n");
            
            // Redirect back to the problem list
            response.sendRedirect(request.getContextPath() + "/problem/list");
        } catch (Exception e) {
            System.err.println("Error in markAsInProgress: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing your request: " + e.getMessage());
        }
    }

    private void deleteProgress(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        progressDAO.deleteUserProgress(id);
        response.sendRedirect(request.getContextPath() + "/progress/list");
    }
}