package com.portfolio.dao;

import com.portfolio.model.About;
import com.portfolio.util.DBConnection;

import java.sql.*;

public class AboutDAO {

    /** Returns the about record for a given userId. */
    public About findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM about WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /** Updates an existing about record. */
    public void update(About a) throws SQLException {
        String sql = """
                UPDATE about
                   SET tagline = ?, bio = ?, profile_img = ?,
                       clients = ?, projects_count = ?, years_exp = ?
                 WHERE id = ?
                """;
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, a.getTagline());
            ps.setString(2, a.getBio());
            ps.setString(3, a.getProfileImg());
            ps.setInt(4, a.getClients());
            ps.setInt(5, a.getProjectsCount());
            ps.setInt(6, a.getYearsExp());
            ps.setInt(7, a.getId());
            ps.executeUpdate();
        }
    }

    private About map(ResultSet rs) throws SQLException {
        About a = new About();
        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("user_id"));
        a.setTagline(rs.getString("tagline"));
        a.setBio(rs.getString("bio"));
        a.setProfileImg(rs.getString("profile_img"));
        a.setClients(rs.getInt("clients"));
        a.setProjectsCount(rs.getInt("projects_count"));
        a.setYearsExp(rs.getInt("years_exp"));
        return a;
    }
}