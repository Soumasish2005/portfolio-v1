package com.portfolio.servlet.public_;

import com.portfolio.dao.SkillDAO;
import com.portfolio.model.Skill;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

public class SkillsServlet extends HttpServlet {

    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            List<Skill> skills = skillDAO.findAllByUser(1);

            // Group skills by category for the JSP to render section by section
            Map<String, List<Skill>> grouped = new LinkedHashMap<>();
            for (Skill s : skills) {
                grouped.computeIfAbsent(s.getCategory(), k -> new ArrayList<>()).add(s);
            }
            req.setAttribute("skillsByCategory", grouped);

        } catch (Exception ignored) {
        }

        req.getRequestDispatcher("/pages/skills.jsp").forward(req, res);
    }
}