<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>About – Soumasish Dasgupta</title>
        </head>

        <body>
            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <div class="container section">

                    <div class="page-hero">
                        <h1>Passion Fuels Purpose!</h1>
                    </div>

                    <div class="about__inner">

                        <!-- Biography -->
                        <div class="about__bio">
                            <h3>Biography</h3>
                            <c:choose>
                                <c:when test="${not empty about}">
                                    <c:forEach var="para" items="${about.bioParagraphs}">
                                        <p>
                                            <c:out value="${para}" />
                                        </p>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>Hi, I'm <strong>Soumasish Dasgupta</strong>, a Full-Stack Developer
                                        and AI Enthusiast with a passion for creating beautiful, functional,
                                        and intelligent web applications.</p>
                                    <p>I am a B.Tech Computer Science student at Techno India University,
                                        Kolkata, with hands-on experience in React, Node.js, TypeScript,
                                        and GraphQL.</p>
                                    <p>I believe great software is built at the intersection of clean
                                        engineering and thoughtful design.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Photo -->
                        <div class="about__image-wrap">
                            <img src="${pageContext.request.contextPath}/assets/images/profile.jpg"
                                alt="Soumasish Dasgupta" class="about__photo" onerror="this.style.display='none';
                        this.nextElementSibling.style.display='flex'" />
                            <div class="about__photo-placeholder" style="display:none">🧑‍💻</div>
                        </div>

                        <!-- Stats -->
                        <div class="about__stats">
                            <c:choose>
                                <c:when test="${not empty about}">
                                    <div>
                                        <div class="about__stat-number">${about.clients}+</div>
                                        <div class="about__stat-label">Satisfied Clients</div>
                                    </div>
                                    <div>
                                        <div class="about__stat-number">${about.projectsCount}+</div>
                                        <div class="about__stat-label">Projects Completed</div>
                                    </div>
                                    <div>
                                        <div class="about__stat-number">${about.yearsExp}+</div>
                                        <div class="about__stat-label">Years of Experience</div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div>
                                        <div class="about__stat-number">5+</div>
                                        <div class="about__stat-label">Projects Completed</div>
                                    </div>
                                    <div>
                                        <div class="about__stat-number">2+</div>
                                        <div class="about__stat-label">Years of Experience</div>
                                    </div>
                                    <div>
                                        <div class="about__stat-number">9.8</div>
                                        <div class="about__stat-label">GPA</div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>
            </main>

            <footer class="footer">
                <div class="container">
                    <p>
                        <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %>
                            &copy; Soumasish Dasgupta.
                    </p>
                </div>
            </footer>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>