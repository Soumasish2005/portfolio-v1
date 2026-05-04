<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="../pages/includes/head.jsp" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css" />
            <title>Register – Admin</title>
        </head>

        <body>
            <div class="auth-page">
                <div class="auth-card">

                    <div class="auth-card__logo">
                        <a href="${pageContext.request.contextPath}/">SD</a>
                    </div>

                    <h2>Create Account</h2>
                    <p class="auth-sub">Register to manage your portfolio.</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" class="admin-form">

                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" placeholder="choose a username" required />
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" placeholder="your@email.com" required />
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="min 8 characters"
                                required />
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                placeholder="repeat password" required />
                        </div>

                        <div class="admin-form__actions">
                            <button type="submit" class="btn btn-primary" style="width:100%">
                                Create Account
                            </button>
                        </div>

                    </form>

                    <p class="auth-link">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    </p>

                </div>
            </div>

            <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        </body>

        </html>