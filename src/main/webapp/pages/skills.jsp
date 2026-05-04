<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>Skills – Soumasish Dasgupta</title>
        </head>

        <body>
            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <div class="container section">

                    <div class="page-hero">
                        <h1>What I Work With</h1>
                        <p>A curated snapshot of my technical stack and proficiency levels.</p>
                    </div>

                    <c:choose>
                        <c:when test="${not empty skillsByCategory}">
                            <c:forEach var="entry" items="${skillsByCategory}">
                                <div class="skills__category">
                                    <div class="skills__category-title">
                                        <c:out value="${entry.key}" />
                                    </div>
                                    <div class="skills__grid">
                                        <c:forEach var="skill" items="${entry.value}">
                                            <div class="skill-card">
                                                <div class="skill-card__name">
                                                    <c:out value="${skill.name}" />
                                                </div>
                                                <div class="skill-card__bar">
                                                    <div class="skill-card__fill"
                                                        data-width="${skill.proficiencyLevel}">
                                                    </div>
                                                </div>
                                                <div class="skill-card__pct">
                                                    ${skill.proficiencyLevel}%
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align:center;padding:40px 0">
                                No skills found. Add some from the admin dashboard.
                            </p>
                        </c:otherwise>
                    </c:choose>

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
                document.querySelectorAll('.skill-card__fill').forEach(function (el) {
                    el.style.width = el.getAttribute('data-width') + '%';
                });
            </script>
        </body>

        </html>