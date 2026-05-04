package com.portfolio.servlet.admin;

import com.portfolio.dao.ProjectDAO;
import com.portfolio.model.Project;
import com.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Handles all project CRUD operations.
 *
 * GET /admin/projects → list all projects
 * GET /admin/projects?action=add → show add form
 * GET /admin/projects?action=edit&id={n} → show edit form
 * GET /admin/projects?action=delete&id={n} → delete and redirect
 * POST /admin/projects?action=add → insert new project
 * POST /admin/projects?action=update → update existing project
 */
public class ProjectCRUDServlet extends AdminBaseServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();

    // ── GET ──────────────────────────────────────────────────
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
                    req.getRequestDispatcher("/admin/projects/add.jsp")
                            .forward(req, res);
                }

                case "edit" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Project p = projectDAO.findById(id);
                    if (p == null || p.getUserId() != user.getId()) {
                        res.sendRedirect(req.getContextPath() + "/admin/projects");
                        return;
                    }
                    req.setAttribute("project", p);
                    req.getRequestDispatcher("/admin/projects/edit.jsp")
                            .forward(req, res);
                }

                case "delete" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Project p = projectDAO.findById(id);
                    // Only delete if this project belongs to the logged-in user
                    if (p != null && p.getUserId() == user.getId()) {
                        projectDAO.delete(id);
                    }
                    res.sendRedirect(req.getContextPath()
                            + "/admin/projects?deleted=true");
                }

                default -> {
                    req.setAttribute("projects",
                            projectDAO.findAllByUser(user.getId()));
                    req.getRequestDispatcher("/admin/projects/list.jsp")
                            .forward(req, res);
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
            req.getRequestDispatcher("/admin/projects/list.jsp").forward(req, res);
        }
    }

    // ── POST ─────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = requireLogin(req, res);
        if (user == null)
            return;

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                Project p = buildFromRequest(req, user.getId());
                projectDAO.insert(p);
                res.sendRedirect(req.getContextPath()
                        + "/admin/projects?added=true");

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Project existing = projectDAO.findById(id);

                if (existing == null || existing.getUserId() != user.getId()) {
                    res.sendRedirect(req.getContextPath() + "/admin/projects");
                    return;
                }

                Project updated = buildFromRequest(req, user.getId());
                updated.setId(id);
                projectDAO.update(updated);
                res.sendRedirect(req.getContextPath()
                        + "/admin/projects?updated=true");

            } else {
                res.sendRedirect(req.getContextPath() + "/admin/projects");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Save failed: " + e.getMessage());
            req.getRequestDispatcher("/admin/projects/list.jsp").forward(req, res);
        }
    }

    /** Builds a Project from POST parameters, sanitizing each field. */
    private Project buildFromRequest(HttpServletRequest req, int userId) {
        Project p = new Project();
        p.setUserId(userId);
        p.setTitle(sanitize(req.getParameter("title")));
        p.setDescription(sanitize(req.getParameter("description")));
        p.setTechStack(sanitize(req.getParameter("techStack")));
        p.setGithubUrl(sanitize(req.getParameter("githubUrl")));
        p.setLiveUrl(sanitize(req.getParameter("liveUrl")));
        p.setFeatured("on".equals(req.getParameter("featured")));
        return p;
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