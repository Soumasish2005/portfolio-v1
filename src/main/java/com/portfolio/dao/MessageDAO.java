package com.portfolio.dao;

import com.portfolio.model.Message;
import com.portfolio.util.DBConnection;

import java.sql.*;
import java.util.*;

public class MessageDAO {

    /** All messages, unread first, then newest. */
    public List<Message> findAll() throws SQLException {
        String sql = "SELECT * FROM messages ORDER BY is_read ASC, sent_at DESC";
        List<Message> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next())
                list.add(map(rs));
        }
        return list;
    }

    /** Inserts a new contact form submission. */
    public int insert(Message m) throws SQLException {
        String sql = "INSERT INTO messages (name, email, message) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, m.getName());
            ps.setString(2, m.getEmail());
            ps.setString(3, m.getMessage());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    /** Marks a message as read. */
    public void markRead(int id) throws SQLException {
        String sql = "UPDATE messages SET is_read = 1 WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    /** Unread message count — used for the dashboard badge. */
    public int countUnread() throws SQLException {
        String sql = "SELECT COUNT(*) FROM messages WHERE is_read = 0";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Message map(ResultSet rs) throws SQLException {
        Message m = new Message();
        m.setId(rs.getInt("id"));
        m.setName(rs.getString("name"));
        m.setEmail(rs.getString("email"));
        m.setMessage(rs.getString("message"));
        Timestamp ts = rs.getTimestamp("sent_at");
        m.setSentAt(ts != null ? ts.toLocalDateTime() : null);
        m.setRead(rs.getBoolean("is_read"));
        return m;
    }
}