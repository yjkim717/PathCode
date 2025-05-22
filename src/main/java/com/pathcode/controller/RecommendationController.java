//package com.pathcode.controller;
//
//import com.pathcode.model.Recommendation;
//import com.pathcode.service.RecommendationService;
//import com.pathcode.service.impl.RecommendationServiceImpl;
//import com.pathcode.util.DBConnectionUtil;
//import com.pathcode.dao.UserProgressDAO;
//import com.pathcode.dao.impl.UserProgressDAOImpl;
//import com.pathcode.dao.RecommendationDAO;
//import com.pathcode.dao.impl.RecommendationDAOImpl;
//
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.Connection;
//import java.util.List;
//
//public class RecommendationController extends HttpServlet {
//
//    private RecommendationService recommendationService;
//
//    public RecommendationController() {
//    	Connection connection = DBConnectionUtil.getConnection();
//        UserProgressDAO userProgressDAO = new UserProgressDAOImpl(); 
//        RecommendationDAO recommendationDAO = new RecommendationDAOImpl(connection, userProgressDAO);
//        this.recommendationService = new RecommendationServiceImpl(recommendationDAO);
//    
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int userId = Integer.parseInt(request.getParameter("userID"));
//        
//        List<Recommendation> recommendations = recommendationService.generateRecommendations(userId);
//        request.setAttribute("recommendations", recommendations);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/Recommendation/recommendation.jsp");
//        dispatcher.forward(request, response);
//    }
//
//}
//
package com.pathcode.controller;

import com.pathcode.model.Recommendation;
import com.pathcode.service.RecommendationService;
import com.pathcode.service.impl.RecommendationServiceImpl;
import com.pathcode.util.DBConnectionUtil;
import com.pathcode.dao.UserProgressDAO;
import com.pathcode.dao.impl.UserProgressDAOImpl;
import com.pathcode.dao.RecommendationDAO;
import com.pathcode.dao.impl.RecommendationDAOImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;
import java.util.stream.Collectors;

public class RecommendationController extends HttpServlet {

    private RecommendationService recommendationService;
    private Connection connection;
    private UserProgressDAO userProgressDAO;
    private RecommendationDAO recommendationDAO;

    @Override
    public void init() throws ServletException {
        // Initialize resources once when servlet starts
        connection = DBConnectionUtil.getConnection();
        userProgressDAO = new UserProgressDAOImpl(); 
        recommendationDAO = new RecommendationDAOImpl(connection, userProgressDAO);
        this.recommendationService = new RecommendationServiceImpl(recommendationDAO);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int userId = Integer.parseInt(request.getParameter("userID"));
        
        // Check if recommendations exist in session and are not expired (5 minute cache)
        List<Recommendation> recommendations = getCachedRecommendations(session, userId);
        
        // Ensure uniqueness by problem ID
        recommendations = removeDuplicates(recommendations);
        
        request.setAttribute("recommendations", recommendations);
        RequestDispatcher dispatcher = request.getRequestDispatcher(
            "/WEB-INF/views/Recommendation/recommendation.jsp");
        dispatcher.forward(request, response);
    }

    private List<Recommendation> getCachedRecommendations(HttpSession session, int userId) {
        // Session cache key
        String cacheKey = "rec_" + userId;
        
        // Check if cached recommendations exist and are fresh (5 minutes)
        Long lastGenerated = (Long) session.getAttribute(cacheKey + "_time");
        if (lastGenerated != null && 
            System.currentTimeMillis() - lastGenerated < 300000) { // 5 minutes
            return (List<Recommendation>) session.getAttribute(cacheKey);
        }
        
        // Generate fresh recommendations
        List<Recommendation> recommendations = recommendationService.generateRecommendations(userId);
        
        // Store in session
        session.setAttribute(cacheKey, recommendations);
        session.setAttribute(cacheKey + "_time", System.currentTimeMillis());
        
        return recommendations;
    }

    private List<Recommendation> removeDuplicates(List<Recommendation> recommendations) {
        return recommendations.stream()
            .filter(Objects::nonNull)
            .collect(Collectors.collectingAndThen(
                Collectors.toMap(
                    Recommendation::getProblemId,
                    r -> r,
                    (existing, replacement) -> existing // keep first occurrence
                ),
                map -> new ArrayList<>(map.values())
            ));
    }

    @Override
    public void destroy() {
        // Clean up resources when servlet stops
        DBConnectionUtil.closeConnection(connection);
    }
}
