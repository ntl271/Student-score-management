package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import config.ConnectionDb;

@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConnectionDb.getConnection();
            ps = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("email", rs.getString("email"));
                response.sendRedirect(request.getContextPath() + "/views/admin/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            ConnectionDb.closeConnection();
        }
    }
}
