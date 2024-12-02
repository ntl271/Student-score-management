package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/user", "/add-user", "/edit-user", "/delete-user"})
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/user":
                listUsers(request, response);
                break;
            case "/add-user":
                showAddForm(request, response);
                break;
            case "/edit-user":
                showEditForm(request, response);
                break;
            case "/delete-user":
                deleteUser(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-user":
                addUser(request, response);
                break;
            case "/edit-user":
                updateUser(request, response);
                break;
            default:
                break;
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> userList = userDAO.getAllUsers();

        if (userList == null || userList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu người dùng.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/views/admin/users.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/users/add-user.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(id, email, password);
        System.out.println("Adding user: " + user);

        boolean success = userDAO.addUser(user);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/user");
        } else {
            System.err.println("Failed to add user.");
            request.setAttribute("errorMessage", "Thêm người dùng thất bại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }



    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/admin/edit-user.jsp").forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Tạo đối tượng User mới
        User user = new User(id, email, password);

        // Cập nhật người dùng trong cơ sở dữ liệu
        boolean success = userDAO.updateUser(user);

        if (success) {
            // Nếu cập nhật thành công, chuyển hướng đến trang hiển thị danh sách người dùng
            response.sendRedirect(request.getContextPath() + "/views/admin/users.jsp");
        } else {
            // Nếu cập nhật không thành công, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Cập nhật người dùng thất bại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Lấy ID người dùng từ request
        int id = Integer.parseInt(request.getParameter("id"));

        // Xóa người dùng khỏi cơ sở dữ liệu
        userDAO.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/views/admin/users.jsp");
    }
}
