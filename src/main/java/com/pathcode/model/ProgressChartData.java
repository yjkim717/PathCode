package com.pathcode.model;


public class ProgressChartData {
    private int week;
    private int problemsSolved;
    private double successRate;

    // Constructor
    public ProgressChartData(int week, int problemsSolved, double successRate) {
        this.week = week;
        this.problemsSolved = problemsSolved;
        this.successRate = successRate;
    }

    // Getters and Setters
    public int getWeek() {
        return week;
    }

    public void setWeek(int week) {
        this.week = week;
    }

    public int getProblemsSolved() {
        return problemsSolved;
    }

    public void setProblemsSolved(int problemsSolved) {
        this.problemsSolved = problemsSolved;
    }

    public double getSuccessRate() {
        return successRate;
    }

    public void setSuccessRate(double successRate) {
        this.successRate = successRate;
    }
}
