package com.portfolio.servlet.public_;

import com.portfolio.dao.AboutDAO;
import com.portfolio.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AboutServlet extends HttpServlet {

    private final AboutDAO aboutDAO = new AboutDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int ownerId = userDAO.getLatestUserId();
            req.setAttribute("about", aboutDAO.findByUserId(ownerId));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/about.jsp").forward(req, res);
    }
}