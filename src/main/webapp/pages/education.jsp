<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>Education – Soumasish Dasgupta</title>
        </head>

        <body>
            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <div class="container section">

                    <div class="page-hero">
                        <h1>Academic Background</h1>
                        <p>My educational journey and qualifications.</p>
                    </div>

                    <div class="education__list">
                        <c:choose>
                            <c:when test="${not empty educationList}">
                                <c:forEach var="edu" items="${educationList}">
                                    <div class="education-card">
                                        <div class="education-card__year">
                                            <c:out value="${edu.yearRange}" />
                                        </div>
                                        <div class="education-card__degree">
                                            <c:out value="${edu.degree}" />
                                        </div>
                                        <div class="education-card__field">
                                            <c:out value="${edu.field}" />
                                        </div>
                                        <div class="education-card__institution">
                                            🏫
                                            <c:out value="${edu.institution}" />
                                        </div>
                                        <c:if test="${not empty edu.gpa}">
                                            <span class="education-card__gpa">
                                                GPA:
                                                <c:out value="${edu.gpa}" />
                                            </span>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align:center;padding:40px 0">
                                    No education records found.
                                </p>
                            </c:otherwise>
                        </c:choose>
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
        </body>

        </html>