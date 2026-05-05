<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="../../pages/includes/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
    <title>Add Education – Admin</title>
</head>

<body>
    <jsp:include page="../../pages/includes/nav.jsp" />

    <div class="page-content">
        <div class="admin-layout">
            <jsp:include page="../includes/sidebar.jsp" />

            <main class="admin-main">
                <div class="admin-main__header">
                    <h1>Add Education</h1>
                    <p>Fill in the details for your new education entry.</p>
                </div>

                <div class="admin-form-wrap">
                    <form action="${pageContext.request.contextPath}/admin/education?action=add" method="post"
                        class="admin-form">

                        <div class="form-group">
                            <label for="institution">Institution *</label>
                            <input type="text" id="institution" name="institution" placeholder="University Name" required />
                        </div>

                        <div class="form-group">
                            <label for="degree">Degree *</label>
                            <input type="text" id="degree" name="degree" placeholder="B.Sc., M.Sc., etc." required />
                        </div>

                        <div class="form-group">
                            <label for="field">Field of Study</label>
                            <input type="text" id="field" name="field" placeholder="Computer Science" />
                        </div>

                        <div style="display:flex; gap:1rem;">
                            <div class="form-group" style="flex:1;">
                                <label for="startYear">Start Year *</label>
                                <input type="number" id="startYear" name="startYear" min="1900" max="2100" placeholder="YYYY" required />
                            </div>
                            <div class="form-group" style="flex:1;">
                                <label for="endYear">End Year</label>
                                <input type="number" id="endYear" name="endYear" min="1900" max="2100" placeholder="YYYY (Leave empty if present)" />
                            </div>
                        </div>

                        <div style="display:flex; gap:1rem;">
                            <div class="form-group" style="flex:1;">
                                <label for="gpa">GPA</label>
                                <input type="number" step="0.01" id="gpa" name="gpa" placeholder="4.0" />
                            </div>
                            <div class="form-group" style="flex:1;">
                                <label for="percentage">Percentage (%)</label>
                                <input type="number" step="0.01" id="percentage" name="percentage" placeholder="95.5" />
                            </div>
                        </div>

                        <div class="admin-form__actions">
                            <button type="submit" class="btn btn-primary">Add Education</button>
                            <a href="${pageContext.request.contextPath}/admin/education" class="btn btn-outline">Cancel</a>
                        </div>

                    </form>
                </div>

            </main>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>

</html>
