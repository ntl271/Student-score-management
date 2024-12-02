package controller;

import dao.ClassDAO;
import model.Class;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/class", "/add-class", "/edit-class", "/delete-class", "/search-class", "/check-malop"})
public class ClassController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassDAO classDAO = new ClassDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/class":
                listClasses(request, response);
                break;
            case "/add-class":
                showAddForm(request, response);
                break;
            case "/edit-class":
                showEditForm(request, response);
                break;
            case "/delete-class":
                deleteClass(request, response);
                break;
            case "/check-malop":
                checkMalop(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/add-class":
                addClass(request, response);
                break;
            case "/edit-class":
                updateClass(request, response);
                break;
            default:
                break;
        }
    }

    private void listClasses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Class> classList = classDAO.getAllClasses();

        if (classList == null || classList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu lớp học.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("classList", classList);
        request.getRequestDispatcher("/views/admin/lop.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/lop/add-class.jsp").forward(request, response);
    }

    private void addClass(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String malop = request.getParameter("malop");
        String tenlop = request.getParameter("tenlop");
        String magv = request.getParameter("magv");
        int siso = Integer.parseInt(request.getParameter("siso"));


        // Tạo đối tượng lớp học
        Class lop = new Class(malop, tenlop, magv, siso);

        // Thêm lớp học vào cơ sở dữ liệu
        classDAO.addClass(lop);
        response.sendRedirect(request.getContextPath() + "/views/admin/lop.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String malop = request.getParameter("malop");
        Class lop = classDAO.getClassByMalop(malop);
        request.setAttribute("class", lop);
        request.getRequestDispatcher("/views/admin/edit-class.jsp").forward(request, response);
    }

    private void updateClass(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String malop = request.getParameter("malop");
        String tenlop = request.getParameter("tenlop");
        String magv = request.getParameter("magv");
        int siso = Integer.parseInt(request.getParameter("siso"));

        Class lop = new Class(malop, tenlop, magv, siso);

        boolean updateSuccess = classDAO.updateClass(lop);

        if (updateSuccess) {
            response.sendRedirect(request.getContextPath() + "/class");
        } else {
            request.setAttribute("errorMessage", "Cập nhật lớp học thất bại.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void checkMalop(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String malop = request.getParameter("malop");

        boolean exists = classDAO.getClassByMalop(malop) != null;

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("not-exists");
        }
    }

    private boolean isValidClass(String malop, String tenlop, String siso) {
        if (malop == null || malop.isEmpty()) return false;
        if (!tenlop.matches("^[a-zA-ZÀ-Ỹà-ỹ\\s]+$")) return false;
        if (!siso.matches("^[1-9][0-9]?$|^100$")) return false;
        return true;
    }

    private void deleteClass(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Lấy mã lớp từ request
        String malop = request.getParameter("id");

        // Xóa lớp học khỏi cơ sở dữ liệu
        classDAO.deleteClass(malop);
        response.sendRedirect(request.getContextPath() + "/views/admin/lop.jsp");
    }
}
