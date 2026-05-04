package com.portfolio.servlet.public_;

import com.portfolio.dao.AboutDAO;
import com.portfolio.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class HomeServlet extends HttpServlet {

    private final AboutDAO aboutDAO = new AboutDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // Owner is the latest registered user
            int ownerId = userDAO.getLatestUserId();
            req.setAttribute("about", aboutDAO.findByUserId(ownerId));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/index.jsp").forward(req, res);
    }
}