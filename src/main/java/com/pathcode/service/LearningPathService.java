package com.pathcode.service;

import java.util.List;
import java.util.Map;

import com.pathcode.model.LearningPath;

public interface LearningPathService {
    void addLearningPath(LearningPath learningPath);
    List<LearningPath> getLearningPathsByUser(int userId);
    LearningPath getLearningPathById(int id);
    void updateLearningPath(LearningPath learningPath);
    void deleteLearningPath(int id);
    
    // Statistics methods
    int getActiveUsersCount();
    int getAverageCompletionTime();
    double getCompletionRate();
    Map<Integer, Integer> getPopularLearningPaths();
    Map<String, Double> getPathDifficultyDistribution();
}