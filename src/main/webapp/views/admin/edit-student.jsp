<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Student" %>
<%@ page import="dao.StudentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Initialize error messages list
    List<String> errors = new ArrayList<>();

    // Get the id parameter from the request
    String mahs = request.getParameter("id");

    if (mahs == null || mahs.isEmpty()) {
        errors.add("Mã học sinh không được để trống.");
    }

    // Get parameters from the request
    String hovaten = request.getParameter("hovaten");
    String ngaysinh = request.getParameter("ngaysinh");
    String malop = request.getParameter("malop");
    String diachi = request.getParameter("diachi");
    String sdt = request.getParameter("sdt");
    String gvcn = request.getParameter("gvcn");

    StudentDAO studentDAO = new StudentDAO();
    Student student = null;

    if (errors.isEmpty()) {
        student = studentDAO.getStudentByMahs(mahs);

        if (student == null) {
            errors.add("Không tìm thấy học sinh với mã số này.");
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

            if (errors.isEmpty()) {
                // Create a new Student object
                student.setHovaten(hovaten);
                student.setNgaysinh(ngaysinh);
                student.setMalop(malop);
                student.setDiachi(diachi);
                student.setSdt(sdt);
                student.setGvcn(gvcn);

                // Update student information in the database
                boolean updateSuccess = studentDAO.updateStudent(student);

                if (updateSuccess) {
                    response.sendRedirect("/views/admin/hocsinh.jsp");
                    return;
                } else {
                    errors.add("Error: Could not update the student information.");
                }
            }
        }
    }
%>

<%@include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
    <h2 style="margin-top: 20px">Edit Student</h2>
    <% if (!errors.isEmpty()) { %>
    <div class="alert alert-danger">
        <% for (String error : errors) { %>
        <p><%= error %></p>
        <% } %>
    </div>
    <% } %>
    <form id="editStudentForm" action="/edit-student?id=<%= mahs %>" method="post">
        <div class="form-group">
            <label for="editMahs">Mã học sinh</label>
            <input type="text" class="form-control" name="mahs" id="editMahs" value="<%= student != null ? student.getMahs() : "" %>" readonly required>
        </div>
        <div class="form-group">
            <label for="editHovaten">Tên học sinh</label>
            <input type="text" class="form-control" name="hovaten" id="editHovaten" value="<%= student != null ? student.getHovaten() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editNgaysinh">Ngày sinh</label>
            <input type="text" class="form-control" name="ngaysinh" id="editNgaysinh" value="<%= student != null ? student.getNgaysinh() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editMalop">Lớp</label>
            <input type="text" class="form-control" name="malop" id="editMalop" value="<%= student != null ? student.getMalop() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editDiachi">Địa chỉ</label>
            <input type="text" class="form-control" name="diachi" id="editDiachi" value="<%= student != null ? student.getDiachi() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editSdt">Số điện thoại</label>
            <input type="text" class="form-control" name="sdt" id="editSdt" value="<%= student != null ? student.getSdt() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="editGvcn">GVCN</label>
            <input type="text" class="form-control" name="gvcn" id="editGvcn" value="<%= student != null ? student.getGvcn() : "" %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</div>

<%@include file="/templates/admin/inc/footer.jsp" %>
