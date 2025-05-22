package com.pathcode.service.impl;

import com.pathcode.dao.RecommendationDAO;
import com.pathcode.model.Recommendation;
import com.pathcode.service.RecommendationService;
import java.util.List;

public class RecommendationServiceImpl implements RecommendationService {
    
    private final RecommendationDAO recommendationDAO;

    // Constructor Injection for DAO
    public RecommendationServiceImpl(RecommendationDAO recommendationDAO) {
        this.recommendationDAO = recommendationDAO;
    }

    @Override
    public List<Recommendation> generateRecommendations(int userId) {
        // Fetch recommendations from the DAO layer
        return recommendationDAO.generateRecommendations(userId);
    }
}
