<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Login – Admin</title>
        </head>

        <body>
            <div class="auth-page">
                <div class="auth-card">

                    <div class="auth-card__logo">
                        <a href="${pageContext.request.contextPath}/">SD</a>
                    </div>

                    <h2>Welcome back</h2>
                    <p class="auth-sub">Sign in to access the dashboard.</p>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">
                            <c:out value="${success}" />
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post" class="admin-form">

                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" placeholder="your username" required
                                autofocus />
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="••••••••" required />
                        </div>

                        <div class="admin-form__actions">
                            <button type="submit" class="btn btn-primary" style="width:100%">
                                Sign In
                            </button>
                        </div>

                    </form>

                    <p class="auth-link">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/register">Register</a>
                    </p>

                </div>
            </div>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>