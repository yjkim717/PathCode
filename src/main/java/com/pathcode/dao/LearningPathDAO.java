package com.pathcode.dao;

import java.util.List;

import com.pathcode.model.LearningPath;

public interface LearningPathDAO {
    void addLearningPath(LearningPath learningPath);
    List<LearningPath> getLearningPathsByUser(int userId);
    LearningPath getLearningPathById(int id);
    void updateLearningPath(LearningPath learningPath);
    void deleteLearningPath(int id);
    List<LearningPath> getAllLearningPaths();
}