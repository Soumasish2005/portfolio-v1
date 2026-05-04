package com.portfolio.servlet.auth;

import com.portfolio.dao.UserDAO;
import com.portfolio.model.User;
import com.portfolio.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    /** GET — show the register form */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // If already logged in, go straight to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }
        req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
    }

    /** POST — process registration */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Sanitize inputs
        String username = sanitize(req.getParameter("username"));
        String email = sanitize(req.getParameter("email"));
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        // ── Server-side validation ──────────────────────────
        if (username.isEmpty() || email.isEmpty()
                || password == null || password.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
            return;
        }

        if (password.length() < 8) {
            req.setAttribute("error", "Password must be at least 8 characters.");
            req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
            return;
        }

        try {
            // Check for duplicate username / email
            if (userDAO.findByUsername(username) != null) {
                req.setAttribute("error", "Username already taken.");
                req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
                return;
            }
            if (userDAO.findByEmail(email) != null) {
                req.setAttribute("error", "Email already registered.");
                req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
                return;
            }

            // Hash password and persist
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPasswordHash(PasswordUtil.hash(password));

            userDAO.insert(newUser);

            res.sendRedirect(req.getContextPath()
                    + "/login?registered=true");

        } catch (Exception e) {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/auth/register.jsp").forward(req, res);
        }
    }

    /** Trims and escapes a request parameter. */
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