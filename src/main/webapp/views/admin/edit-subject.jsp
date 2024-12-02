<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.Subject" %>
<%@ page import="dao.SubjectDAO" %>

<%
    // Nhận tham số id từ URL
    String mamh = request.getParameter("id");

    // Lấy thông tin môn học từ cơ sở dữ liệu
    SubjectDAO subjectDAO = new SubjectDAO();
    Subject subject = subjectDAO.getSubjectByMamh(mamh);
%>

<!-- Main Sidebar Container -->
<%@ include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
    <h2 style="margin-top: 20px">Edit Subject</h2>
    <form id="editSubjectForm" action="/edit-subject" method="post">
        <div class="form-group">
            <label for="editMamh">Mã môn học</label>
            <input type="text" class="form-control" name="mamh" id="editMamh" value="<%= subject.getMamh() %>" readonly required>
        </div>
        <div class="form-group">
            <label for="editTenmonhoc">Tên môn học</label>
            <input type="text" class="form-control" name="tenmonhoc" id="editTenmonhoc" value="<%= subject.getTenmonhoc() %>" placeholder="" required>
        </div>
        <div class="form-group">
            <label for="editSotiet">Số tiết</label>
            <input type="number" class="form-control" name="sotiet" id="editSotiet" value="<%= subject.getSotiet() %>" required>
        </div>
        <div class="form-group">
            <label for="editHinhthucthi">Hình thức thi</label>
            <input type="text" class="form-control" name="hinhthucthi" id="editHinhthucthi" value="<%= subject.getHinhthucthi() %>" placeholder="" required>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</div>

<%@ include file="/templates/admin/inc/footer.jsp" %>
