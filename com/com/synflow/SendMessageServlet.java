package com.synflow;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class SendMessageServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String portal = request.getParameter("portal");
        String message = request.getParameter("message");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("fullname");
      

        if (username == null || message == null || message.trim().isEmpty()) {
            response.sendRedirect("portal.jsp?portal=" + portal);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO messages (portal, username, message,timestamp) VALUES (?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, portal);
            pstmt.setString(2, username);
            pstmt.setString(3, message);
         

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("portal.jsp?portal=" + portal);
    }
}
