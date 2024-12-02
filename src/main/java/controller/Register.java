package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import config.ConnectionDb;

@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password.equals(confirmPassword)) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = ConnectionDb.getConnection();
                ps = conn.prepareStatement("INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, password);

                int result = ps.executeUpdate();
                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=1");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=1");
            } finally {
                try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
                ConnectionDb.closeConnection();
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=2");
        }
    }
}
