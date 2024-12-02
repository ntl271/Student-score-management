<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="dao.StudentDAO" %>
<%@ page import="controller.StudentController" %>
<%@ page import="java.util.ArrayList" %>

<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    if (errors == null) {
        errors = new ArrayList<>();
    }
%>

<!-- Main Sidebar Container -->
<%@include file="/templates/admin/inc/menu.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Học sinh</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Học sinh</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <% if (!errors.isEmpty()) { %>
    <div class="alert alert-danger">
        <% for (String error : errors) { %>
        <p><%= error %></p>
        <% } %>
    </div>
    <% } %>

    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalThem" style="margin-left: 15px">Thêm</button>

    <hr>
    <!-- Thêm form tìm kiếm -->
    <div class="panel-heading">
        <form method="get" action="#" style="display: flex">
            <input type="text" id="searchBox" onkeyup="search()" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên">
        </form>
    </div>

    <table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
        <thead class="thead-CCFFFF">
        <tr class="list-header">
            <th scope="col">Mã học sinh</th>
            <th scope="col">Tên học sinh</th>
            <th scope="col">Ngày sinh</th>
            <th scope="col">Mã lớp</th>
            <th scope="col">Địa chỉ</th>
            <th scope="col">Số điện thoại</th>
            <th scope="col">GVCN</th>
            <th scope="col">Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <%
            StudentDAO studentDAO = new StudentDAO();
            List<Student> studentList = studentDAO.getAllStudents();
            for (Student student : studentList) {
        %>
        <tr>
            <td><%= student.getMahs() %></td>
            <td><%= student.getHovaten() %></td>
            <td><%= student.getNgaysinh() %></td>
            <td><%= student.getMalop() %></td>
            <td><%= student.getDiachi() %></td>
            <td><%= student.getSdt() %></td>
            <td><%= student.getGvcn() %></td>
            <td>
                <a href="/edit-student?id=<%= student.getMahs() %>" class="btn btn-warning">Sửa</a>
                <a href="#" class="btn btn-danger" onclick="return confirmDelete('<%= student.getMahs() %>')">Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<%--Form Thêm--%>
<div class="modal fade" id="modalThem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm sinh viên</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addStudentForm" action="/add-student" method="post" onsubmit="return validateAddForm()">
                    <div class="form-group row">
                        <label for="mahs" class="col-sm-3">Mã học sinh</label>
                        <input type="text" class="form-control col-sm-8" id="mahs" name="mahs" required>
                    </div>
                    <div class="form-group row">
                        <label for="hovaten" class="col-sm-3">Tên học sinh</label>
                        <input type="text" class="form-control col-sm-8" id="hovaten" name="hovaten" required>
                    </div>
                    <div class="form-group row">
                        <label for="ngaysinh" class="col-sm-3">Ngày sinh</label>
                        <input type="text" class="form-control col-sm-8" id="ngaysinh" name="ngaysinh" required placeholder="DD/MM/YYYY">
                    </div>
                    <div class="form-group row">
                        <label for="malop" class="col-sm-3">Mã lớp</label>
                        <input type="text" class="form-control col-sm-8" id="malop" name="malop" required>
                    </div>
                    <div class="form-group row">
                        <label for="diachi" class="col-sm-3">Địa chỉ</label>
                        <input type="text" class="form-control col-sm-8" id="diachi" name="diachi" required>
                    </div>
                    <div class="form-group row">
                        <label for="sdt" class="col-sm-3">Số điện thoại</label>
                        <input type="text" class="form-control col-sm-8" id="sdt" name="sdt" required>
                    </div>
                    <div class="form-group row">
                        <label for="gvcn" class="col-sm-3">GVCN</label>
                        <input type="text" class="form-control col-sm-8" id="gvcn" name="gvcn" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Thoát</button>
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function validateAddForm() {
        var mahs = document.getElementById("mahs").value;
        var hovaten = document.getElementById("hovaten").value;
        var ngaysinh = document.getElementById("ngaysinh").value;
        var sdt = document.getElementById("sdt").value;

        var regexName = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/; // Only letters and spaces
        var regexDate = /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$/; // Date format DD/MM/YYYY
        var regexPhone = /^[0-9]{10,13}$/; // Phone number with 10 to 13 digits
        var regexMahs = /^\d+$/; // Only digits

        if (!regexName.test(hovaten)) {
            alert("Họ và tên chỉ chứa ký tự chữ và khoảng trắng");
            return false;
        }
        if (!regexDate.test(ngaysinh)) {
            alert("Ngày sinh không đúng định dạng DD/MM/YYYY");
            return false;
        }
        if (!regexPhone.test(sdt)) {
            alert("Số điện thoại phải có từ 10 đến 13 chữ số");
            return false;
        }

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    var response = this.responseText;
                    if (response === "exists") {
                        alert("Mã học sinh đã tồn tại");
                    } else {
                        document.getElementById("addStudentForm").submit();
                    }
                } else {
                    alert("Đã xảy ra lỗi khi kiểm tra mã học sinh");
                }
            }
        };
        xhttp.open("GET", "/check-mahs?mahs=" + mahs, true);
        xhttp.send();

        return false; // Prevent form submission
    }



    function confirmDelete(studentId) {
        if (confirm("Bạn có chắc chắn muốn xóa học sinh này?")) {
            window.location.href = "/delete-student?id=" + studentId;
        } else {
            return false;
        }
    }

    function search() {
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.getElementById("datatable").getElementsByTagName("tr");
        for (var i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
            var hovaten = rows[i].getElementsByTagName("td")[1];
            if (hovaten) {
                var hovatenValue = hovaten.textContent.toLowerCase() || hovaten.innerText.toLowerCase();
                if (hovatenValue.indexOf(searchValue) > -1) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }
</script>

<%@include file="/templates/admin/inc/footer.jsp" %>
