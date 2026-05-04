<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Add Project – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Add Project</h1>
                            <p>Fill in the details for your new project.</p>
                        </div>

                        <div class="admin-form-wrap">
                            <form action="${pageContext.request.contextPath}/admin/projects?action=add" method="post"
                                class="admin-form">

                                <div class="form-group">
                                    <label for="title">Title *</label>
                                    <input type="text" id="title" name="title" placeholder="Project title" required />
                                </div>

                                <div class="form-group">
                                    <label for="description">Description *</label>
                                    <textarea id="description" name="description" rows="4"
                                        placeholder="Describe what this project does…" required></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="techStack">Tech Stack *</label>
                                    <input type="text" id="techStack" name="techStack"
                                        placeholder="React, Node.js, TypeScript (comma-separated)" required />
                                </div>

                                <div class="form-group">
                                    <label for="githubUrl">GitHub URL</label>
                                    <input type="url" id="githubUrl" name="githubUrl"
                                        placeholder="https://github.com/…" />
                                </div>

                                <div class="form-group">
                                    <label for="liveUrl">Live URL</label>
                                    <input type="url" id="liveUrl" name="liveUrl" placeholder="https://…" />
                                </div>

                                <div class="form-group">
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="featured" name="featured" />
                                        <label for="featured">Mark as Featured Project</label>
                                    </div>
                                </div>

                                <div class="admin-form__actions">
                                    <button type="submit" class="btn btn-primary">Add Project</button>
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