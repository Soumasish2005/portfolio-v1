package com.portfolio.dao;

import com.portfolio.model.Skill;
import com.portfolio.util.DBConnection;

import java.sql.*;
import java.util.*;

public class SkillDAO {

    /** Returns all skills for a user, ordered by category then name. */
    public List<Skill> findAllByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM skills WHERE user_id = ? ORDER BY category, name";
        List<Skill> list = new ArrayList<>();
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

    public Skill findById(int id) throws SQLException {
        String sql = "SELECT * FROM skills WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public int insert(Skill s) throws SQLException {
        String sql = "INSERT INTO skills (user_id, name, category, proficiency_level) "
                + "VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, s.getUserId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getCategory());
            ps.setInt(4, s.getProficiencyLevel());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public void update(Skill s) throws SQLException {
        String sql = "UPDATE skills SET name = ?, category = ?, "
                + "proficiency_level = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getCategory());
            ps.setInt(3, s.getProficiencyLevel());
            ps.setInt(4, s.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM skills WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Skill map(ResultSet rs) throws SQLException {
        Skill s = new Skill();
        s.setId(rs.getInt("id"));
        s.setUserId(rs.getInt("user_id"));
        s.setName(rs.getString("name"));
        s.setCategory(rs.getString("category"));
        s.setProficiencyLevel(rs.getInt("proficiency_level"));
        return s;
    }
}