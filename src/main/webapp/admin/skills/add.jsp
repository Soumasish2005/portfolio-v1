<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Add Skill – Admin</title>
        </head>

        <body>
            <jsp:include page="../../pages/includes/nav.jsp" />

            <div class="page-content">
                <div class="admin-layout">
                    <jsp:include page="../includes/sidebar.jsp" />

                    <main class="admin-main">
                        <div class="admin-main__header">
                            <h1>Add Skill</h1>
                        </div>

                        <div class="admin-form-wrap">
                            <form action="${pageContext.request.contextPath}/admin/skills?action=add" method="post"
                                class="admin-form">

                                <div class="form-group">
                                    <label for="name">Skill Name *</label>
                                    <input type="text" id="name" name="name" placeholder="e.g. React" required />
                                </div>

                                <div class="form-group">
                                    <label for="category">Category *</label>
                                    <select id="category" name="category" required>
                                        <option value="">Select category…</option>
                                        <option value="Languages">Languages</option>
                                        <option value="Frontend">Frontend</option>
                                        <option value="Backend">Backend</option>
                                        <option value="Databases">Databases</option>
                                        <option value="Cloud/DevOps">Cloud/DevOps</option>
                                        <option value="Tools">Tools</option>
                                        <option value="ML/AI">ML/AI</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="proficiencyLevel">
                                        Proficiency Level (1–100) *
                                    </label>
                                    <input type="number" id="proficiencyLevel" name="proficiencyLevel" min="1" max="100"
                                        placeholder="85" required />
                                </div>

                                <div class="admin-form__actions">
                                    <button type="submit" class="btn btn-primary">Add Skill</button>
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