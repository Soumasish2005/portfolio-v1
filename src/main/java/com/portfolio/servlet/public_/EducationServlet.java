package com.portfolio.servlet.public_;

import com.portfolio.dao.EducationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class EducationServlet extends HttpServlet {

    private final EducationDAO educationDAO = new EducationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("educationList", educationDAO.findAllByUser(1));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/education.jsp").forward(req, res);
    }
}