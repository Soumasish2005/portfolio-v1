package com.portfolio.servlet.admin;

import com.portfolio.dao.EducationDAO;
import com.portfolio.model.Education;
import com.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class EducationCRUDServlet extends AdminBaseServlet {

    private final EducationDAO educationDAO = new EducationDAO();

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
                    req.getRequestDispatcher("/admin/education/add.jsp").forward(req, res);
                }
                case "edit" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Education e = educationDAO.findById(id);
                    if (e == null || e.getUserId() != user.getId()) {
                        res.sendRedirect(req.getContextPath() + "/admin/education");
                        return;
                    }
                    req.setAttribute("education", e);
                    req.getRequestDispatcher("/admin/education/edit.jsp").forward(req, res);
                }
                case "delete" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Education e = educationDAO.findById(id);
                    if (e != null && e.getUserId() == user.getId()) {
                        educationDAO.delete(id);
                    }
                    res.sendRedirect(req.getContextPath() + "/admin/education?deleted=true");
                }
                default -> {
                    req.setAttribute("educations", educationDAO.findAllByUser(user.getId()));
                    req.getRequestDispatcher("/admin/education/list.jsp").forward(req, res);
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
            req.getRequestDispatcher("/admin/education/list.jsp").forward(req, res);
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
                Education e = buildFromRequest(req, user.getId());
                educationDAO.insert(e);
                res.sendRedirect(req.getContextPath() + "/admin/education?added=true");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Education existing = educationDAO.findById(id);

                if (existing == null || existing.getUserId() != user.getId()) {
                    res.sendRedirect(req.getContextPath() + "/admin/education");
                    return;
                }

                Education updated = buildFromRequest(req, user.getId());
                updated.setId(id);
                educationDAO.update(updated);
                res.sendRedirect(req.getContextPath() + "/admin/education?updated=true");
            } else {
                res.sendRedirect(req.getContextPath() + "/admin/education");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Save failed: " + e.getMessage());
            req.getRequestDispatcher("/admin/education/list.jsp").forward(req, res);
        }
    }

    private Education buildFromRequest(HttpServletRequest req, int userId) {
        Education e = new Education();
        e.setUserId(userId);
        e.setInstitution(sanitize(req.getParameter("institution")));
        e.setDegree(sanitize(req.getParameter("degree")));
        e.setField(sanitize(req.getParameter("field")));
        e.setStartYear(Integer.parseInt(req.getParameter("startYear")));
        
        String endYearParam = req.getParameter("endYear");
        if (endYearParam == null || endYearParam.trim().isEmpty()) {
            e.setEndYear(null);
        } else {
            e.setEndYear(Integer.parseInt(endYearParam));
        }

        String gpaParam = req.getParameter("gpa");
        if (gpaParam == null || gpaParam.trim().isEmpty()) {
            e.setGpa(null);
        } else {
            e.setGpa(Double.parseDouble(gpaParam));
        }

        String percentageParam = req.getParameter("percentage");
        if (percentageParam == null || percentageParam.trim().isEmpty()) {
            e.setPercentage(null);
        } else {
            e.setPercentage(Double.parseDouble(percentageParam));
        }
        
        return e;
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
