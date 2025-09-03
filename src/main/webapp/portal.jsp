<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.*, java.sql.*" %>
<%
    String portalName = request.getParameter("portal");
    if (portalName == null || portalName.isEmpty()) {
        portalName = "Unknown";
    }

    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        fullname = "Guest";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= portalName %> - SynFlow</title>
    <link rel="stylesheet" href="portal.css">
</head>
<body>

<div class="top-bar">
    <form action="dashboard.jsp" method="get">
        <button class="home-btn">HOME</button>
    </form>

    <div class="portal-name"><%= portalName %></div>
    <div class="username"><%= fullname %></div>
</div>

<div class="main-container">
    <div class="sidebar">
        <h3>PORTALS</h3>
        <ul>
            <%
                String[] portals = {"Announcements", "SOC", "SOE", "SVS", "SBSR", "ISBJ", "MITCOM", "IOD", "SOA", "SOFA", "SOFT", "SHD"};
                for (String portal : portals) {
            %>
            <li><a href="portal.jsp?portal=<%= portal %>"><%= portal %></a></li>
            <% } %>
        </ul>
    </div>

    <div class="chat-section">
        <div class="chat-box" id="chatMessages">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    String dbUrl = "jdbc:mysql://localhost:3306/synflow";
                    String dbUsername = "root";
                    String dbPassword = "root";

                    conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    stmt = conn.createStatement();
                    String query = "SELECT username, message, timestamp FROM messages WHERE portal = '" + portalName + "' ORDER BY timestamp DESC";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String username = rs.getString("username");
                        String message = rs.getString("message");
                        String timestamp = rs.getString("timestamp");

                        out.println("<div class='chat-message'>");
                        out.println("<div class='message-bubble'>");
                        out.println("<div class='sender-name'>" + username + "</div>");
                        out.println("<div class='message-text'>" + message + "</div>");
                        out.println("<div class='timestamp'>" + timestamp + "</div>");
                        out.println("</div>");
                        out.println("</div>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='error-message'>Error loading messages.</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <form class="chat-form" action="SendMessageServlet" method="post">
            <input type="hidden" name="portal" value="<%= portalName %>">
            <input type="text" name="message" placeholder="Type a message" required />
            <button type="submit">Send</button>
        </form>
    </div>
</div>

</body>
</html>
