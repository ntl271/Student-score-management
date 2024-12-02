package controller;

import dao.TeacherDAO;
import model.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/teacher", "/add-teacher", "/edit-teacher", "/delete-teacher", "/search-teacher", "/check-magv"})
public class TeacherController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO = new TeacherDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/teacher":
                listTeachers(request, response);
                break;
            case "/add-teacher":
                showAddForm(request, response);
                break;
            case "/edit-teacher":
                showEditForm(request, response);
                break;
            case "/delete-teacher":
                deleteTeacher(request, response);
                break;
            case "/check-magv":
                checkMagv(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-teacher":
                addTeacher(request, response);
                break;
            case "/edit-teacher":
                updateTeacher(request, response);
                break;
            default:
                break;
        }
    }

    private void listTeachers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Teacher> teacherList = teacherDAO.getAllTeachers();

        if (teacherList == null || teacherList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu giáo viên.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("teacherList", teacherList);
        request.getRequestDispatcher("/views/admin/giaovien.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/giaovien/add-teacher.jsp").forward(request, response);
    }

    private void addTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String magv = request.getParameter("magv");
        String hoten = request.getParameter("hoten");
        String ngaysinh = request.getParameter("ngaysinh");
        String monday = request.getParameter("monday");
        String email = request.getParameter("email");
        String sdt = request.getParameter("sdt");

        if (!isValidTeacher(magv, hoten, ngaysinh, sdt)) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/views/admin/giaovien/add-teacher.jsp").forward(request, response);
            return;
        }

        Teacher teacher = new Teacher(magv, hoten, ngaysinh, monday, email, sdt);

        teacherDAO.addTeacher(teacher);
        response.sendRedirect(request.getContextPath() + "/views/admin/giaovien.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String magv = request.getParameter("magv");
        Teacher teacher = teacherDAO.getTeacherByMagv(magv);
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("/views/admin/edit-teacher.jsp").forward(request, response);
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String magv = request.getParameter("magv");
        String hoten = request.getParameter("hoten");
        String ngaysinh = request.getParameter("ngaysinh");
        String monday = request.getParameter("monday");
        String email = request.getParameter("email");
        String sdt = request.getParameter("sdt");

        if (!isValidTeacher(magv, hoten, ngaysinh, sdt)) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/views/admin/edit-teacher.jsp").forward(request, response);
            return;
        }

        Teacher teacher = new Teacher(magv, hoten, ngaysinh, monday, email, sdt);

        boolean success = teacherDAO.updateTeacher(teacher);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/views/admin/giaovien.jsp");
        } else {
            request.setAttribute("errorMessage", "Cập nhật giáo viên thất bại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private boolean isValidTeacher(String magv, String hoten, String ngaysinh, String sdt) {
        if (magv == null || magv.isEmpty()) return false;
        if (!hoten.matches("^[a-zA-ZÀ-Ỹà-ỹ\\s]+$")) return false;
        if (!ngaysinh.matches("^\\d{4}-\\d{2}-\\d{2}$")) return false;
        if (!sdt.matches("^\\d{10,13}$")) return false;
        return true;
    }

    private void checkMagv(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String magv = request.getParameter("magv");

        boolean exists = teacherDAO.getTeacherByMagv(magv) != null;

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("not-exists");
        }
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String magv = request.getParameter("magv");
        teacherDAO.deleteTeacher(magv);
        response.sendRedirect(request.getContextPath() + "/views/admin/giaovien.jsp");
    }
}
