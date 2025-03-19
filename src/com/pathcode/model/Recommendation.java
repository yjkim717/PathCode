package com.pathcode.model;
import java.util.Date;

public class Recommendation {
  private int id;
  private int userId;
  private int problemId;
  private Date recommendedDate;

  public Recommendation(int id, int userId, int problemId, Date recommendedDate) {
    this.id = id;
    this.userId = userId;
    this.problemId = problemId;
    this.recommendedDate = recommendedDate;
  }

  public int getId() { return id; }
  public int getUserId() { return userId; }
  public int getProblemId() { return problemId; }
  public Date getRecommendedDate() { return recommendedDate; }

  public void setId(int id) { this.id = id; }
  public void setUserId(int userId) { this.userId = userId; }
  public void setProblemId(int problemId) { this.problemId = problemId; }
  public void setRecommendedDate(Date recommendedDate) { this.recommendedDate = recommendedDate; }

  @Override
  public String toString() {
    return "Recommendation{id=" + id + ", userId=" + userId + ", problemId=" + problemId + ", date=" + recommendedDate + "}";
  }
}
