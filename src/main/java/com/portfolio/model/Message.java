package com.portfolio.model;

import java.time.LocalDateTime;

public class Message {

    private int id;
    private String name;
    private String email;
    private String message;
    private LocalDateTime sentAt;
    private boolean isRead;

    public Message() {
    }

    public Message(int id, String name, String email,
            String message, LocalDateTime sentAt, boolean isRead) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.message = message;
        this.sentAt = sentAt;
        this.isRead = isRead;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getMessage() {
        return message;
    }

    public LocalDateTime getSentAt() {
        return sentAt;
    }

    public boolean isRead() {
        return isRead;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setSentAt(LocalDateTime s) {
        this.sentAt = s;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }
}