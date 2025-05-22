package com.pathcode.service;

import com.pathcode.model.User;

public interface UserService {
    User getUserByUsername(String username);
    User getUserByEmail(String email);
    boolean registerUser(User user);
    User authenticate(String username, String password);
}