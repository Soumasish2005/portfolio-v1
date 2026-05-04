package com.portfolio.servlet.admin;

import com.portfolio.dao.*;
import com.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class DashboardServlet extends AdminBaseServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = requireLogin(req, res);
        if (user == null)
            return;

        try {
            req.setAttribute("projects", projectDAO.findAllByUser(user.getId()));
            req.setAttribute("skills", skillDAO.findAllByUser(user.getId()));
            req.setAttribute("messages", messageDAO.findAll());
            req.setAttribute("unreadCount", messageDAO.countUnread());

        } catch (Exception e) {
            req.setAttribute("dbError", "Could not load dashboard data.");
        }

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
    }
}