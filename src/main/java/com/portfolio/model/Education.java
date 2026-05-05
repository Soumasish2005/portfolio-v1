package com.portfolio.model;

public class Education {

    private int id;
    private int userId;
    private String institution;
    private String degree;
    private String field;
    private int startYear;
    private Integer endYear;
    private Double gpa;
    private Double percentage;

    public Education() {
    }

    public Education(int id, int userId, String institution, String degree,
            String field, int startYear, Integer endYear, Double gpa, Double percentage) {
        this.id = id;
        this.userId = userId;
        this.institution = institution;
        this.degree = degree;
        this.field = field;
        this.startYear = startYear;
        this.endYear = endYear;
        this.gpa = gpa;
        this.percentage = percentage;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getInstitution() {
        return institution;
    }

    public String getDegree() {
        return degree;
    }

    public String getField() {
        return field;
    }

    public int getStartYear() {
        return startYear;
    }

    public Integer getEndYear() {
        return endYear;
    }

    public Double getGpa() {
        return gpa;
    }

    public Double getPercentage() {
        return percentage;
    }

    public String getYearRange() {
        return startYear + " – " + (endYear == null ? "Present" : endYear);
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setInstitution(String inst) {
        this.institution = inst;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public void setField(String field) {
        this.field = field;
    }

    public void setStartYear(int startYear) {
        this.startYear = startYear;
    }

    public void setEndYear(Integer endYear) {
        this.endYear = endYear;
    }

    public void setGpa(Double gpa) {
        this.gpa = gpa;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }
}