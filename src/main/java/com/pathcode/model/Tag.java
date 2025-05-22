package com.pathcode.model;

/**
 * Tag entity class representing the Tag table
 */
public class Tag {
    private int id;
    private String name;
    
    // Default constructor
    public Tag() {
    }
    
    // Constructor with fields
    public Tag(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Tag [id=" + id + ", name=" + name + "]";
    }
}