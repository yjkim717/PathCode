package com.pathcode.service;

import com.pathcode.model.Recommendation;
import java.util.List;

public interface RecommendationService {
    List<Recommendation> generateRecommendations(int userId);
}
