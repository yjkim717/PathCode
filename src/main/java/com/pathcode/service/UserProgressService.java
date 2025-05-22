package com.pathcode.service;

import com.pathcode.model.UserProgress;
import java.util.List;

public interface UserProgressService {
    void addUserProgress(UserProgress userProgress);
    void updateUserProgress(UserProgress userProgress);
    void deleteUserProgress(int id);
    UserProgress getUserProgressById(int id);
    List<UserProgress> getUserProgressByUser(int userId);
    List<UserProgress> getUserProgressByProblem(int problemId);
    List<UserProgress> getAllUserProgress();
}