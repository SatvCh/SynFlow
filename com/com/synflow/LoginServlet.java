package com.synflow;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Get fullname from the database and store it in the session
                String fullname = rs.getString("fullname");  // Replace with actual column name for fullname
                HttpSession session = request.getSession();
                session.setAttribute("fullname", fullname);  // Store fullname in session
                session.setAttribute("userEmail", email);
                session.setAttribute("role", role);


                // ✅ Redirect to the dashboard
                response.sendRedirect("dashboard.jsp");

            } else {
                // ❌ Login failed, setting error message
                request.setAttribute("errorMessage", "Incorrect email or password");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Login error: " + e.getMessage());
        }
    }
}
