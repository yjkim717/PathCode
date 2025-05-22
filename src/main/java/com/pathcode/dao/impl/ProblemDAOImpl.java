package com.pathcode.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.pathcode.dao.ProblemDAO;
import com.pathcode.model.Problem;
import com.pathcode.util.DBConnectionUtil;

public class ProblemDAOImpl implements ProblemDAO {

    @Override
    public List<Problem> getAllProblems() {
        List<Problem> problems = new ArrayList<>();
        String sql = "SELECT ID, Title, Acceptance, isPremium, Difficulty, Question_Link, Solution_Link FROM Problem";

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("--------- Loading all problems from database ---------");
            while (rs.next()) {
                int problemId = rs.getInt("ID");
                String title = rs.getString("Title");
                System.out.println("Loading problem ID: " + problemId + ", Title: " + title);
                
                // Skip problem if ID is 0 or invalid
                if (problemId <= 0) {
                    System.err.println("WARNING: Skipping problem with invalid ID: " + problemId + ", Title: " + title);
                    continue;
                }
                
                Problem problem = new Problem();
                problem.setProblemId(problemId);
                problem.setTitle(title);
                
                try {
                    double acceptance = rs.getDouble("Acceptance");
                    problem.setAcceptance(acceptance);
                } catch (SQLException e) {
                    // If Acceptance is not a numeric type, try getting it as a string and converting
                    try {
                        String acceptanceStr = rs.getString("Acceptance");
                        double acceptance = Double.parseDouble(acceptanceStr.replace("%", ""));
                        problem.setAcceptance(acceptance);
                    } catch (Exception ex) {
                        System.err.println("Error converting Acceptance for problem ID " + problemId + ": " + ex.getMessage());
                        problem.setAcceptance(0.0); // Default value
                    }
                }
                
                problem.setPremium(rs.getBoolean("isPremium"));
                problem.setDifficulty(rs.getString("Difficulty"));
                problem.setQuestionLink(rs.getString("Question_Link"));
                problem.setSolutionLink(rs.getString("Solution_Link"));
                
                System.out.println("Added problem to list: ID=" + problem.getProblemId() + ", Title=" + problem.getTitle());
                problems.add(problem);
            }
            System.out.println("Loaded " + problems.size() + " problems from database");
            System.out.println("-----------------------------------------------------");

        } catch (SQLException e) {
            System.err.println("Error loading problems: " + e.getMessage());
            e.printStackTrace();
        }

        return problems;
    }
    
    @Override
    public Problem getProblemById(int id) {
        Problem problem = null;
        String sql = "SELECT * FROM Problem WHERE ID = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    problem = new Problem();
                    problem.setProblemId(rs.getInt("ID"));
                    problem.setTitle(rs.getString("Title"));
                    problem.setAcceptance(rs.getDouble("Acceptance"));
                    problem.setPremium(rs.getBoolean("isPremium"));
                    problem.setDifficulty(rs.getString("Difficulty"));
                    problem.setQuestionLink(rs.getString("Question_link"));
                    problem.setSolutionLink(rs.getString("Solution_link"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return problem;
    }

    @Override
    public void insertProblem(Problem problem) {
        String sql = "INSERT INTO Problem (Title, Acceptance, isPremium, Difficulty, Question_link, Solution_link) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, problem.getTitle());
            stmt.setDouble(2, problem.getAcceptance());
            stmt.setBoolean(3, problem.isPremium());
            stmt.setString(4, problem.getDifficulty());
            stmt.setString(5, problem.getQuestionLink());
            stmt.setString(6, problem.getSolutionLink());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateProblem(Problem problem) {
        String sql = "UPDATE Problem SET Title=?, Acceptance=?, isPremium=?, Difficulty=?, Question_link=?, Solution_link=? " +
                     "WHERE ID=?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, problem.getTitle());
            stmt.setDouble(2, problem.getAcceptance());
            stmt.setBoolean(3, problem.isPremium());
            stmt.setString(4, problem.getDifficulty());
            stmt.setString(5, problem.getQuestionLink());
            stmt.setString(6, problem.getSolutionLink());
            stmt.setInt(7, problem.getProblemId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteProblem(int id) {
        String sql = "DELETE FROM Problem WHERE ID=?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
