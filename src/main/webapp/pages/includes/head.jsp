<%@ page contentType="text/html;charset=UTF-8" %>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <!-- Theme applied before paint to avoid flash -->
    <script>
        (function () {
            var t = localStorage.getItem('portfolio-theme') ||
                (window.matchMedia('(prefers-color-scheme:dark)').matches ? 'dark' : 'light');
            document.documentElement.setAttribute('data-theme', t);
        })();
    </script>