package com.pathcode.model;

import java.util.Date;

public class LearningPath {
    private int id;
    private int userId;
    private int problemId;
    private int stage;
    private Date assignedDate;
    private String description;
    private boolean isRequired;
    private Integer estimatedCompletionTime;

    // Default constructor with initialized values
    public LearningPath() {
        this.id = 0;
        this.userId = 0;
        this.problemId = 0;
        this.stage = 1;
        this.assignedDate = new Date();
        this.description = "";
        this.isRequired = false;
        this.estimatedCompletionTime = 1;
    }

    // Constructor with basic fields
    public LearningPath(int id, int userId, int problemId, int stage, Date assignedDate) {
        this.id = id;
        this.userId = userId;
        this.problemId = problemId;
        this.stage = stage;
        this.assignedDate = assignedDate != null ? assignedDate : new Date();
        this.description = "";
        this.isRequired = false;
        this.estimatedCompletionTime = 1;
    }

    // Full constructor
    public LearningPath(int id, int userId, int problemId, int stage, Date assignedDate, 
                       String description, boolean isRequired, Integer estimatedCompletionTime) {
        this.id = id;
        this.userId = userId;
        this.problemId = problemId;
        this.stage = stage;
        this.assignedDate = assignedDate != null ? assignedDate : new Date();
        this.description = description != null ? description : "";
        this.isRequired = isRequired;
        this.estimatedCompletionTime = estimatedCompletionTime != null ? estimatedCompletionTime : 1;
    }

    // Getters and setters
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

    public int getProblemId() {
        return problemId;
    }

    public void setProblemId(int problemId) {
        this.problemId = problemId;
    }

    public int getStage() {
        return stage;
    }

    public void setStage(int stage) {
        this.stage = stage;
    }

    public Date getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(Date assignedDate) {
        this.assignedDate = assignedDate != null ? assignedDate : new Date();
    }

    public String getDescription() {
        return description != null ? description : "";
    }

    public void setDescription(String description) {
        this.description = description != null ? description : "";
    }

    public boolean getIsRequired() {
        return isRequired;
    }

    public void setIsRequired(boolean isRequired) {
        this.isRequired = isRequired;
    }

    public Integer getEstimatedCompletionTime() {
        return estimatedCompletionTime != null ? estimatedCompletionTime : 1;
    }

    public void setEstimatedCompletionTime(Integer estimatedCompletionTime) {
        this.estimatedCompletionTime = estimatedCompletionTime != null ? estimatedCompletionTime : 1;
    }

    @Override
    public String toString() {
        return "LearningPath{" +
                "id=" + id +
                ", userId=" + userId +
                ", problemId=" + problemId +
                ", stage=" + stage +
                ", assignedDate=" + assignedDate +
                ", description='" + description + '\'' +
                ", isRequired=" + isRequired +
                ", estimatedCompletionTime=" + estimatedCompletionTime +
                '}';
    }
}
