package com.portfolio.servlet.auth;

import com.portfolio.dao.UserDAO;
import com.portfolio.model.User;
import com.portfolio.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    /** GET — show the login form */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        // Pass "registered=true" flag so JSP can show success banner
        if ("true".equals(req.getParameter("registered"))) {
            req.setAttribute("success",
                    "Account created! You can now log in.");
        }
        req.getRequestDispatcher("/auth/login.jsp").forward(req, res);
    }

    /** POST — authenticate user */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = sanitize(req.getParameter("username"));
        String password = req.getParameter("password");

        if (username.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, res);
            return;
        }

        try {
            User user = userDAO.findByUsername(username);

            // Verify password against stored BCrypt hash
            if (user == null || !PasswordUtil.verify(password, user.getPasswordHash())) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/auth/login.jsp").forward(req, res);
                return;
            }

            // ── Create session ──────────────────────────────
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            res.sendRedirect(req.getContextPath() + "/admin/dashboard");

        } catch (Exception e) {
            req.setAttribute("error", "Login failed. Please try again.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, res);
        }
    }

    private String sanitize(String value) {
        if (value == null)
            return "";
        return value.trim()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
}