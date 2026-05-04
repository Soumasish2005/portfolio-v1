<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Edit Project – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Edit Project</h1>
                        </div>

                        <div class="admin-form-wrap">
                            <form action="${pageContext.request.contextPath}/admin/projects?action=update" method="post"
                                class="admin-form">

                                <input type="hidden" name="id" value="${project.id}" />

                                <div class="form-group">
                                    <label for="title">Title *</label>
                                    <input type="text" id="title" name="title" value="<c:out value='${project.title}'/>"
                                        required />
                                </div>

                                <div class="form-group">
                                    <label for="description">Description *</label>
                                    <textarea id="description" name="description" rows="4"
                                        required><c:out value="${project.description}"/></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="techStack">Tech Stack *</label>
                                    <input type="text" id="techStack" name="techStack"
                                        value="<c:out value='${project.techStack}'/>" required />
                                </div>

                                <div class="form-group">
                                    <label for="githubUrl">GitHub URL</label>
                                    <input type="url" id="githubUrl" name="githubUrl"
                                        value="<c:out value='${project.githubUrl}'/>" />
                                </div>

                                <div class="form-group">
                                    <label for="liveUrl">Live URL</label>
                                    <input type="url" id="liveUrl" name="liveUrl"
                                        value="<c:out value='${project.liveUrl}'/>" />
                                </div>

                                <div class="form-group">
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="featured" name="featured" ${project.featured
                                            ? 'checked' : '' } />
                                        <label for="featured">Mark as Featured Project</label>
                                    </div>
                                </div>

                                <div class="admin-form__actions">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                    <a href="${pageContext.request.contextPath}/admin/projects"
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