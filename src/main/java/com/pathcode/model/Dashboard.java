package com.pathcode.model;

import java.util.Date;

/**
 * Dashboard entity class representing the Dashboard table
 */
public class Dashboard {
    private int id;
    private int userId;
    private int totalProblemsAttempted;
    private int totalProblemsSolved;
    private double successRate;
    private int averageTimePerProblem;
    private int currentStage;
    private int problemsInProgress;
    private Date lastActiveDate;
    private int weeklySolvedCount;
    private int monthlySolvedCount;
    private Integer favoriteTagId; // Can be null
    private int currentStreak;
    private int longestStreak;
    
    // Default constructor
    public Dashboard() {
    }
    
    // Constructor with fields
    public Dashboard(int id, int userId, int totalProblemsAttempted, int totalProblemsSolved, 
                    double successRate, int averageTimePerProblem, int currentStage, 
                    int problemsInProgress, Date lastActiveDate, int weeklySolvedCount, 
                    int monthlySolvedCount, Integer favoriteTagId, int currentStreak, int longestStreak) {
        this.id = id;
        this.userId = userId;
        this.totalProblemsAttempted = totalProblemsAttempted;
        this.totalProblemsSolved = totalProblemsSolved;
        this.successRate = successRate;
        this.averageTimePerProblem = averageTimePerProblem;
        this.currentStage = currentStage;
        this.problemsInProgress = problemsInProgress;
        this.lastActiveDate = lastActiveDate;
        this.weeklySolvedCount = weeklySolvedCount;
        this.monthlySolvedCount = monthlySolvedCount;
        this.favoriteTagId = favoriteTagId;
        this.currentStreak = currentStreak;
        this.longestStreak = longestStreak;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTotalProblemsAttempted() {
        return totalProblemsAttempted;
    }

    public void setTotalProblemsAttempted(int totalProblemsAttempted) {
        this.totalProblemsAttempted = totalProblemsAttempted;
    }

    public int getTotalProblemsSolved() {
        return totalProblemsSolved;
    }

    public void setTotalProblemsSolved(int totalProblemsSolved) {
        this.totalProblemsSolved = totalProblemsSolved;
    }

    public double getSuccessRate() {
        return successRate;
    }

    public void setSuccessRate(double successRate) {
        this.successRate = successRate;
    }

    public int getAverageTimePerProblem() {
        return averageTimePerProblem;
    }

    public void setAverageTimePerProblem(int averageTimePerProblem) {
        this.averageTimePerProblem = averageTimePerProblem;
    }

    public int getCurrentStage() {
        return currentStage;
    }

    public void setCurrentStage(int currentStage) {
        this.currentStage = currentStage;
    }

    public int getProblemsInProgress() {
        return problemsInProgress;
    }

    public void setProblemsInProgress(int problemsInProgress) {
        this.problemsInProgress = problemsInProgress;
    }

    public Date getLastActiveDate() {
        return lastActiveDate;
    }

    public void setLastActiveDate(Date lastActiveDate) {
        this.lastActiveDate = lastActiveDate;
    }

    public int getWeeklySolvedCount() {
        return weeklySolvedCount;
    }

    public void setWeeklySolvedCount(int weeklySolvedCount) {
        this.weeklySolvedCount = weeklySolvedCount;
    }

    public int getMonthlySolvedCount() {
        return monthlySolvedCount;
    }

    public void setMonthlySolvedCount(int monthlySolvedCount) {
        this.monthlySolvedCount = monthlySolvedCount;
    }

    public Integer getFavoriteTagId() {
        return favoriteTagId;
    }

    public void setFavoriteTagId(Integer favoriteTagId) {
        this.favoriteTagId = favoriteTagId;
    }

    public int getCurrentStreak() {
        return currentStreak;
    }

    public void setCurrentStreak(int currentStreak) {
        this.currentStreak = currentStreak;
    }

    public int getLongestStreak() {
        return longestStreak;
    }

    public void setLongestStreak(int longestStreak) {
        this.longestStreak = longestStreak;
    }
    
    @Override
    public String toString() {
        return "Dashboard [id=" + id + ", userId=" + userId + ", totalProblemsAttempted=" + totalProblemsAttempted
                + ", totalProblemsSolved=" + totalProblemsSolved + ", successRate=" + successRate
                + ", averageTimePerProblem=" + averageTimePerProblem + ", currentStage=" + currentStage
                + ", problemsInProgress=" + problemsInProgress + ", lastActiveDate=" + lastActiveDate
                + ", weeklySolvedCount=" + weeklySolvedCount + ", monthlySolvedCount=" + monthlySolvedCount
                + ", favoriteTagId=" + favoriteTagId + ", currentStreak=" + currentStreak + ", longestStreak="
                + longestStreak + "]";
    }
}