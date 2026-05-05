<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="../../pages/includes/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
    <title>Education – Admin</title>
</head>

<body>
    <jsp:include page="../../pages/includes/nav.jsp" />

    <div class="page-content">
        <div class="admin-layout">
            <jsp:include page="../includes/sidebar.jsp" />

            <main class="admin-main">
                <div class="admin-main__header">
                    <h1>Education</h1>
                    <p>Manage your educational background and qualifications.</p>
                </div>

                <c:if test="${param.added eq 'true'}">
                    <div class="alert alert-success">✓ Education added successfully.</div>
                </c:if>
                <c:if test="${param.updated eq 'true'}">
                    <div class="alert alert-success">✓ Education updated.</div>
                </c:if>
                <c:if test="${param.deleted eq 'true'}">
                    <div class="alert alert-success">✓ Education deleted.</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <div class="admin-table-wrap">
                    <div class="admin-table-wrap__header">
                        <h3>All Education</h3>
                        <a href="${pageContext.request.contextPath}/admin/education?action=add"
                            class="btn btn-primary btn-sm">+ Add Education</a>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Institution</th>
                                <th>Degree/Field</th>
                                <th>Duration</th>
                                <th>Score (GPA/%)</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty educations}">
                                    <c:forEach var="e" items="${educations}">
                                        <tr>
                                            <td>${e.id}</td>
                                            <td>
                                                <c:out value="${e.institution}" />
                                            </td>
                                            <td>
                                                <c:out value="${e.degree}"/> 
                                                <c:if test="${not empty e.field}"> in <c:out value="${e.field}"/></c:if>
                                            </td>
                                            <td>${e.yearRange}</td>
                                            <td>
                                                <small>
                                                    <c:choose>
                                                        <c:when test="${not empty e.gpa}">${e.gpa} GPA</c:when>
                                                        <c:when test="${not empty e.percentage}">${e.percentage}%</c:when>
                                                        <c:otherwise>—</c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </td>
                                            <td>
                                                <div class="table-actions">
                                                    <a href="${pageContext.request.contextPath}/admin/education?action=edit&id=${e.id}"
                                                        class="btn btn-sm btn-outline">Edit</a>
                                                    <a href="${pageContext.request.contextPath}/admin/education?action=delete&id=${e.id}"
                                                        class="btn btn-sm btn-danger"
                                                        onclick="return confirm('Delete this education entry?')">Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" style="text-align:center; padding:24px;color:var(--text-light)">
                                            No education entries yet.
                                            <a href="${pageContext.request.contextPath}/admin/education?action=add">
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
