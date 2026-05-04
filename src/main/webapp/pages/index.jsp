<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>Soumasish Dasgupta – Full-Stack Developer</title>
        </head>

        <body>

            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <section class="home-section">
                    <div class="container">
                        <div class="home__inner">

                            <!-- Avatar -->
                            <div class="home__image-wrap">
                                <img src="${pageContext.request.contextPath}/assets/images/profile.png"
                                    alt="Soumasish Dasgupta" class="home__avatar" onerror="this.style.display='none';
                          this.nextElementSibling.style.display='flex'" />
                                <div class="home__avatar-placeholder" style="display:none">🧑‍💻</div>

                                <!-- Badge -->
                                <div class="home__badge">
                                    <svg viewBox="0 0 120 120" width="120" height="120">
                                        <defs>
                                            <path id="circle"
                                                d="M 60,60 m -38,0 a 38,38 0 1,1 76,0 a 38,38 0 1,1 -76,0" />
                                        </defs>
                                        <text fill="currentColor" font-size="11.5" font-family="DM Sans, sans-serif"
                                            font-weight="600">
                                            <textPath href="#circle">
                                                Web Developer • UI/UX Designer • AI Builder •
                                            </textPath>
                                        </text>
                                    </svg>
                                    <a href="https://mail.google.com/mail/?view=cm&fs=1&to=soumasishdasgupta@gmail.com&su=Portfolio%20Inquiry:%20Hire%20Me"
                                        target="_blank" class="home__badge-center">
                                        <span>Hire</span>
                                        <span>Me!</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Content -->
                            <div class="home__content">
                                <c:choose>
                                    <c:when test="${not empty about}">
                                        <h1>
                                            <c:out value="${about.tagline}" />
                                        </h1>
                                        <p class="subtitle">
                                            <c:out value="${about.bioPreview}" />
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <h1>Turning Vision Into Reality With Code And Design.</h1>
                                        <p class="subtitle">Full-Stack Developer &amp; AI Enthusiast.
                                            B.Tech CSE student at Techno India University, building
                                            intelligent web applications with React, Node.js &amp; TypeScript.</p>
                                    </c:otherwise>
                                </c:choose>

                                <div class="home__cta">
                                    <a href="${pageContext.request.contextPath}/assets/files/resume.pdf"
                                        class="btn btn-primary" target="_blank">
                                        Resume
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none"
                                            stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0
                           002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                        </svg>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/contact"
                                        class="btn btn-outline">Contact</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </section>
            </main>

            <footer class="footer">
                <div class="container">
                    <p>
                        <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %>
                            &copy; Soumasish Dasgupta. Built with Java &amp; JSP.
                    </p>
                </div>
            </footer>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>