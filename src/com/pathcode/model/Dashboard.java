package com.pathcode.model;
import java.util.Date;

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
  private int favoriteTagId;
  private int currentStreak;
  private int longestStreak;

  public Dashboard(int id, int userId, int totalProblemsAttempted, int totalProblemsSolved, double successRate,
      int averageTimePerProblem, int currentStage, int problemsInProgress, Date lastActiveDate,
      int weeklySolvedCount, int monthlySolvedCount, int favoriteTagId, int currentStreak, int longestStreak) {
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

  public int getId() { return id; }
  public int getUserId() { return userId; }
  public int getTotalProblemsAttempted() { return totalProblemsAttempted; }
  public int getTotalProblemsSolved() { return totalProblemsSolved; }
  public double getSuccessRate() { return successRate; }
  public int getAverageTimePerProblem() { return averageTimePerProblem; }
  public int getCurrentStage() { return currentStage; }
  public int getProblemsInProgress() { return problemsInProgress; }
  public Date getLastActiveDate() { return lastActiveDate; }
  public int getWeeklySolvedCount() { return weeklySolvedCount; }
  public int getMonthlySolvedCount() { return monthlySolvedCount; }
  public int getFavoriteTagId() { return favoriteTagId; }
  public int getCurrentStreak() { return currentStreak; }
  public int getLongestStreak() { return longestStreak; }

  public void setId(int id) { this.id = id; }
  public void setUserId(int userId) { this.userId = userId; }
  public void setTotalProblemsAttempted(int totalProblemsAttempted) { this.totalProblemsAttempted = totalProblemsAttempted; }
  public void setTotalProblemsSolved(int totalProblemsSolved) { this.totalProblemsSolved = totalProblemsSolved; }
  public void setSuccessRate(double successRate) { this.successRate = successRate; }
  public void setAverageTimePerProblem(int averageTimePerProblem) { this.averageTimePerProblem = averageTimePerProblem; }
  public void setCurrentStage(int currentStage) { this.currentStage = currentStage; }
  public void setProblemsInProgress(int problemsInProgress) { this.problemsInProgress = problemsInProgress; }
  public void setLastActiveDate(Date lastActiveDate) { this.lastActiveDate = lastActiveDate; }
  public void setWeeklySolvedCount(int weeklySolvedCount) { this.weeklySolvedCount = weeklySolvedCount; }
  public void setMonthlySolvedCount(int monthlySolvedCount) { this.monthlySolvedCount = monthlySolvedCount; }
  public void setFavoriteTagId(int favoriteTagId) { this.favoriteTagId = favoriteTagId; }
  public void setCurrentStreak(int currentStreak) { this.currentStreak = currentStreak; }
  public void setLongestStreak(int longestStreak) { this.longestStreak = longestStreak; }

  @Override
  public String toString() {
    return "Dashboard{" +
        "id=" + id +
        ", userId=" + userId +
        ", totalProblemsAttempted=" + totalProblemsAttempted +
        ", totalProblemsSolved=" + totalProblemsSolved +
        ", successRate=" + successRate +
        ", averageTimePerProblem=" + averageTimePerProblem +
        ", currentStage=" + currentStage +
        ", problemsInProgress=" + problemsInProgress +
        ", lastActiveDate=" + lastActiveDate +
        ", weeklySolvedCount=" + weeklySolvedCount +
        ", monthlySolvedCount=" + monthlySolvedCount +
        ", favoriteTagId=" + favoriteTagId +
        ", currentStreak=" + currentStreak +
        ", longestStreak=" + longestStreak +
        '}';
  }
}
