package com.pathcode.model;

/**
 * ProblemTag entity class representing the Problem_Tag table (many-to-many relationship)
 */
public class ProblemTag {
    private int problemId;
    private int tagId;
    
    // Default constructor
    public ProblemTag() {
    }
    
    // Constructor with fields
    public ProblemTag(int problemId, int tagId) {
        this.problemId = problemId;
        this.tagId = tagId;
    }

    // Getters and Setters
    public int getProblemId() {
        return problemId;
    }

    public void setProblemId(int problemId) {
        this.problemId = problemId;
    }

    public int getTagId() {
        return tagId;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }

    @Override
    public String toString() {
        return "ProblemTag [problemId=" + problemId + ", tagId=" + tagId + "]";
    }
}