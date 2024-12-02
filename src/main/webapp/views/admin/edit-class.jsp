<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.Class" %>
<%@ page import="dao.ClassDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    List<String> errors = new ArrayList<>();

    // Get the id parameter from the request
    String malop = request.getParameter("id");

    // Validate if id parameter is null or empty
    if (malop == null || malop.isEmpty()) {
        errors.add("Mã lớp không được để trống.");
    }

    // Create a new ClassDAO instance
    ClassDAO classDAO = new ClassDAO();
    Class lop = null;

    // Check for errors and retrieve class information if no errors
    if (errors.isEmpty()) {
        lop = classDAO.getClassByMalop(malop);

        // Check if class exists
        if (lop == null) {
            errors.add("Không tìm thấy lớp với mã số này.");
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get parameters from the request
            String tenlop = request.getParameter("tenlop");
            String magv = request.getParameter("magv");
            String sisoStr = request.getParameter("siso");

            // Validate input fields
            if (tenlop == null || tenlop.isEmpty() || !tenlop.matches("^[a-zA-Z0-9À-Ỹà-ỹ\\s]+$")) {
                errors.add("Lỗi: Tên lớp chỉ được chứa chữ cái, số và dấu cách!");
            }
            if (magv == null || magv.isEmpty()) {
                errors.add("Lỗi: Mã giáo viên không được để trống.");
            }
            if (sisoStr == null || sisoStr.isEmpty()) {
                errors.add("Lỗi: Sĩ số không được để trống.");
            } else {
                try {
                    int siso = Integer.parseInt(sisoStr);
                    if (siso <= 0 || siso > 100) {
                        errors.add("Lỗi: Sĩ số phải là số nguyên dương và không lớn hơn 100.");
                    }
                } catch (NumberFormatException e) {
                    errors.add("Lỗi: Sĩ số không hợp lệ.");
                }
            }

            // Proceed if no validation errors
            if (errors.isEmpty()) {
                // Set updated values to Class object
                lop.setTenlop(tenlop);
                lop.setMagv(magv);
                lop.setSiso(Integer.parseInt(sisoStr)); // Convert sisoStr to int

                // Update class information in the database
                boolean updateSuccess = classDAO.updateClass(lop);

                if (updateSuccess) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/lop.jsp");
                    return;
                } else {
                    errors.add("Lỗi: Không thể cập nhật thông tin lớp học.");
                }
            }
        }
    }
%>

<!-- Include menu -->
<%@ include file="/templates/admin/inc/menu.jsp" %>

<!-- Content Wrapper -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Chỉnh sửa lớp học</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Lớp học</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <!-- Display errors if any -->
    <% if (!errors.isEmpty()) { %>
    <div class="alert alert-danger">
        <% for (String error : errors) { %>
        <p><%= error %></p>
        <% } %>
    </div>
    <% } %>

    <!-- Edit Class Form -->
    <div class="container">
        <form id="editClassForm" action="${pageContext.request.contextPath}/edit-class" method="post">
            <div class="form-group">
                <label for="editMalop">Mã lớp</label>
                <input type="text" class="form-control" name="malop" id="editMalop" value="<%= lop != null ? lop.getMalop() : "" %>" readonly required>
            </div>
            <div class="form-group">
                <label for="editTenlop">Tên lớp</label>
                <input type="text" class="form-control" name="tenlop" id="editTenlop" value="<%= lop != null ? lop.getTenlop() : "" %>" placeholder="" required>
            </div>
            <div class="form-group">
                <label for="editMagv">Mã giáo viên</label>
                <input type="text" class="form-control" name="magv" id="editMagv" value="<%= lop != null ? lop.getMagv() : "" %>" placeholder="" required>
            </div>
            <div class="form-group">
                <label for="editSiso">Sĩ số</label>
                <input type="number" class="form-control" name="siso" id="editSiso" value="<%= lop != null ? lop.getSiso() : "" %>" placeholder="" required>
            </div>
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        </form>
    </div>
</div>

<!-- Include footer -->
<%@ include file="/templates/admin/inc/footer.jsp" %>
