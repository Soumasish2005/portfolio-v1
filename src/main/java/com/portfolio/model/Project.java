package com.portfolio.model;

import java.time.LocalDateTime;

public class Project {

    private int id;
    private int userId;
    private String title;
    private String description;
    private String techStack;
    private String githubUrl;
    private String liveUrl;
    private boolean featured;
    private LocalDateTime createdAt;

    public Project() {
    }

    public Project(int id, int userId, String title, String description,
            String techStack, String githubUrl, String liveUrl,
            boolean featured, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.techStack = techStack;
        this.githubUrl = githubUrl;
        this.liveUrl = liveUrl;
        this.featured = featured;
        this.createdAt = createdAt;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getTechStack() {
        return techStack;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public String getLiveUrl() {
        return liveUrl;
    }

    public boolean isFeatured() {
        return featured;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    /** Convenience: splits techStack CSV into a trimmed array for JSP iteration. */
    public String[] getTechArray() {
        return techStack == null ? new String[0]
                : techStack.split("\\s*,\\s*");
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String desc) {
        this.description = desc;
    }

    public void setTechStack(String techStack) {
        this.techStack = techStack;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public void setLiveUrl(String liveUrl) {
        this.liveUrl = liveUrl;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public void setCreatedAt(LocalDateTime c) {
        this.createdAt = c;
    }
}