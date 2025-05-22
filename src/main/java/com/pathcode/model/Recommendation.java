package com.pathcode.model;

import java.util.Date;

public class Recommendation {
	private int id;
	private int userId;
    private int problemId;
    private Date recommendedDate;
    private String problemTitle;
    private double confidenceScore;
    private Date createdDate;
    private String problemName;
    private String difficulty;
    private String tag;
    private String questionLink;

    // Constructors, Getters, and Setters
    public Recommendation() {}

    public Recommendation(int id, int userId, int problemId, Date recommendedDate, double confidenceScore, Date createdDate, String problemName, String difficulty, String tag, String questionLink) {
        this.id = id;
        this.userId = userId;
        this.problemId = problemId;
        this.problemName = problemName;
        this.recommendedDate = recommendedDate;
        this.confidenceScore = confidenceScore;
        this.createdDate = createdDate;
        this.difficulty = difficulty;
        this.tag = tag;
        this.questionLink = questionLink;
    }
    


    public int getProblemId() {
        return problemId;
    }

    public void setProblemId(int problemId) {
        this.problemId = problemId;
    }

    public String getProblemName() {
        return problemName;
    }

    public Date getRecommendedDate() { return recommendedDate; }
    public void setRecommendedDate(Date recommendedDate) { this.recommendedDate = recommendedDate; }
    
    public String getProblemTitle() { return problemTitle; }
    public void setProblemTitle(String problemTitle) { this.problemTitle = problemTitle; }
    
    public double getConfidenceScore() { return confidenceScore; }
    public void setConfidenceScore(double confidenceScore) { this.confidenceScore = confidenceScore; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public void setProblemName(String problemName) {
        this.problemName = problemName;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
    public String getQuestionLink() {
        return questionLink;
    }

    public void setQuestionLink(String questionLink) {
        this.questionLink = questionLink;
    }

    @Override
    public String toString() {
        return "Recommendation{" +
               "problemId=" + problemId +
               ", problemName='" + problemName + '\'' +
               ", difficulty='" + difficulty + '\'' +
               ", tag='" + tag + '\'' +
               '}';
    }
}

