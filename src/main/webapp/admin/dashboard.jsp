<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <jsp:include page="../pages/includes/head.jsp" />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
                <title>Dashboard – Admin</title>
            </head>

            <body>

                <jsp:include page="../pages/includes/nav.jsp" />

                <div class="page-content">
                    <div class="admin-layout">

                        <jsp:include page="includes/sidebar.jsp" />

                        <main class="admin-main">
                            <div class="admin-main__header">
                                <h1>Overview</h1>
                                <p>Welcome back,
                                    <strong>${sessionScope.loggedInUser.username}</strong>.
                                </p>
                            </div>

                            <!-- Stat cards -->
                            <div class="admin-stats">
                                <div class="admin-stat-card">
                                    <div class="admin-stat-card__value">${fn:length(projects)}</div>
                                    <div class="admin-stat-card__label">Projects</div>
                                </div>
                                <div class="admin-stat-card">
                                    <div class="admin-stat-card__value">${fn:length(skills)}</div>
                                    <div class="admin-stat-card__label">Skills</div>
                                </div>
                                <div class="admin-stat-card">
                                    <div class="admin-stat-card__value">${fn:length(messages)}</div>
                                    <div class="admin-stat-card__label">Messages</div>
                                </div>
                                <div class="admin-stat-card">
                                    <div class="admin-stat-card__value">${unreadCount}</div>
                                    <div class="admin-stat-card__label">Unread</div>
                                </div>
                            </div>

                            <!-- Recent projects -->
                            <div class="admin-table-wrap">
                                <div class="admin-table-wrap__header">
                                    <h3>Recent Projects</h3>
                                    <a href="${pageContext.request.contextPath}/admin/projects"
                                        class="btn btn-sm btn-outline">Manage All</a>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Title</th>
                                            <th>Tech Stack</th>
                                            <th>Featured</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${projects}" end="4">
                                            <tr>
                                                <td>
                                                    <c:out value="${p.title}" />
                                                </td>
                                                <td>
                                                    <c:out value="${p.techStack}" />
                                                </td>
                                                <td>${p.featured ? '⭐ Yes' : 'No'}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Messages -->
                            <div class="admin-table-wrap" id="messages">
                                <div class="admin-table-wrap__header">
                                    <h3>Contact Messages</h3>
                                </div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Message</th>
                                            <th>Received</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty messages}">
                                                <c:forEach var="msg" items="${messages}">
                                                    <tr>
                                                        <td>
                                                            <c:out value="${msg.name}" />
                                                        </td>
                                                        <td>
                                                            <c:out value="${msg.email}" />
                                                        </td>
                                                        <td style="max-width:280px;white-space:nowrap;
                                 overflow:hidden;text-overflow:ellipsis">
                                                            <c:out value="${msg.message}" />
                                                        </td>
                                                        <td>${msg.sentAt}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${msg.read}">
                                                                    <span class="badge-read">Read</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge-unread">New</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" style="text-align:center;
                                           padding:24px;color:var(--text-light)">
                                                        No messages yet.
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