package com.pathcode.service.impl;

import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.pathcode.dao.LearningPathDAO;
import com.pathcode.dao.impl.LearningPathDAOImpl;
import com.pathcode.model.LearningPath;
import com.pathcode.service.LearningPathService;

public class LearningPathServiceImpl implements LearningPathService {
    private LearningPathDAO learningPathDAO;

    // No-argument constructor
    public LearningPathServiceImpl() {
        this.learningPathDAO = new LearningPathDAOImpl(); // Initialize DAO here
    }

    // Constructor with DAO parameter (optional, for dependency injection)
    public LearningPathServiceImpl(LearningPathDAO learningPathDAO) {
        this.learningPathDAO = learningPathDAO;
    }

    @Override
    public void addLearningPath(LearningPath learningPath) {
        learningPathDAO.addLearningPath(learningPath);
    }

    @Override
    public List<LearningPath> getLearningPathsByUser(int userId) {
        return learningPathDAO.getLearningPathsByUser(userId);
    }

    @Override
    public LearningPath getLearningPathById(int id) {
        return learningPathDAO.getLearningPathById(id);
    }

    @Override
    public void updateLearningPath(LearningPath learningPath) {
        learningPathDAO.updateLearningPath(learningPath);
    }

    @Override
    public void deleteLearningPath(int id) {
        learningPathDAO.deleteLearningPath(id);
    }
    
    @Override
    public int getActiveUsersCount() {
        // Get all learning paths
        List<LearningPath> allPaths = learningPathDAO.getAllLearningPaths();
        
        // Use a Set to count unique user IDs
        Set<Integer> uniqueUsers = new HashSet<>();
        for (LearningPath path : allPaths) {
            uniqueUsers.add(path.getUserId());
        }
        
        return uniqueUsers.size();
    }
    
    @Override
    public int getAverageCompletionTime() {
        List<LearningPath> allPaths = learningPathDAO.getAllLearningPaths();
        
        if (allPaths.isEmpty()) {
            return 0;
        }
        
        int totalEstimatedTime = 0;
        for (LearningPath path : allPaths) {
            totalEstimatedTime += path.getEstimatedCompletionTime();
        }
        
        return totalEstimatedTime / allPaths.size();
    }
    
    @Override
    public double getCompletionRate() {
        // This is a placeholder implementation - in a real system you'd track 
        // completed vs. assigned learning paths
        List<LearningPath> allPaths = learningPathDAO.getAllLearningPaths();
        
        if (allPaths.isEmpty()) {
            return 0.0;
        }
        
        // Let's assume 70% of paths are completed for demonstration
        int totalPaths = allPaths.size();
        int completedPaths = (int)(totalPaths * 0.7);
        
        return ((double)completedPaths / totalPaths) * 100;
    }
    
    @Override
    public Map<Integer, Integer> getPopularLearningPaths() {
        List<LearningPath> allPaths = learningPathDAO.getAllLearningPaths();
        
        // Count occurrences of each path ID
        Map<Integer, Integer> pathCounts = new HashMap<>();
        for (LearningPath path : allPaths) {
            Integer pathId = path.getProblemId();
            pathCounts.put(pathId, pathCounts.getOrDefault(pathId, 0) + 1);
        }
        
        // Sort by count (descending) and take top 3
        return pathCounts.entrySet().stream()
            .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
            .limit(3)
            .collect(Collectors.toMap(
                Map.Entry::getKey,
                Map.Entry::getValue,
                (e1, e2) -> e1,
                HashMap::new
            ));
    }
    
    @Override
    public Map<String, Double> getPathDifficultyDistribution() {
        List<LearningPath> allPaths = learningPathDAO.getAllLearningPaths();
        
        if (allPaths.isEmpty()) {
            Map<String, Double> emptyDistribution = new HashMap<>();
            emptyDistribution.put("beginner", 0.0);
            emptyDistribution.put("intermediate", 0.0);
            emptyDistribution.put("advanced", 0.0);
            return emptyDistribution;
        }
        
        int beginnerCount = 0;
        int intermediateCount = 0;
        int advancedCount = 0;
        int totalPaths = allPaths.size();
        
        for (LearningPath path : allPaths) {
            int stage = path.getStage();
            if (stage <= 3) {
                beginnerCount++;
            } else if (stage <= 6) {
                intermediateCount++;
            } else {
                advancedCount++;
            }
        }
        
        Map<String, Double> distribution = new HashMap<>();
        distribution.put("beginner", (double)beginnerCount / totalPaths * 100);
        distribution.put("intermediate", (double)intermediateCount / totalPaths * 100);
        distribution.put("advanced", (double)advancedCount / totalPaths * 100);
        
        return distribution;
    }
}