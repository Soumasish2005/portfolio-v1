package com.portfolio.servlet.admin;

import com.portfolio.dao.SkillDAO;
import com.portfolio.model.Skill;
import com.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * GET /admin/skills → list
 * GET /admin/skills?action=add → add form
 * GET /admin/skills?action=edit&id={n} → edit form
 * GET /admin/skills?action=delete&id={n} → delete + redirect
 * POST /admin/skills?action=add → insert
 * POST /admin/skills?action=update → update
 */
public class SkillCRUDServlet extends AdminBaseServlet {

    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = requireLogin(req, res);
        if (user == null)
            return;

        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {

                case "add" -> {
                    req.getRequestDispatcher("/admin/skills/add.jsp")
                            .forward(req, res);
                }

                case "edit" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Skill s = skillDAO.findById(id);
                    if (s == null || s.getUserId() != user.getId()) {
                        res.sendRedirect(req.getContextPath() + "/admin/skills");
                        return;
                    }
                    req.setAttribute("skill", s);
                    req.getRequestDispatcher("/admin/skills/edit.jsp")
                            .forward(req, res);
                }

                case "delete" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Skill s = skillDAO.findById(id);
                    if (s != null && s.getUserId() == user.getId()) {
                        skillDAO.delete(id);
                    }
                    res.sendRedirect(req.getContextPath()
                            + "/admin/skills?deleted=true");
                }

                default -> {
                    req.setAttribute("skills",
                            skillDAO.findAllByUser(user.getId()));
                    req.getRequestDispatcher("/admin/skills/list.jsp")
                            .forward(req, res);
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
            req.getRequestDispatcher("/admin/skills/list.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = requireLogin(req, res);
        if (user == null)
            return;

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                Skill s = buildFromRequest(req, user.getId());
                skillDAO.insert(s);
                res.sendRedirect(req.getContextPath()
                        + "/admin/skills?added=true");

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Skill existing = skillDAO.findById(id);

                if (existing == null || existing.getUserId() != user.getId()) {
                    res.sendRedirect(req.getContextPath() + "/admin/skills");
                    return;
                }

                Skill updated = buildFromRequest(req, user.getId());
                updated.setId(id);
                skillDAO.update(updated);
                res.sendRedirect(req.getContextPath()
                        + "/admin/skills?updated=true");

            } else {
                res.sendRedirect(req.getContextPath() + "/admin/skills");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Save failed: " + e.getMessage());
            req.getRequestDispatcher("/admin/skills/list.jsp").forward(req, res);
        }
    }

    private Skill buildFromRequest(HttpServletRequest req, int userId) {
        Skill s = new Skill();
        s.setUserId(userId);
        s.setName(sanitize(req.getParameter("name")));
        s.setCategory(sanitize(req.getParameter("category")));
        s.setProficiencyLevel(
                Integer.parseInt(req.getParameter("proficiencyLevel")));
        return s;
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