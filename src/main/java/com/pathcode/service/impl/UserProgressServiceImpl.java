package com.pathcode.service.impl;

import com.pathcode.dao.UserProgressDAO;
import com.pathcode.dao.impl.UserProgressDAOImpl;
import com.pathcode.model.UserProgress;
import com.pathcode.service.UserProgressService;
import java.util.List;

public class UserProgressServiceImpl implements UserProgressService {
    private UserProgressDAO userProgressDAO;

    public UserProgressServiceImpl() {
        this.userProgressDAO = new UserProgressDAOImpl();
    }

    @Override
    public void addUserProgress(UserProgress userProgress) {
        userProgressDAO.addUserProgress(userProgress);
    }

    @Override
    public void updateUserProgress(UserProgress userProgress) {
        userProgressDAO.updateUserProgress(userProgress);
    }

    @Override
    public void deleteUserProgress(int id) {
        userProgressDAO.deleteUserProgress(id);
    }

    @Override
    public UserProgress getUserProgressById(int id) {
        return userProgressDAO.getUserProgressById(id);
    }

    @Override
    public List<UserProgress> getUserProgressByUser(int userId) {
        return userProgressDAO.getUserProgressByUser(userId);
    }

    @Override
    public List<UserProgress> getUserProgressByProblem(int problemId) {
        return userProgressDAO.getUserProgressByProblem(problemId);
    }

    @Override
    public List<UserProgress> getAllUserProgress() {
        return userProgressDAO.getAllUserProgress();
    }
}