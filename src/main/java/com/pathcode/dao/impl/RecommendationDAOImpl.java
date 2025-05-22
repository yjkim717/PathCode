//package com.pathcode.dao.impl;
//
//import java.sql.*;
//import java.util.*;
//import com.pathcode.model.Recommendation;
//import com.pathcode.model.SolvedProblem;
//import com.pathcode.dao.RecommendationDAO;
//import com.pathcode.dao.UserProgressDAO;
//
//public class RecommendationDAOImpl implements RecommendationDAO {
//
//
//    private Connection connection;
//    private UserProgressDAO userProgressDAO;
//
//    public RecommendationDAOImpl(Connection connection, UserProgressDAO userProgressDAO) {
//        this.connection = connection;
//        this.userProgressDAO = userProgressDAO;
//    }
//
//    @Override
//    public List<Recommendation> generateRecommendations(int userId) {
//        List<SolvedProblem> solvedProblems = userProgressDAO.getUserSolvedProblems(userId);
//        Set<String> userTags = new HashSet<>();
//        Map<String, Integer> solvedCount = new HashMap<>();
//
//        for (SolvedProblem problem : solvedProblems) {
//            userTags.add(problem.getTag());
//            String tagDifficulty = problem.getTag() + "-" + problem.getDifficulty();
//            solvedCount.put(tagDifficulty, solvedCount.getOrDefault(tagDifficulty, 0) + 1);
//
//        }
//
//        List<Recommendation> recommendations = new ArrayList<>();
//
//        
//        // Rule 1: If a user has solved a problem with a certain tag and difficulty, recommend similar ones
//        for (SolvedProblem solvedProblem : solvedProblems) {
//            String tagDifficulty = solvedProblem.getTag() + "-" + solvedProblem.getDifficulty();
//            recommendations.addAll(recommendSimilarProblems(solvedProblem.getTag(), solvedProblem.getDifficulty()));
//        }
//
//        // Rule 2: If more than 5 easy problems solved in a tag, recommend medium difficulty
//        for (Map.Entry<String, Integer> entry : solvedCount.entrySet()) {
//            String tagDifficulty = entry.getKey();
//            if (entry.getValue() > 5 && tagDifficulty.startsWith("Easy")) {
//                String tag = tagDifficulty.split("-")[0];
//                recommendations.addAll(recommendProblemsByDifficulty(tag, "Medium"));
//            }
//        }
//
//        // Rule 3: If more than 5 medium problems solved in a tag, recommend hard difficulty
//        for (Map.Entry<String, Integer> entry : solvedCount.entrySet()) {
//            String tagDifficulty = entry.getKey();
//            if (entry.getValue() > 5 && tagDifficulty.startsWith("Medium")) {
//                String tag = tagDifficulty.split("-")[0];
//                recommendations.addAll(recommendProblemsByDifficulty(tag, "Hard"));
//            }
//        }
//
//        // Rule 4: If the user hasn't solved any problems, recommend easy problems from Arrays, Strings, Math
//        if (solvedProblems.isEmpty()) {
//            recommendations.addAll(recommendProblemsByTag(Arrays.asList("Arrays", "Strings", "Math"), "Easy"));
//        }
//
//        // Rule 5: Recommend easy problems from Dynamic Programming, Trees, Graphs if user solved Arrays, Strings, LinkedList
//        if (userTags.contains("Arrays") || userTags.contains("Strings") || userTags.contains("LinkedList")) {
//            recommendations.addAll(recommendProblemsByTag(Arrays.asList("Dynamic Programming", "Trees", "Graphs"), "Easy"));
//        }
//
//        return recommendations;
//    }
//
//    private List<Recommendation> recommendSimilarProblems(String tag, String difficulty) {
//        List<Recommendation> recommendations = new ArrayList<>();
//        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
//                     "FROM Problem p " +
//                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
//                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
//                     "WHERE t.Name = ? AND p.Difficulty = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setString(1, tag);
//            stmt.setString(2, difficulty);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Recommendation recommendation = new Recommendation();
//                recommendation.setProblemId(rs.getInt("ID"));                
//                recommendation.setProblemName(rs.getString("Title"));
//                recommendation.setDifficulty(rs.getString("Difficulty"));
//                recommendation.setTag(rs.getString("Tag"));
//                recommendation.setQuestionLink(rs.getString("Question_Link"));
//                recommendations.add(recommendation);
//
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            System.out.println("Error fetching recommendations: " + e.getMessage());
//        }
//        return recommendations;
//    }
//
//
//    private List<Recommendation> recommendProblemsByDifficulty(String tag, String difficulty) {
//        List<Recommendation> recommendations = new ArrayList<>();
//        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
//                     "FROM Problem p " +
//                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
//                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
//                     "WHERE t.Name = ? AND p.Difficulty = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setString(1, tag);
//            stmt.setString(2, difficulty);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Recommendation recommendation = new Recommendation();
//                recommendation.setProblemId(rs.getInt("ID"));
//                recommendation.setProblemName(rs.getString("Title"));
//                recommendation.setDifficulty(rs.getString("Difficulty"));
//                recommendation.setTag(rs.getString("Tag"));
//                recommendation.setQuestionLink(rs.getString("Question_Link"));
//                recommendations.add(recommendation);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return recommendations;
//    }
//
//    private List<Recommendation> recommendProblemsByTag(List<String> tags, String difficulty) {
//        List<Recommendation> recommendations = new ArrayList<>();
//        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
//                     "FROM Problem p " +
//                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
//                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
//                     "WHERE t.Name IN (?) AND p.Difficulty = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setString(1, String.join(",", tags));
//            stmt.setString(2, difficulty);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Recommendation recommendation = new Recommendation();
//                recommendation.setProblemId(rs.getInt("ID"));
//                recommendation.setProblemName(rs.getString("Title"));
//                recommendation.setDifficulty(rs.getString("Difficulty"));
//                recommendation.setTag(rs.getString("Tag"));
//                recommendation.setQuestionLink(rs.getString("Question_Link"));
//                recommendations.add(recommendation);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return recommendations;
//    }
//}

package com.pathcode.dao.impl;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

import com.pathcode.model.Recommendation;
import com.pathcode.model.SolvedProblem;
import com.pathcode.dao.RecommendationDAO;
import com.pathcode.dao.UserProgressDAO;

public class RecommendationDAOImpl implements RecommendationDAO {

    private Connection connection;
    private UserProgressDAO userProgressDAO;

    public RecommendationDAOImpl(Connection connection, UserProgressDAO userProgressDAO) {
        this.connection = connection;
        this.userProgressDAO = userProgressDAO;
    }

    @Override
    public List<Recommendation> generateRecommendations(int userId) {
        List<SolvedProblem> solvedProblems = userProgressDAO.getUserSolvedProblems(userId);
        Set<Integer> solvedProblemIds = new HashSet<>();
        Set<String> userTags = new HashSet<>();
        Map<String, Integer> solvedCount = new HashMap<>();

        // Collect solved problem IDs and tags
        for (SolvedProblem problem : solvedProblems) {
            solvedProblemIds.add(problem.getProblemId());
            userTags.add(problem.getTag());
            String tagDifficulty = problem.getTag() + "-" + problem.getDifficulty();
            solvedCount.put(tagDifficulty, solvedCount.getOrDefault(tagDifficulty, 0) + 1);
        }

        // Use LinkedHashSet to maintain insertion order while ensuring uniqueness
        Set<Recommendation> uniqueRecommendations = new LinkedHashSet<>();

        // Rule 1: Similar problems
        for (SolvedProblem solvedProblem : solvedProblems) {
            uniqueRecommendations.addAll(recommendSimilarProblems(
                solvedProblem.getTag(), 
                solvedProblem.getDifficulty(), 
                solvedProblemIds
            ));
        }

        // Rule 2: Medium after 5 easy
        for (Map.Entry<String, Integer> entry : solvedCount.entrySet()) {
            String tagDifficulty = entry.getKey();
            if (entry.getValue() > 5 && tagDifficulty.endsWith("-Easy")) {
                String tag = tagDifficulty.split("-")[0];
                uniqueRecommendations.addAll(recommendProblemsByDifficulty(
                    tag, "Medium", solvedProblemIds
                ));
            }
        }

        // Rule 3: If more than 5 medium problems solved in a tag, recommend hard difficulty
        for (Map.Entry<String, Integer> entry : solvedCount.entrySet()) {
            String tagDifficulty = entry.getKey();
            if (entry.getValue() > 5 && tagDifficulty.endsWith("-Medium")) {
                String tag = tagDifficulty.split("-")[0];
                uniqueRecommendations.addAll(recommendProblemsByDifficulty(tag, "Hard", solvedProblemIds));
            }
        }

        // Rule 4: If the user hasn't solved any problems, recommend easy problems from Arrays, Strings, Math
        if (solvedProblems.isEmpty()) {
        	uniqueRecommendations.addAll(recommendProblemsByTag(Arrays.asList("Arrays", "Strings", "Math"), 
                "Easy", solvedProblemIds));
        }

        // Rule 5: Recommend easy problems from Dynamic Programming, Trees, Graphs if user solved Arrays, Strings, LinkedList
        if (userTags.contains("Arrays") || userTags.contains("Strings") || userTags.contains("LinkedList")) {
        	uniqueRecommendations.addAll(recommendProblemsByTag(Arrays.asList("Dynamic Programming", "Trees", "Graphs"), 
                "Easy", solvedProblemIds));
        }

        return uniqueRecommendations.stream()
        	       .limit(10) // or whatever limit you prefer
        	       .collect(Collectors.toList());
    }

    private Set<Recommendation> recommendSimilarProblems(String tag, String difficulty, Set<Integer> solvedProblemIds) {
    	Set<Recommendation> recommendations = new HashSet<>();
        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
                     "FROM Problem p " +
                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
                     "WHERE t.Name = ? AND p.Difficulty = ? AND p.ID NOT IN (" + 
                     buildNotInClause(solvedProblemIds) + ")";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, tag);
            stmt.setString(2, difficulty);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Recommendation recommendation = new Recommendation();
                recommendation.setProblemId(rs.getInt("ID"));                
                recommendation.setProblemName(rs.getString("Title"));
                recommendation.setDifficulty(rs.getString("Difficulty"));
                recommendation.setTag(rs.getString("Tag"));
                recommendation.setQuestionLink(rs.getString("Question_Link"));
                recommendations.add(recommendation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error fetching recommendations: " + e.getMessage());
        }
        return recommendations;
    }

    private Set<Recommendation> recommendProblemsByDifficulty(String tag, String difficulty, Set<Integer> solvedProblemIds) {
        Set<Recommendation> recommendations = new HashSet<>();
        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
                     "FROM Problem p " +
                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
                     "WHERE t.Name = ? AND p.Difficulty = ? AND p.ID NOT IN (" + 
                     buildNotInClause(solvedProblemIds) + ")";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, tag);
            stmt.setString(2, difficulty);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Recommendation recommendation = new Recommendation();
                recommendation.setProblemId(rs.getInt("ID"));
                recommendation.setProblemName(rs.getString("Title"));
                recommendation.setDifficulty(rs.getString("Difficulty"));
                recommendation.setTag(rs.getString("Tag"));
                recommendation.setQuestionLink(rs.getString("Question_Link"));
                recommendations.add(recommendation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recommendations;
    }

    private Set<Recommendation> recommendProblemsByTag(List<String> tags, String difficulty, Set<Integer> solvedProblemIds) {
        Set<Recommendation> recommendations = new HashSet<>();
        String placeholders = String.join(",", Collections.nCopies(tags.size(), "?"));
        String sql = "SELECT p.ID, p.Title, p.Difficulty, p.Question_Link, pt.Tag_ID, t.Name AS Tag " +
                     "FROM Problem p " +
                     "JOIN Problem_Tag pt ON p.ID = pt.Problem_ID " +
                     "JOIN Tag t ON pt.Tag_ID = t.ID " +
                     "WHERE t.Name IN (" + placeholders + ") AND p.Difficulty = ? " +
                     "AND p.ID NOT IN (" + buildNotInClause(solvedProblemIds) + ")";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Set tags
            for (int i = 0; i < tags.size(); i++) {
                stmt.setString(i + 1, tags.get(i));
            }
            // Set difficulty
            stmt.setString(tags.size() + 1, difficulty);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Recommendation recommendation = new Recommendation();
                recommendation.setProblemId(rs.getInt("ID"));
                recommendation.setProblemName(rs.getString("Title"));
                recommendation.setDifficulty(rs.getString("Difficulty"));
                recommendation.setTag(rs.getString("Tag"));
                recommendation.setQuestionLink(rs.getString("Question_Link"));
                recommendations.add(recommendation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recommendations;
    }

    private String buildNotInClause(Set<Integer> solvedProblemIds) {
        if (solvedProblemIds.isEmpty()) {
            return "0"; // Return "0" so no problems are excluded when none are solved
        }
        return String.join(",", solvedProblemIds.stream()
                .map(String::valueOf)
                .toArray(String[]::new));
    }
}
