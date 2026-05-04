package com.portfolio.model;

public class About {

    private int id;
    private int userId;
    private String tagline;
    private String bio;
    private String profileImg;
    private int clients;
    private int projectsCount;
    private int yearsExp;

    public About() {
    }

    public About(int id, int userId, String tagline, String bio,
            String profileImg, int clients, int projectsCount, int yearsExp) {
        this.id = id;
        this.userId = userId;
        this.tagline = tagline;
        this.bio = bio;
        this.profileImg = profileImg;
        this.clients = clients;
        this.projectsCount = projectsCount;
        this.yearsExp = yearsExp;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getTagline() {
        return tagline;
    }

    public String getBio() {
        return bio;
    }

    public String getBioPreview() {
        if (bio == null || bio.length() <= 200) return bio;
        return bio.substring(0, 200) + "...";
    }

    public String[] getBioParagraphs() {
    if (bio == null || bio.isEmpty()) return new String[0];
    return bio.split("(?<=\\.) (?=[A-Z])");
}

    public String getProfileImg() {
        return profileImg;
    }

    public int getClients() {
        return clients;
    }

    public int getProjectsCount() {
        return projectsCount;
    }

    public int getYearsExp() {
        return yearsExp;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTagline(String tagline) {
        this.tagline = tagline;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }

    public void setClients(int clients) {
        this.clients = clients;
    }

    public void setProjectsCount(int c) {
        this.projectsCount = c;
    }

    public void setYearsExp(int yearsExp) {
        this.yearsExp = yearsExp;
    }
}