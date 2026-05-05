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
                                enctype="multipart/form-data"
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

                                <div class="form-group" id="coverImageGroup" style="display:none;">
                                    <label for="coverImage">Cover Image</label>
                                    <p class="form-hint">Displayed on the Projects page for featured projects. Max 5 MB (JPG, PNG, WebP, GIF).</p>
                                    <div class="cover-upload-area" id="coverUploadArea">
                                        <input type="file" id="coverImage" name="coverImage"
                                            accept="image/jpeg,image/png,image/webp,image/gif,image/avif"
                                            class="cover-file-input" />
                                        <div class="cover-upload-placeholder" id="coverPlaceholder">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
                                            <span>Click or drag to upload a cover image</span>
                                        </div>
                                        <img id="coverPreview" class="cover-preview" src="" alt="Cover preview" style="display:none;" />
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
                            placeholder.style.display  = 'none';
                        };
                        reader.readAsDataURL(file);
                    });
                })();
            </script>
        </body>

        </html>