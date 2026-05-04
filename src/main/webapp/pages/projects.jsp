<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>Projects – Soumasish Dasgupta</title>
        </head>

        <body>
            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <div class="container section">

                    <div class="page-hero">
                        <h1>Imagination Trumps Knowledge!</h1>
                        <p>A selection of projects I've built — from systems programming to AI-powered apps.</p>
                    </div>

                    <!-- Search / filter (M2 interactive feature) -->
                    <div class="projects__search">
                        <input type="text" id="projectSearch" class="search-input"
                            placeholder="Search by title or technology…" aria-label="Search projects" />
                    </div>

                    <!-- Featured projects -->
                    <c:forEach var="project" items="${projects}">
                        <c:if test="${project.featured}">
                            <div class="projects__featured" data-title="${project.title}"
                                data-tech="${project.techStack}">
                                <div class="projects__featured-inner">
                                    <div class="projects__featured-img">🚀</div>
                                    <div class="projects__featured-content">
                                        <span class="featured-label">Featured Project</span>
                                        <h2>
                                            <c:out value="${project.title}" />
                                        </h2>
                                        <p>
                                            <c:out value="${project.description}" />
                                        </p>
                                        <div class="project-card__tags">
                                            <c:forEach var="tech" items="${project.techArray}">
                                                <span class="tag">
                                                    <c:out value="${tech}" />
                                                </span>
                                            </c:forEach>
                                        </div>
                                        <div class="project-links">
                                            <c:if test="${not empty project.githubUrl}">
                                                <a href="${project.githubUrl}" target="_blank"
                                                    class="btn btn-primary btn-sm">GitHub</a>
                                            </c:if>
                                            <c:if test="${not empty project.liveUrl}">
                                                <a href="${project.liveUrl}" target="_blank"
                                                    class="btn btn-outline btn-sm">Live Demo</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <!-- All projects grid -->
                    <div class="projects__grid" id="projectsGrid">
                        <c:forEach var="project" items="${projects}">
                            <div class="project-card" data-title="${project.title}" data-tech="${project.techStack}">
                                <div class="project-card__title">
                                    <c:out value="${project.title}" />
                                </div>
                                <p class="project-card__desc">
                                    <c:out value="${project.description}" />
                                </p>
                                <div class="project-card__tags">
                                    <c:forEach var="tech" items="${project.techArray}">
                                        <span class="tag">
                                            <c:out value="${tech}" />
                                        </span>
                                    </c:forEach>
                                </div>
                                <div class="project-card__links">
                                    <c:if test="${not empty project.githubUrl}">
                                        <a href="${project.githubUrl}" target="_blank">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                viewBox="0 0 24 24" fill="currentColor">
                                                <path d="M12 0C5.374 0 0 5.373 0 12c0 5.302 3.438 9.8
                    8.207 11.387.599.111.793-.261.793-.577v-2.234
                    c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756
                    -1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839
                    1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775
                    .418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931
                    0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176
                    0 0 1.008-.322 3.301 1.23A11.509 11.509 0 0112 5.803
                    c1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23
                    3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911
                    1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823
                    1.102.823 2.222v3.293c0 .319.192.694.801.576C20.566
                    21.797 24 17.3 24 12c0-6.627-5.373-12-12-12z" />
                                            </svg>
                                            GitHub
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty project.liveUrl}">
                                        <a href="${project.liveUrl}" target="_blank">↗ Live</a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </main>

            <footer class="footer">
                <div class="container">
                    <p>
                        <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> &copy; Soumasish Dasgupta.
                </div>
            </footer>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
            <script>
                // Live project search / filter (M2 interactive feature)
                document.getElementById('projectSearch').addEventListener('input', function () {
                    var q = this.value.toLowerCase();
                    document.querySelectorAll('#projectsGrid .project-card').forEach(function (card) {
                        var title = card.dataset.title.toLowerCase();
                        var tech = card.dataset.tech.toLowerCase();
                        card.style.display = (title.includes(q) || tech.includes(q)) ? '' : 'none';
                    });
                });
            </script>
        </body>

        </html>