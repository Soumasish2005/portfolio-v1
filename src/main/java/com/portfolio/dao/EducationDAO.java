package com.portfolio.dao;

import com.portfolio.model.Education;
import com.portfolio.util.DBConnection;

import java.sql.*;
import java.util.*;

public class EducationDAO {

    public List<Education> findAllByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM education WHERE user_id = ? ORDER BY start_year DESC";
        List<Education> list = new ArrayList<>();
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

    public Education findById(int id) throws SQLException {
        String sql = "SELECT * FROM education WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public int insert(Education e) throws SQLException {
        String sql = """
                INSERT INTO education
                    (user_id, institution, degree, field, start_year, end_year, gpa, percentage)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, e.getUserId());
            ps.setString(2, e.getInstitution());
            ps.setString(3, e.getDegree());
            ps.setString(4, e.getField());
            ps.setInt(5, e.getStartYear());

            if (e.getEndYear() == null)
                ps.setNull(6, Types.SMALLINT);
            else
                ps.setInt(6, e.getEndYear());

            if (e.getGpa() == null)
                ps.setNull(7, Types.DECIMAL);
            else
                ps.setDouble(7, e.getGpa());

            if (e.getPercentage() == null)
                ps.setNull(8, Types.DECIMAL);
            else
                ps.setDouble(8, e.getPercentage());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public void update(Education e) throws SQLException {
        String sql = """
                UPDATE education
                   SET institution = ?, degree = ?, field = ?,
                       start_year = ?, end_year = ?, gpa = ?, percentage = ?
                 WHERE id = ?
                """;
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, e.getInstitution());
            ps.setString(2, e.getDegree());
            ps.setString(3, e.getField());
            ps.setInt(4, e.getStartYear());

            if (e.getEndYear() == null)
                ps.setNull(5, Types.SMALLINT);
            else
                ps.setInt(5, e.getEndYear());

            if (e.getGpa() == null)
                ps.setNull(6, Types.DECIMAL);
            else
                ps.setDouble(6, e.getGpa());

            if (e.getPercentage() == null)
                ps.setNull(7, Types.DECIMAL);
            else
                ps.setDouble(7, e.getPercentage());

            ps.setInt(8, e.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM education WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Education map(ResultSet rs) throws SQLException {
        Education e = new Education();
        e.setId(rs.getInt("id"));
        e.setUserId(rs.getInt("user_id"));
        e.setInstitution(rs.getString("institution"));
        e.setDegree(rs.getString("degree"));
        e.setField(rs.getString("field"));
        e.setStartYear(rs.getInt("start_year"));

        int endYear = rs.getInt("end_year");
        e.setEndYear(rs.wasNull() ? null : endYear);

        double gpa = rs.getDouble("gpa");
        e.setGpa(rs.wasNull() ? null : gpa);

        double percentage = rs.getDouble("percentage");
        e.setPercentage(rs.wasNull() ? null : percentage);

        return e;
    }
}