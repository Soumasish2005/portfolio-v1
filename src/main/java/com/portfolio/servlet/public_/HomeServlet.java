package com.portfolio.servlet.public_;

import com.portfolio.dao.AboutDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class HomeServlet extends HttpServlet {

    private final AboutDAO aboutDAO = new AboutDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // Owner is always user id=1 for a single-owner portfolio
            req.setAttribute("about", aboutDAO.findByUserId(1));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/index.jsp").forward(req, res);
    }
}