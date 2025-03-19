package com.pathcode.model;
import java.util.Date;

public class LearningPath {
  private int id;
  private int userId;
  private int problemId;
  private int stage;
  private Date assignedDate;

  public LearningPath(int id, int userId, int problemId, int stage, Date assignedDate) {
    this.id = id;
    this.userId = userId;
    this.problemId = problemId;
    this.stage = stage;
    this.assignedDate = assignedDate;
  }

  public int getId() { return id; }
  public int getUserId() { return userId; }
  public int getProblemId() { return problemId; }
  public int getStage() { return stage; }
  public Date getAssignedDate() { return assignedDate; }

  public void setId(int id) { this.id = id; }
  public void setUserId(int userId) { this.userId = userId; }
  public void setProblemId(int problemId) { this.problemId = problemId; }
  public void setStage(int stage) { this.stage = stage; }
  public void setAssignedDate(Date assignedDate) { this.assignedDate = assignedDate; }

  @Override
  public String toString() {
    return "LearningPath{id=" + id + ", userId=" + userId + ", problemId=" + problemId +
        ", stage=" + stage + ", assignedDate=" + assignedDate + "}";
  }
}
