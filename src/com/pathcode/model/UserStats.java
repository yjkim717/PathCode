package com.pathcode.model;

public class UserStats {
  private int userId;
  private int totalSolved;
  private double avgAcceptance;

  public UserStats(int userId, int totalSolved, double avgAcceptance) {
    this.userId = userId;
    this.totalSolved = totalSolved;
    this.avgAcceptance = avgAcceptance;
  }

  public int getUserId() { return userId; }
  public int getTotalSolved() { return totalSolved; }
  public double getAvgAcceptance() { return avgAcceptance; }

  public void setUserId(int userId) { this.userId = userId; }
  public void setTotalSolved(int totalSolved) { this.totalSolved = totalSolved; }
  public void setAvgAcceptance(double avgAcceptance) { this.avgAcceptance = avgAcceptance; }

  @Override
  public String toString() {
    return "UserStats{userId=" + userId + ", totalSolved=" + totalSolved + ", avgAcceptance=" + avgAcceptance + "}";
  }
}
