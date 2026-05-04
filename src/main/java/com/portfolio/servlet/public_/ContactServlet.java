package com.portfolio.servlet.public_;

import com.portfolio.dao.MessageDAO;
import com.portfolio.model.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ContactServlet extends HttpServlet {

    private final MessageDAO messageDAO = new MessageDAO();

    /** GET — show the contact form */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/pages/contact.jsp").forward(req, res);
    }

    /** POST — save the message and redirect with success flag */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = sanitize(req.getParameter("name"));
        String email = sanitize(req.getParameter("email"));
        String content = sanitize(req.getParameter("message"));

        // Server-side validation (client-side is in validation.js)
        if (name.isEmpty() || email.isEmpty() || content.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/pages/contact.jsp").forward(req, res);
            return;
        }

        if (!email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$")) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.getRequestDispatcher("/pages/contact.jsp").forward(req, res);
            return;
        }

        try {
            Message msg = new Message();
            msg.setName(name);
            msg.setEmail(email);
            msg.setMessage(content);
            messageDAO.insert(msg);
            res.sendRedirect(req.getContextPath() + "/contact?sent=true");

        } catch (Exception e) {
            req.setAttribute("error", "Could not send message. Please try again.");
            req.getRequestDispatcher("/pages/contact.jsp").forward(req, res);
        }
    }

    private String sanitize(String v) {
        if (v == null)
            return "";
        return v.trim()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
}