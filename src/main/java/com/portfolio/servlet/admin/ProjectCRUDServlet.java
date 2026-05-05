package com.portfolio.servlet.admin;

import com.portfolio.dao.ProjectDAO;
import com.portfolio.model.Project;
import com.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;
import java.util.UUID;

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
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB – write to disk above this
        maxFileSize = 5 * 1024 * 1024, // 5 MB per file
        maxRequestSize = 10 * 1024 * 1024 // 10 MB total
)
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
                Project p = buildFromRequest(req, user.getId(), null);
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

                // Pass existing cover so we can keep it if no new file uploaded
                Project updated = buildFromRequest(req, user.getId(), existing.getCoverImage());
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

    // ── Helpers ───────────────────────────────────────────────

    /**
     * Builds a Project from POST parameters. existingCover is kept when no new file
     * is uploaded.
     */
    private Project buildFromRequest(HttpServletRequest req, int userId, String existingCover)
            throws IOException, ServletException {

        Project p = new Project();
        p.setUserId(userId);
        p.setTitle(sanitize(req.getParameter("title")));
        p.setDescription(sanitize(req.getParameter("description")));
        p.setTechStack(sanitize(req.getParameter("techStack")));
        p.setGithubUrl(sanitize(req.getParameter("githubUrl")));
        p.setLiveUrl(sanitize(req.getParameter("liveUrl")));
        p.setFeatured("on".equals(req.getParameter("featured")));

        // Handle cover image upload only when project is featured
        if (p.isFeatured()) {
            String uploadedPath = handleCoverUpload(req);
            p.setCoverImage(uploadedPath != null ? uploadedPath : existingCover);
        } else {
            // Not featured — no cover needed
            p.setCoverImage(null);
        }

        return p;
    }

    /**
     * Saves the uploaded cover image to the directory specified by the
     * UPLOAD_DIR environment variable (mapped to a Docker bind-mount volume).
     * Falls back to /tmp/portfolio-uploads if the env var is absent.
     *
     * Returns the relative web path used in the src attribute, or null if no
     * file was selected / the extension is not an image.
     */
    private String handleCoverUpload(HttpServletRequest req)
            throws IOException, ServletException {

        Part filePart = req.getPart("coverImage");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String ext = originalName.contains(".")
                ? originalName.substring(originalName.lastIndexOf('.'))
                : "";

        if (!ext.matches("(?i)\\.(jpg|jpeg|png|webp|gif|avif)")) {
            return null;
        }

        String savedName = UUID.randomUUID() + ext;

        String uploadBase = System.getenv("UPLOAD_DIR");
        if (uploadBase == null || uploadBase.isBlank()) {
            uploadBase = "/tmp/portfolio-uploads";
        }

        Path uploadPath = Paths.get(uploadBase);
        Files.createDirectories(uploadPath);

        filePart.write(uploadPath.resolve(savedName).toString());

        // Web path — must match the alias configured in context.xml
        return "uploads/project-covers/" + savedName;
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