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
                                enctype="multipart/form-data"
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

                                <div class="form-group" id="coverImageGroup" style="display:none;">
                                    <label for="coverImage">Cover Image</label>
                                    <p class="form-hint">Leave empty to keep the existing image. Max 5 MB (JPG, PNG, WebP, GIF).</p>
                                    <div class="cover-upload-area" id="coverUploadArea">
                                        <input type="file" id="coverImage" name="coverImage"
                                            accept="image/jpeg,image/png,image/webp,image/gif,image/avif"
                                            class="cover-file-input" />
                                        <div class="cover-upload-placeholder" id="coverPlaceholder"
                                            <c:if test="${not empty project.coverImage}">style="display:none;"</c:if>>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
                                            <span>Click or drag to upload a new cover image</span>
                                        </div>
                                        <c:if test="${not empty project.coverImage}">
                                            <img id="coverPreview" class="cover-preview"
                                                src="${pageContext.request.contextPath}/${project.coverImage}"
                                                alt="Current cover" />
                                        </c:if>
                                        <c:if test="${empty project.coverImage}">
                                            <img id="coverPreview" class="cover-preview" src="" alt="Cover preview" style="display:none;" />
                                        </c:if>
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
            <script>
                (function () {
                    var featuredCb   = document.getElementById('featured');
                    var coverGroup   = document.getElementById('coverImageGroup');
                    var coverInput   = document.getElementById('coverImage');
                    var coverPreview = document.getElementById('coverPreview');
                    var placeholder  = document.getElementById('coverPlaceholder');

                    function toggleCover() {
                        coverGroup.style.display = featuredCb.checked ? '' : 'none';
                    }
                    featuredCb.addEventListener('change', toggleCover);
                    toggleCover();

                    coverInput.addEventListener('change', function () {
                        var file = this.files[0];
                        if (!file) return;
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            coverPreview.src = e.target.result;
                            coverPreview.style.display = 'block';
                            if (placeholder) placeholder.style.display = 'none';
                        };
                        reader.readAsDataURL(file);
                    });
                })();
            </script>
        </body>

        </html>