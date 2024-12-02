<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.DiemThi" %>
<%@ page import="dao.DiemThiDAO" %>

<%
  // Nhận tham số id từ URL
  String mahs = request.getParameter("id");

  // Lấy thông tin điểm thi từ cơ sở dữ liệu
  DiemThiDAO diemThiDAO = new DiemThiDAO();
  DiemThi diemThi = diemThiDAO.getDiemThiByMahs(mahs);
%>

<!-- Main Sidebar Container -->
<%@include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
  <h2 style="margin-top: 20px">Edit Điểm Thi</h2>
  <form id="editDiemThiForm" action="${pageContext.request.contextPath}/edit-diemthi" method="post">
    <div class="form-group">
      <label for="editMahs">Mã học sinh</label>
      <input type="text" class="form-control" name="mahs" id="editMahs" value="<%= diemThi.getMahs() %>" readonly required>
    </div>
    <div class="form-group">
      <label for="editNamhoc">Năm học</label>
      <input type="text" class="form-control" name="namhoc" id="editNamhoc" value="<%= diemThi.getNamhoc() %>" readonly required>
    </div>
    <div class="form-group">
      <label for="editTenmonhoc">Môn học</label>
      <input type="text" class="form-control" name="tenmonhoc" id="editTenmonhoc" value="<%= diemThi.getTenmonhoc() %>" readonly required>
    </div>
    <div class="form-group">
      <label for="editDiem15pki1">Điểm 15 phút kì 1</label>
      <input type="number" class="form-control" name="diem15pki1" id="editDiem15pki1" value="<%= diemThi.getDiem15pki1() %>" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="editDiemgiuaki1">Điểm giữa kì 1</label>
      <input type="number" class="form-control" name="diemgiuaki1" id="editDiemgiuaki1" value="<%= diemThi.getDiemgiuaki1() %>" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="editDiemcuoiki1">Điểm cuối kì 1</label>
      <input type="number" class="form-control" name="diemcuoiki1" id="editDiemcuoiki1" value="<%= diemThi.getDiemcuoiki1() %>" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="editDiem15pki2">Điểm 15 phút kì 2</label>
      <input type="number" class="form-control" name="diem15pki2" id="editDiem15pki2" value="<%= diemThi.getDiem15pki2() %>" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="editDiemgiuaki2">Điểm giữa kì 2</label>
      <input type="number" class="form-control" name="diemgiuaki2" id="editDiemgiuaki2" value="<%= diemThi.getDiemgiuaki2() %>" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="editDiemcuoiki2">Điểm cuối kì 2</label>
      <input type="number" class="form-control" name="diemcuoiki2" id="editDiemcuoiki2" value="<%= diemThi.getDiemcuoiki2() %>" step="0.01" required>
    </div>
    <button type="submit" class="btn btn-primary">Save Changes</button>
  </form>
</div>

<%@include file="/templates/admin/inc/footer.jsp" %>
