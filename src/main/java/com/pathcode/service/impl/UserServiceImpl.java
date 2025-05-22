package com.pathcode.service.impl;

import com.pathcode.dao.UserDAO;
import com.pathcode.dao.impl.UserDAOImpl;
import com.pathcode.model.User;
import com.pathcode.service.UserService;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO;
    
    public UserServiceImpl() {
        this.userDAO = new UserDAOImpl();
    }

    @Override
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }

    @Override
    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    @Override
    public User authenticate(String username, String password) {
        return userDAO.authenticate(username, password);
    }
}