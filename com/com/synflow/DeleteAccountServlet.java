package com.synflow;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class DeleteAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Override doPost() to handle POST requests only
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get the session and retrieve the user email
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        if (email != null) {
            // Connect to the database and execute the delete query
            try {
                Connection conn = DBUtil.getConnection();
                String deleteQuery = "DELETE FROM users WHERE email=?";
                PreparedStatement ps = conn.prepareStatement(deleteQuery);
                ps.setString(1, email);
                
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Successfully deleted the account, invalidate session and redirect to login
                    session.invalidate();  // Invalidate session to log out the user
                    response.sendRedirect("login.jsp");  // Redirect to login page after account deletion
                } else {
                    // Account deletion failed, forward to dashboard with an error message
                    request.setAttribute("errorMessage", "Error deleting account. Please try again.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
                    dispatcher.forward(request, response);
                }

                conn.close();
            } catch (SQLException e) {
                // Handle SQL errors
                e.printStackTrace();
                out.println("Error deleting account: " + e.getMessage());
            } catch (Exception e) {
                // Catch any other errors
                e.printStackTrace();
                out.println("Unexpected error: " + e.getMessage());
            }
        } else {
            // If no session or email, redirect to login
            response.sendRedirect("login.jsp");
        }
    }
}
