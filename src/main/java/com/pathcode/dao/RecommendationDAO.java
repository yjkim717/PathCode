package com.pathcode.dao;

import com.pathcode.model.Recommendation;
import java.util.List;

public interface RecommendationDAO {
    List<Recommendation> generateRecommendations(int userId);
}
