package com.portfolio.servlet.admin;

import com.portfolio.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Base class for all admin servlets.
 * Checks session before every request — unauthenticated users
 * are redirected to /login immediately (M8 session guard).
 */

public abstract class AdminBaseServlet extends HttpServlet {

    /**
     * Returns the logged-in user or redirects to login. Returns null if redirected.
     */
    protected User requireLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null)
                ? (User) session.getAttribute("loggedInUser")
                : null;

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return null;
        }
        return user;
    }
}