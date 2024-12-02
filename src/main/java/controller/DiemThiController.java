package controller;

import dao.DiemThiDAO;
import model.DiemThi;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/show-diemthi", "/add-diemthi", "/edit-diemthi", "/delete-diemthi"})
public class DiemThiController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DiemThiDAO diemThiDAO = new DiemThiDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        switch (action) {
            case "/show-diemthi":
                listDiemThi(request, response);
                break;
            case "/add-diemthi":
                showAddForm(request, response);
                break;
            case "/edit-diemthi":
                showEditForm(request, response);
                break;
            case "/delete-diemthi":
                deleteDiemThi(request, response);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-diemthi":
                addDiemThi(request, response);
                break;
            case "/edit-diemthi":
                updateDiemThi(request, response);
                break;
            default:
                break;
        }
    }

    private void listDiemThi(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<DiemThi> diemThiList = diemThiDAO.getAllDiemThi();

        if (diemThiList == null || diemThiList.isEmpty()) {
            request.setAttribute("errorMessage", "Không có dữ liệu điểm thi.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("diemThiList", diemThiList);
        request.getRequestDispatcher("/views/admin/show-diemthi.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/add-diemthi.jsp").forward(request, response);
    }

    private void addDiemThi(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mahs = request.getParameter("mahs");
        String namhoc = request.getParameter("namhoc");
        String tenmonhoc = request.getParameter("tenmonhoc");
        double diem15pki1 = Double.parseDouble(request.getParameter("diem15pki1"));
        double diemgiuaki1 = Double.parseDouble(request.getParameter("diemgiuaki1"));
        double diemcuoiki1 = Double.parseDouble(request.getParameter("diemcuoiki1"));
        double diem15pki2 = Double.parseDouble(request.getParameter("diem15pki2"));
        double diemgiuaki2 = Double.parseDouble(request.getParameter("diemgiuaki2"));
        double diemcuoiki2 = Double.parseDouble(request.getParameter("diemcuoiki2"));

        // Tính điểm trung bình các kỳ
        double diemtbki1 = (diem15pki1 + (diemgiuaki1 * 2) + (diemcuoiki1 * 3)) / 6.0;
        double diemtbki2 = (diem15pki2 + (diemgiuaki2 * 2) + (diemcuoiki2 * 3)) / 6.0;
        double diemtbcanam = (diemtbki1 + diemtbki2) / 2.0;

        DiemThi diemThi = new DiemThi(mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2);
        diemThiDAO.addDiemThi(diemThi);


        response.sendRedirect(request.getContextPath() + "/show-diemthi?id=" + mahs);

    }


    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mahs = request.getParameter("mahs");
        DiemThi diemThi = diemThiDAO.getDiemThiByMahs(mahs);
        request.setAttribute("diemThi", diemThi);
        request.getRequestDispatcher("/views/admin/edit-diemthi.jsp").forward(request, response);
    }

    private void updateDiemThi(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String mahs = request.getParameter("mahs");
        String namhoc = request.getParameter("namhoc");
        String tenmonhoc = request.getParameter("tenmonhoc");
        double diem15pki1 = Double.parseDouble(request.getParameter("diem15pki1"));
        double diemgiuaki1 = Double.parseDouble(request.getParameter("diemgiuaki1"));
        double diemcuoiki1 = Double.parseDouble(request.getParameter("diemcuoiki1"));
        double diem15pki2 = Double.parseDouble(request.getParameter("diem15pki2"));
        double diemgiuaki2 = Double.parseDouble(request.getParameter("diemgiuaki2"));
        double diemcuoiki2 = Double.parseDouble(request.getParameter("diemcuoiki2"));

        // Tính điểm trung bình các kỳ và cả năm
        double diemtbki1 = (diem15pki1 + (diemgiuaki1 * 2) + (diemcuoiki1 * 3)) / 6.0;
        double diemtbki2 = (diem15pki2 + (diemgiuaki2 * 2) + (diemcuoiki2 * 3)) / 6.0;
        double diemtbcanam = (diemtbki1 + diemtbki2) / 2.0;

        DiemThi diemThi = new DiemThi(mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2);

        DiemThiDAO diemThiDAO = new DiemThiDAO();
        boolean success = diemThiDAO.updateDiemThi(diemThi);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/show-diemthi?id=" + mahs);
        } else {
            request.setAttribute("errorMessage", "Cập nhật điểm thi thất bại.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }


    private void deleteDiemThi(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String mahs = request.getParameter("mahs");
        diemThiDAO.deleteDiemThi(mahs);
        response.sendRedirect(request.getContextPath() + "/views/admin/diemthi.jsp");
    }
}
