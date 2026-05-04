package com.portfolio.servlet.public_;

import com.portfolio.dao.AboutDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AboutServlet extends HttpServlet {

    private final AboutDAO aboutDAO = new AboutDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("about", aboutDAO.findByUserId(1));
        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/about.jsp").forward(req, res);
    }
}