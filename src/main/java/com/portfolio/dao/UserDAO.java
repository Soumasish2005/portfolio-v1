package com.portfolio.dao;

import com.portfolio.model.User;
import com.portfolio.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;

public class UserDAO {

    /** Inserts a new user. Returns generated id, or -1 on failure. */
    public int insert(User user) throws SQLException {
        String sql = "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    /** Finds a user by username. Returns null if not found. */
    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /** Finds a user by email. Returns null if not found. */
    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /** Maps the current ResultSet row to a User object. */
    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPasswordHash(rs.getString("password_hash"));
        Timestamp ts = rs.getTimestamp("created_at");
        u.setCreatedAt(ts != null ? ts.toLocalDateTime() : LocalDateTime.now());
        return u;
    }

    /** Returns the ID of the most recently registered user. Defaults to 1 if empty. */
    public int getLatestUserId() {
        String sql = "SELECT id FROM users ORDER BY id DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }
}