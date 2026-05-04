package com.portfolio.model;

public class Skill {

    private int id;
    private int userId;
    private String name;
    private String category;
    private int proficiencyLevel;

    public Skill() {
    }

    public Skill(int id, int userId, String name,
            String category, int proficiencyLevel) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.category = category;
        this.proficiencyLevel = proficiencyLevel;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public String getCategory() {
        return category;
    }

    public int getProficiencyLevel() {
        return proficiencyLevel;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setProficiencyLevel(int proficiency) {
        this.proficiencyLevel = proficiency;
    }
}