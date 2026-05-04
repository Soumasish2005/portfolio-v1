<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Edit Skill – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Edit Skill</h1>
                        </div>

                        <div class="admin-form-wrap">
                            <form action="${pageContext.request.contextPath}/admin/skills?action=update" method="post"
                                class="admin-form">

                                <input type="hidden" name="id" value="${skill.id}" />

                                <div class="form-group">
                                    <label for="name">Skill Name *</label>
                                    <input type="text" id="name" name="name" value="<c:out value='${skill.name}'/>"
                                        required />
                                </div>

                                <div class="form-group">
                                    <label for="category">Category *</label>
                                    <select id="category" name="category" required>
                                        <c:forEach var="cat" items="${['Languages','Frontend','Backend',
                                               'Databases','Cloud/DevOps',
                                               'Tools','ML/AI']}">
                                            <option value="${cat}" ${skill.category eq cat ? 'selected' : '' }>
                                                <c:out value="${cat}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="proficiencyLevel">Proficiency Level *</label>
                                    <input type="number" id="proficiencyLevel" name="proficiencyLevel" min="1" max="100"
                                        value="${skill.proficiencyLevel}" required />
                                </div>

                                <div class="admin-form__actions">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                    <a href="${pageContext.request.contextPath}/admin/skills"
                                        class="btn btn-outline">Cancel</a>
                                </div>

                            </form>
                        </div>

                    </main>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>