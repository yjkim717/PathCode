package com.pathcode.model;

import java.util.Date;

public class UserProgress {
    private int id;
    private int userId;
    private int problemId;
    private boolean solved;
    private int attempts;
    private int timeTaken;
    private Date lastAttemptDate;
    private String difficulty;
    private String title;

    public UserProgress() {}

    public UserProgress(int id, int userId, int problemId, boolean solved, int attempts, int timeTaken, Date lastAttemptDate, String Difficulty) {
        this.id = id;
        this.userId = userId;
        this.problemId = problemId;
        this.solved = solved;
        this.attempts = attempts;
        this.timeTaken = timeTaken;
        this.lastAttemptDate = lastAttemptDate;
        this.difficulty = difficulty;
    }

    public UserProgress(int userId, int problemId, boolean solved) {
        this.userId = userId;
        this.problemId = problemId;
        this.solved = solved;
        this.attempts = 1;
        this.timeTaken = 0;
        this.lastAttemptDate = new Date();
    }
    public String getDifficulty() {
        return difficulty;
    }
    
    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProblemId() { return problemId; }
    public void setProblemId(int problemId) { this.problemId = problemId; }

    public boolean isSolved() { return solved; }
    public void setSolved(boolean solved) { this.solved = solved; }

    public int getAttempts() { return attempts; }
    public void setAttempts(int attempts) { this.attempts = attempts; }

    public int getTimeTaken() { return timeTaken; }
    public void setTimeTaken(int timeTaken) { this.timeTaken = timeTaken; }

    public Date getLastAttemptDate() { return lastAttemptDate; }
    public void setLastAttemptDate(Date lastAttemptDate) { this.lastAttemptDate = lastAttemptDate; }

    public String getTitle() { 
        return title; 
    }
    
    public void setTitle(String title) { 
        this.title = title; 
    }
}
