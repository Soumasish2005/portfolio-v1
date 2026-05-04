<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Skills – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Skills</h1>
                            <p>Manage your technical skills and proficiency levels.</p>
                        </div>

                        <c:if test="${param.added eq 'true'}">
                            <div class="alert alert-success">✓ Skill added.</div>
                        </c:if>
                        <c:if test="${param.updated eq 'true'}">
                            <div class="alert alert-success">✓ Skill updated.</div>
                        </c:if>
                        <c:if test="${param.deleted eq 'true'}">
                            <div class="alert alert-success">✓ Skill deleted.</div>
                        </c:if>

                        <div class="admin-table-wrap">
                            <div class="admin-table-wrap__header">
                                <h3>All Skills</h3>
                                <a href="${pageContext.request.contextPath}/admin/skills?action=add"
                                    class="btn btn-primary btn-sm">+ Add Skill</a>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                        <th>Proficiency</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty skills}">
                                            <c:forEach var="s" items="${skills}">
                                                <tr>
                                                    <td>${s.id}</td>
                                                    <td>
                                                        <c:out value="${s.name}" />
                                                    </td>
                                                    <td>
                                                        <c:out value="${s.category}" />
                                                    </td>
                                                    <td>${s.proficiencyLevel}%</td>
                                                    <td>
                                                        <div class="table-actions">
                                                            <a href="${pageContext.request.contextPath}/admin/skills?action=edit&id=${s.id}"
                                                                class="btn btn-sm btn-outline">Edit</a>
                                                            <a href="${pageContext.request.contextPath}/admin/skills?action=delete&id=${s.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Delete this skill?')">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" style="text-align:center;
                                           padding:24px;color:var(--text-light)">
                                                    No skills yet.
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