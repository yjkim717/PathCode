package com.pathcode.dao;

import com.pathcode.model.UserProgress;
import java.util.List;
import com.pathcode.model.SolvedProblem;

public interface UserProgressDAO {
    List<SolvedProblem> getUserSolvedProblems(int userId);
    UserProgress getUserProgress(int userId, int problemId);

    List<UserProgress> getAllProgressForUser(int userId);

    void markSolved(int userId, int problemId);

    void markInProgress(int userId, int problemId);

    void insertOrUpdateProgress(UserProgress progress);

    void addUserProgress(UserProgress progress);
    void updateUserProgress(UserProgress progress);
    void deleteUserProgress(int id);
    UserProgress getUserProgressById(int id);
    List<UserProgress> getUserProgressByUser(int userId);
    List<UserProgress> getUserProgressByProblem(int problemId);
    List<UserProgress> getAllUserProgress();

}
