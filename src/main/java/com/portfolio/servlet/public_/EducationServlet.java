package com.portfolio.servlet.public_;

import com.portfolio.dao.EducationDAO;
import com.portfolio.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class EducationServlet extends HttpServlet {

    private final EducationDAO educationDAO = new EducationDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int ownerId = userDAO.getLatestUserId();
            req.setAttribute("educationList", educationDAO.findAllByUser(ownerId));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/education.jsp").forward(req, res);
    }
}