package controller;

import dao.StudentDAO;
import model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/student", "/add-student", "/edit-student", "/delete-student", "/check-mahs"})
public class StudentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/student":
                listStudents(request, response);
                break;
            case "/add-student":
                showAddForm(request, response);
                break;
            case "/edit-student":
                showEditForm(request, response);
                break;
            case "/delete-student":
                deleteStudent(request, response);
                break;
            case "/check-mahs":
                checkMahs(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-student":
                addStudent(request, response);
                break;
            case "/edit-student":
                updateStudent(request, response);
                break;
            default:
                break;
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> studentList = studentDAO.getAllStudents();

        if (studentList == null || studentList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu sinh viên.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("/views/admin/hocsinh.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/hocsinh/add-student.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mahs = request.getParameter("mahs");
        String hovaten = request.getParameter("hovaten");
        String ngaysinh = request.getParameter("ngaysinh");
        String malop = request.getParameter("malop");
        String diachi = request.getParameter("diachi");
        String sdt = request.getParameter("sdt");
        String gvcn = request.getParameter("gvcn");

//        if (!isValidStudent(mahs, hovaten, ngaysinh, sdt)) {
//            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
//            request.getRequestDispatcher("/views/admin/add-student.jsp").forward(request, response);
//            return;
//        }

        Student student = new Student(mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn);

        studentDAO.addStudent(student);
        response.sendRedirect(request.getContextPath() + "/views/admin/hocsinh.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mahs = request.getParameter("mahs");
        Student student = studentDAO.getStudentByMahs(mahs);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/views/admin/edit-student.jsp").forward(request, response);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mahs = request.getParameter("mahs");
        String hovaten = request.getParameter("hovaten");
        String ngaysinh = request.getParameter("ngaysinh");
        String diachi = request.getParameter("diachi");
        String sdt = request.getParameter("sdt");
        String malop = request.getParameter("malop");
        String gvcn = request.getParameter("gvcn");

        if (!isValidStudent(mahs, hovaten, ngaysinh, sdt)) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/views/admin/edit-student.jsp").forward(request, response);
            return;
        }

        Student student = new Student(mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn);

        boolean success = studentDAO.updateStudent(student);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/views/admin/hocsinh.jsp");
        } else {
            request.setAttribute("errorMessage", "Cập nhật sinh viên thất bại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void checkMahs(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String mahs = request.getParameter("mahs");

        boolean exists = studentDAO.getStudentByMahs(mahs) != null;

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("not-exists");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String mahs = request.getParameter("id");
        studentDAO.deleteStudent(mahs);
        response.sendRedirect(request.getContextPath() + "/views/admin/hocsinh.jsp");
    }

    private boolean isValidStudent(String mahs, String hovaten, String ngaysinh, String sdt) {
        if (mahs == null || mahs.isEmpty()) return false;
        if (!hovaten.matches("^[a-zA-ZÀ-Ỹà-ỹ\\s]+$")) return false;
        if (!ngaysinh.matches("^\\d{4}-\\d{2}-\\d{2}$")) return false;
        if (!sdt.matches("^\\d{10,13}$")) return false;
        return true;
    }
}
