package com.portfolio.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Singleton JDBC connection helper.
 * Returns a fresh Connection per call — safe for servlet-per-request model.
 */
public class DBConnection {

    private static final String HOST     = getEnv("DB_HOST",     "localhost");
    private static final String PORT     = getEnv("DB_PORT",     "3306");
    private static final String NAME     = getEnv("DB_NAME",     "portfolio_db");
    private static final String USER     = getEnv("DB_USER",     "root");
    private static final String PASSWORD = getEnv("DB_PASSWORD", "Soumasish123#");

    private static final String URL =
            "jdbc:mysql://" + HOST + ":" + PORT + "/" + NAME
            + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    // private static final String USER     = "root";   // change as needed
    // private static final String PASSWORD = "Soumasish123#";        // change as needed

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                "MySQL JDBC Driver not found: " + e.getMessage()
            );
        }
    }

    /** Returns a new Connection. Caller is responsible for closing it. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String getEnv(String key, String fallback) {
        String val = System.getenv(key);
        return (val != null && !val.isEmpty()) ? val : fallback;
    }

    private DBConnection() {}   // prevent instantiation

    // MAIN METHOD FOR TESTING
    // public static void main(String[] args) {
    //     try (Connection conn = DBConnection.getConnection()) {
    //         if (conn != null && !conn.isClosed()) {
    //             System.out.println("Database connected successfully!");
    //         }
    //     } catch (SQLException e) {
    //         System.out.println("Connection failed!");
    //         e.printStackTrace();
    //     }
    // }
}