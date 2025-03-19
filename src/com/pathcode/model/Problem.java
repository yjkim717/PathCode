package com.pathcode.model;

public class Problem {
  private int id;
  private String title;
  private double acceptance;
  private boolean isPremium;
  private String difficulty;
  private String questionLink;
  private String solutionLink;

  public Problem(int id, String title, double acceptance, boolean isPremium, String difficulty, String questionLink, String solutionLink) {
    this.id = id;
    this.title = title;
    this.acceptance = acceptance;
    this.isPremium = isPremium;
    this.difficulty = difficulty;
    this.questionLink = questionLink;
    this.solutionLink = solutionLink;
  }

  public int getId() { return id; }
  public void setId(int id) { this.id = id; }

  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }

  public double getAcceptance() { return acceptance; }
  public void setAcceptance(double acceptance) { this.acceptance = acceptance; }

  public boolean isPremium() { return isPremium; }
  public void setPremium(boolean premium) { isPremium = premium; }

  public String getDifficulty() { return difficulty; }
  public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

  public String getQuestionLink() { return questionLink; }
  public void setQuestionLink(String questionLink) { this.questionLink = questionLink; }

  public String getSolutionLink() { return solutionLink; }
  public void setSolutionLink(String solutionLink) { this.solutionLink = solutionLink; }

  @Override
  public String toString() {
    return "Problem{id=" + id + ", title='" + title + "', difficulty='" + difficulty + "'}";
  }
}
