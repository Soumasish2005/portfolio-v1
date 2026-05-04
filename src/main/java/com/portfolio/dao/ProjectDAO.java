package com.portfolio.dao;

import com.portfolio.model.Project;
import com.portfolio.util.DBConnection;

import java.sql.*;
import java.util.*;

public class ProjectDAO {

    public List<Project> findAllByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM projects WHERE user_id = ? "
                + "ORDER BY featured DESC, created_at DESC";
        List<Project> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(map(rs));
            }
        }
        return list;
    }

    public Project findById(int id) throws SQLException {
        String sql = "SELECT * FROM projects WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public int insert(Project p) throws SQLException {
        String sql = """
                INSERT INTO projects
                    (user_id, title, description, tech_stack, github_url, live_url, featured)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getTitle());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getTechStack());
            ps.setString(5, p.getGithubUrl());
            ps.setString(6, p.getLiveUrl());
            ps.setBoolean(7, p.isFeatured());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public void update(Project p) throws SQLException {
        String sql = """
                UPDATE projects
                   SET title = ?, description = ?, tech_stack = ?,
                       github_url = ?, live_url = ?, featured = ?
                 WHERE id = ?
                """;
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setString(3, p.getTechStack());
            ps.setString(4, p.getGithubUrl());
            ps.setString(5, p.getLiveUrl());
            ps.setBoolean(6, p.isFeatured());
            ps.setInt(7, p.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM projects WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Project map(ResultSet rs) throws SQLException {
        Project p = new Project();
        p.setId(rs.getInt("id"));
        p.setUserId(rs.getInt("user_id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setTechStack(rs.getString("tech_stack"));
        p.setGithubUrl(rs.getString("github_url"));
        p.setLiveUrl(rs.getString("live_url"));
        p.setFeatured(rs.getBoolean("featured"));
        Timestamp ts = rs.getTimestamp("created_at");
        p.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
        return p;
    }
}