<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Main Sidebar Container -->
<%@include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
  <h2 style="margin-top: 20px">Add Điểm Thi</h2>
  <form id="addDiemThiForm" action="${pageContext.request.contextPath}/add-diemthi" method="post">
    <div class="form-group">
      <label for="addMahs">Mã học sinh</label>
      <input type="text" class="form-control" name="mahs" id="addMahs" value="<%= request.getParameter("id") %>" readonly required>
    </div>
    <div class="form-group">
      <label for="addNamhoc">Năm học</label>
      <input type="text" class="form-control" name="namhoc" id="addNamhoc" required>
    </div>
    <div class="form-group">
      <label for="addTenmonhoc" class="form-label">Chọn môn học:</label>
      <select name="tenmonhoc" id="addTenmonhoc" class="form-control" required>
        <option value="Ngữ Văn">Ngữ Văn</option>
        <option value="Toán">Toán</option>
        <option value="Ngoại ngữ">Ngoại ngữ</option>
        <option value="Giáo dục thể chất">Giáo dục thể chất</option>
        <option value="Lịch sử">Lịch sử</option>
        <option value="Địa lí">Địa lí</option>
        <option value="Vật lí">Vật lí</option>
        <option value="Hóa học">Hóa học</option>
        <option value="Sinh học">Sinh học</option>
        <option value="Công nghệ">Công nghệ</option>
        <option value="Tin học">Tin học</option>
        <option value="Giáo dục công dân">Giáo dục công dân</option>
      </select>
    </div>
    <div class="form-group">
      <label for="addDiem15pki1">Điểm 15 phút kì 1</label>
      <input type="number" class="form-control" name="diem15pki1" id="addDiem15pki1" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="addDiemgiuaki1">Điểm giữa kì 1</label>
      <input type="number" class="form-control" name="diemgiuaki1" id="addDiemgiuaki1" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="addDiemcuoiki1">Điểm cuối kì 1</label>
      <input type="number" class="form-control" name="diemcuoiki1" id="addDiemcuoiki1" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="addDiem15pki2">Điểm 15 phút kì 2</label>
      <input type="number" class="form-control" name="diem15pki2" id="addDiem15pki2" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="addDiemgiuaki2">Điểm giữa kì 2</label>
      <input type="number" class="form-control" name="diemgiuaki2" id="addDiemgiuaki2" step="0.01" required>
    </div>
    <div class="form-group">
      <label for="addDiemcuoiki2">Điểm cuối kì 2</label>
      <input type="number" class="form-control" name="diemcuoiki2" id="addDiemcuoiki2" step="0.01" required>
    </div>
    <button type="submit" class="btn btn-primary">Add Điểm Thi</button>
  </form>
</div>
<script>
  // Function to validate input value
  function validateInput(inputId) {
    var input = document.getElementById(inputId);
    var value = parseFloat(input.value);

    // Check if value is valid (between 0 and 10)
    if (isNaN(value) || value < 0 || value > 10) {
      input.setCustomValidity('Vui lòng nhập lại điểm');
    } else {
      input.setCustomValidity('');
    }
  }

  // Attach event listeners to each input field
  document.getElementById('addDiem15pki1').addEventListener('input', function() {
    validateInput('addDiem15pki1');
  });

  document.getElementById('addDiemgiuaki1').addEventListener('input', function() {
    validateInput('addDiemgiuaki1');
  });

  document.getElementById('addDiemcuoiki1').addEventListener('input', function() {
    validateInput('addDiemcuoiki1');
  });

  document.getElementById('addDiem15pki2').addEventListener('input', function() {
    validateInput('addDiem15pki2');
  });

  document.getElementById('addDiemgiuaki2').addEventListener('input', function() {
    validateInput('addDiemgiuaki2');
  });

  document.getElementById('addDiemcuoiki2').addEventListener('input', function() {
    validateInput('addDiemcuoiki2');
  });
</script>

<%@include file="/templates/admin/inc/footer.jsp" %>
