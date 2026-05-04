<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Projects – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Projects</h1>
                            <p>Add, edit or remove portfolio projects.</p>
                        </div>

                        <c:if test="${param.added eq 'true'}">
                            <div class="alert alert-success">✓ Project added successfully.</div>
                        </c:if>
                        <c:if test="${param.updated eq 'true'}">
                            <div class="alert alert-success">✓ Project updated.</div>
                        </c:if>
                        <c:if test="${param.deleted eq 'true'}">
                            <div class="alert alert-success">✓ Project deleted.</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-error">
                                <c:out value="${error}" />
                            </div>
                        </c:if>

                        <div class="admin-table-wrap">
                            <div class="admin-table-wrap__header">
                                <h3>All Projects</h3>
                                <a href="${pageContext.request.contextPath}/admin/projects?action=add"
                                    class="btn btn-primary btn-sm">+ Add Project</a>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>Tech Stack</th>
                                        <th>Featured</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty projects}">
                                            <c:forEach var="p" items="${projects}">
                                                <tr>
                                                    <td>${p.id}</td>
                                                    <td>
                                                        <c:out value="${p.title}" />
                                                    </td>
                                                    <td>
                                                        <c:out value="${p.techStack}" />
                                                    </td>
                                                    <td>${p.featured ? '⭐' : '—'}</td>
                                                    <td>
                                                        <div class="table-actions">
                                                            <a href="${pageContext.request.contextPath}/admin/projects?action=edit&id=${p.id}"
                                                                class="btn btn-sm btn-outline">Edit</a>
                                                            <a href="${pageContext.request.contextPath}/admin/projects?action=delete&id=${p.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Delete this project?')">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" style="text-align:center;
                                           padding:24px;color:var(--text-light)">
                                                    No projects yet.
                                                    <a
                                                        href="${pageContext.request.contextPath}/admin/projects?action=add">
                                                        Add one →
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                    </main>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>