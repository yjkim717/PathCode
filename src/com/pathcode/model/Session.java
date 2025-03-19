package com.pathcode.model;
import java.util.Date;

public class Session {
  private int id;
  private int userId;
  private Date startTime;
  private Date endTime;

  public Session(int id, int userId, Date startTime, Date endTime) {
    this.id = id;
    this.userId = userId;
    this.startTime = startTime;
    this.endTime = endTime;
  }

  public int getId() { return id; }
  public int getUserId() { return userId; }
  public Date getStartTime() { return startTime; }
  public Date getEndTime() { return endTime; }

  public void setId(int id) { this.id = id; }
  public void setUserId(int userId) { this.userId = userId; }
  public void setStartTime(Date startTime) { this.startTime = startTime; }
  public void setEndTime(Date endTime) { this.endTime = endTime; }

  @Override
  public String toString() {
    return "Session{id=" + id + ", userId=" + userId + ", startTime=" + startTime + ", endTime=" + endTime + "}";
  }
}
