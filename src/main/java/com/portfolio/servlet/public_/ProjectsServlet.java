package com.portfolio.servlet.public_;

import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ProjectsServlet extends HttpServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int ownerId = userDAO.getLatestUserId();
            req.setAttribute("projects", projectDAO.findAllByUser(ownerId));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/projects.jsp").forward(req, res);
    }
}