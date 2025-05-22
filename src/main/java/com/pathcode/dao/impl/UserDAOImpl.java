package com.pathcode.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.pathcode.dao.UserDAO;
import com.pathcode.model.User;
import com.pathcode.util.DBConnectionUtil;

public class UserDAOImpl implements UserDAO {

    @Override
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM User WHERE Username = ?";
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return mapResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM User WHERE Email = ?";
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return mapResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO User (Username, Email, password, JoinDate) VALUES (?, ?, ?, NOW())";
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM User WHERE Username = ? AND password = ?";
        System.out.println("Attempting to authenticate user: " + username);
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, username);
            statement.setString(2, password);
            System.out.println("Executing SQL: " + sql + " with username=" + username);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                System.out.println("Authentication successful for user: " + username);
                return mapResultSetToUser(resultSet);
            } else {
                System.out.println("Authentication failed - no matching user found");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error during authentication: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    private User mapResultSetToUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setId(resultSet.getInt("ID"));
        user.setUsername(resultSet.getString("Username"));
        user.setEmail(resultSet.getString("Email"));
        user.setPassword(resultSet.getString("password"));
        user.setJoinDate(resultSet.getTimestamp("JoinDate"));
        return user;
    }
}