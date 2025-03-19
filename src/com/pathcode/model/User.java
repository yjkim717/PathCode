package com.pathcode.model;
import java.util.Date;

public class User {
  private int id;
  private String username;
  private String email;
  private Date joinDate;

  public User(int id, String username, String email, Date joinDate) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.joinDate = joinDate;
  }

  public int getId() { return id; }
  public void setId(int id) { this.id = id; }

  public String getUsername() { return username; }
  public void setUsername(String username) { this.username = username; }

  public String getEmail() { return email; }
  public void setEmail(String email) { this.email = email; }

  public Date getJoinDate() { return joinDate; }
  public void setJoinDate(Date joinDate) { this.joinDate = joinDate; }

  @Override
  public String toString() {
    return "User{id=" + id + ", username='" + username + "', email='" + email + "', joinDate=" + joinDate + "}";
  }
}
