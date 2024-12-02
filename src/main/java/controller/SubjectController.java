package controller;

import dao.SubjectDAO;
import model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/subject", "/add-subject", "/edit-subject", "/delete-subject", "/check-mamh"})
public class SubjectController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SubjectDAO subjectDAO = new SubjectDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/subject":
                listSubjects(request, response);
                break;
            case "/add-subject":
                showAddForm(request, response);
                break;
            case "/edit-subject":
                showEditForm(request, response);
                break;
            case "/delete-subject":
                deleteSubject(request, response);
                break;
            case "/check-mamh":
                checkMamh(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-subject":
                addSubject(request, response);
                break;
            case "/edit-subject":
                updateSubject(request, response);
                break;
            default:
                break;
        }
    }

    private void listSubjects(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Subject> subjectList = subjectDAO.getAllSubjects();

        if (subjectList == null || subjectList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu môn học.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("subjectList", subjectList);
        request.getRequestDispatcher("/views/admin/monhoc.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/monhoc/add-subject.jsp").forward(request, response);
    }

    private void addSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mamh = request.getParameter("mamh");
        String tenmonhoc = request.getParameter("tenmonhoc");
        int sotiet = Integer.parseInt(request.getParameter("sotiet"));
        String hinhthucthi = request.getParameter("hinhthucthi");

        Subject subject = new Subject(mamh, tenmonhoc, sotiet, hinhthucthi);

        subjectDAO.addSubject(subject);
        response.sendRedirect(request.getContextPath() + "/views/admin/monhoc.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mamh = request.getParameter("mamh");
        Subject subject = subjectDAO.getSubjectByMamh(mamh);
        request.setAttribute("subject", subject);
        request.getRequestDispatcher("/views/admin/edit-subject.jsp").forward(request, response);
    }

    private void updateSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mamh = request.getParameter("mamh");
        String tenmonhoc = request.getParameter("tenmonhoc");
        int sotiet = Integer.parseInt(request.getParameter("sotiet"));
        String hinhthucthi = request.getParameter("hinhthucthi");

        Subject subject = new Subject(mamh, tenmonhoc, sotiet, hinhthucthi);

        boolean success = subjectDAO.updateSubject(subject);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/views/admin/monhoc.jsp");
        } else {
            request.setAttribute("errorMessage", "Cập nhật môn học thất bại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void checkMamh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String mamh = request.getParameter("mamh");

        boolean exists = subjectDAO.getSubjectByMamh(mamh) != null;

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write("exists");
        } else {
            response.getWriter().write("not-exists");
        }
    }

    private void deleteSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String mamh = request.getParameter("id");
        subjectDAO.deleteSubject(mamh);
        response.sendRedirect(request.getContextPath() + "/views/admin/monhoc.jsp");
    }
}