<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <aside class="admin-sidebar">
            <div class="admin-sidebar__title">Dashboard</div>
            <nav class="admin-sidebar__nav">

                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5
                 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6z
                 M13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25
                 A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6z
                 M3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25
                 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25z
                 M13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25
                 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
                    </svg>
                    Overview
                </a>

                <a href="${pageContext.request.contextPath}/admin/projects">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 6.75L22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25
                 m7.5-3l-4.5 16.5" />
                    </svg>
                    Projects
                </a>

                <a href="${pageContext.request.contextPath}/admin/skills">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z" />
                    </svg>
                    Skills
                </a>

                <a href="${pageContext.request.contextPath}/admin/dashboard#messages">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15
                 a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25
                 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5
                 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25
                 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0
                 01-1.07-1.916V6.75" />
                    </svg>
                    Messages
                    <c:if test="${unreadCount > 0}">
                        <span class="sidebar-badge">${unreadCount}</span>
                    </c:if>
                </a>

                <a href="${pageContext.request.contextPath}/" target="_blank">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0
                 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21
                 3m0 0h-5.25M21 3v5.25" />
                    </svg>
                    View Portfolio
                </a>

                <a href="${pageContext.request.contextPath}/logout">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0
                 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25
                 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75" />
                    </svg>
                    Logout
                </a>

            </nav>
        </aside>