<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.Teacher" %>
<%@ page import="dao.TeacherDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Initialize error messages list
    List<String> errors = new ArrayList<>();

    // Get the id parameter from the request
    String magv = request.getParameter("id");

    // Validate if id parameter is null or empty
    if (magv == null || magv.isEmpty()) {
        errors.add("Mã giáo viên không được để trống.");
    }

    // Get parameters from the request
    String hovaten = request.getParameter("hoten");
    String ngaysinh = request.getParameter("ngaysinh");
    String monday = request.getParameter("monday");
    String diachi = request.getParameter("diachi");
    String sdt = request.getParameter("sdt");
    String email = request.getParameter("email");

    // Create a new Teacher object
    TeacherDAO teacherDAO = new TeacherDAO();
    Teacher teacher = null;

    // Check for errors and retrieve teacher information if no errors
    if (errors.isEmpty()) {
        teacher = teacherDAO.getTeacherByMagv(magv);

        // Check if teacher exists
        if (teacher == null) {
            errors.add("Không tìm thấy giáo viên với mã số này.");
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Validate input fields
            if (hovaten == null || !hovaten.matches("^[a-zA-ZÀ-Ỹà-ỹ ]+$")) {
                errors.add("Lỗi: Họ tên chỉ được chứa chữ cái và dấu cách!");
            }
            if (ngaysinh == null || !ngaysinh.matches("^(0[1-9]|[12][0-9]|3[01])\\/(0[1-9]|1[0-2])\\/(19|20)\\d{2}$")) {
                errors.add("Lỗi: Ngày sinh không đúng định dạng (DD/MM/YYYY)!");
            }
            if (sdt == null || !sdt.matches("^[0-9]{10,13}$")) {
                errors.add("Lỗi: Số điện thoại phải có từ 10 đến 13 chữ số!");
            }

            // Proceed if no validation errors
            if (errors.isEmpty()) {
                // Set updated values to Teacher object
                teacher.setHoten(hovaten);
                teacher.setNgaysinh(ngaysinh);
                teacher.setMonday(monday);
                teacher.setEmail(email);
                teacher.setSdt(sdt);

                // Update teacher information in the database
                boolean updateSuccess = teacherDAO.updateTeacher(teacher);

                if (updateSuccess) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/giaovien.jsp");
                    return;
                } else {
                    errors.add("Lỗi: Không thể cập nhật thông tin giáo viên.");
                }
            }
        }
    }
%>

<%@ include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
    <h2 style="margin-top: 20px">Sửa thông tin giáo viên</h2>
    <% if (!errors.isEmpty()) { %>
    <div class="alert alert-danger">
        <% for (String error : errors) { %>
        <p><%= error %></p>
        <% } %>
    </div>
    <% } %>
    <form id="editTeacherForm" action="/edit-teacher?id=<%= magv %>" method="post">
    <div class="form-group">
            <label for="editMagv">Mã giáo viên</label>
            <input type="text" class="form-control" name="magv" id="editMagv" value="<%= teacher != null ? teacher.getMagv() : "" %>" readonly required>
        </div>
        <div class="form-group">
            <label for="editHoten">Tên giáo viên</label>
            <input type="text" class="form-control" name="hoten" id="editHoten" value="<%= teacher != null ? teacher.getHoten() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editNgaysinh">Ngày sinh</label>
            <input type="text" class="form-control" name="ngaysinh" id="editNgaysinh" value="<%= teacher != null ? teacher.getNgaysinh() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editMonday">Môn dạy</label>
            <input type="text" class="form-control" name="monday" id="editMonday" value="<%= teacher != null ? teacher.getMonday() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editEmail">Email</label>
            <input type="email" class="form-control" name="email" id="editEmail" value="<%= teacher != null ? teacher.getEmail() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editSdt">Số điện thoại</label>
            <input type="text" class="form-control" name="sdt" id="editSdt" value="<%= teacher != null ? teacher.getSdt() : "" %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
    </form>
</div>

<%@ include file="/templates/admin/inc/footer.jsp" %>
