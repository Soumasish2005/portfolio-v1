package com.portfolio.servlet.public_;

import com.portfolio.dao.ProjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ProjectsServlet extends HttpServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("projects", projectDAO.findAllByUser(1));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/projects.jsp").forward(req, res);
    }
}