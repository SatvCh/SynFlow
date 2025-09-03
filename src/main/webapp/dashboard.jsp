<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.*, java.util.*" %>
<html>
<head>
    <title>SynFlow Dashboard</title>
    <link rel="stylesheet" type="text/css" href="dashboard.css">
</head>
<body>
    <div class="user-info">
        <%
         
            String fullname = (String) session.getAttribute("fullname");
            if (fullname != null) {
        %>
            <div class="dropdown">
                <span class="fullname" onclick="toggleLogoutMenu()"><%= fullname %> &#9662;</span>
                <div id="logoutMenu" class="logout-menu">
                    <a href="#" onclick="return confirmLogout();">Logout</a>
                    <form class="delete-form" action="DeleteAccountServlet" method="POST" onsubmit="return confirmDelete();">
                        <button type="submit">Delete Account</button>
                    </form>
                </div>
            </div>
        <%
            } else {
                out.println("User not logged in.");
            }
        %>
    </div>

    <div class="dashboard-container">
        <div class="top-section">
            <h1>Welcome to SynFlow Dashboard!</h1>
        </div>

        <div class="portals-section">
            <h2>Department Portals</h2>
            <div class="portal-buttons">
                <%
                    String[] portals = {"Announcements", "SOC", "SOE", "SVS", "SBSR", "ISBJ", "MITCOM", "IOD", "SOA", "SOFA", "SOFT", "SHD"};
                    for (String portal : portals) {
                %>
                <form action="portal.jsp" method="get">
                    <input type="hidden" name="portal" value="<%= portal %>">
                    <button type="submit"><%= portal %></button>
                </form>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 SynFlow. All rights reserved.</p>
    </footer>

    <script>
        function toggleLogoutMenu() {
            const logoutMenu = document.getElementById("logoutMenu");
            logoutMenu.style.display = logoutMenu.style.display === "block" ? "none" : "block";
        }

        function confirmLogout() {
            return confirm("Are you sure you want to logout?") && (window.location.href = "LogoutServlet");
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete your account? This action cannot be undone.");
        }

        document.addEventListener("click", function (e) {
            const dropdown = document.querySelector(".dropdown");
            const logoutMenu = document.getElementById("logoutMenu");
            if (logoutMenu && !dropdown.contains(e.target)) {
                logoutMenu.style.display = "none";
            }
        });
    </script>
</body>
</html>
