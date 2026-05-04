<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <jsp:include page="includes/head.jsp" />
            <title>Contact – Soumasish Dasgupta</title>
        </head>

        <body>
            <jsp:include page="includes/nav.jsp" />

            <main class="page-content">
                <div class="container section">

                    <div class="page-hero">
                        <h1>Let's Talk</h1>
                        <p>Got a project idea or opportunity? Drop a message.</p>
                    </div>

                    <div class="contact__inner">

                        <div class="contact__info">
                            <h3>Get In Touch</h3>
                            <p>I'm always open to new opportunities, collaborations, or just
                                a friendly conversation about tech and design.</p>
                            <div class="contact__detail">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.8" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15
                       a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25
                       0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5
                       0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25
                       2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
                                </svg>
                                dasguptasoumasish@gmail.com
                            </div>
                            <div class="contact__detail">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.8" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25
                       S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
                                </svg>
                                Kolkata, West Bengal, India
                            </div>
                        </div>

                        <div>
                            <c:if test="${param.sent eq 'true'}">
                                <div class="alert alert-success">
                                    ✓ Message sent! I'll get back to you soon.
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-error">
                                    <c:out value="${error}" />
                                </div>
                            </c:if>

                            <form id="contactForm" class="contact-form"
                                action="${pageContext.request.contextPath}/contact" method="post" novalidate>

                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" id="name" name="name" placeholder="Your full name" required />
                                    <span class="field-error"></span>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" placeholder="your@email.com" required />
                                    <span class="field-error"></span>
                                </div>

                                <div class="form-group">
                                    <label for="message">Message</label>
                                    <textarea id="message" name="message" rows="2"
                                        placeholder="Tell me about your project…" required></textarea>
                                    <span class="field-error"></span>
                                </div>

                                <button type="submit" class="btn btn-primary">Send Message</button>

                            </form>
                        </div>

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
            <script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
        </body>

        </html>