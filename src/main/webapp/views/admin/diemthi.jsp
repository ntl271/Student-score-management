<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="dao.StudentDAO" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>

<!-- Main Sidebar Container -->
<%@ include file="/templates/admin/inc/menu.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Sinh viên</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Điểm thi</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <hr>
    <!-- Thêm form tìm kiếm và select lớp -->
    <div class="panel-heading">
        <form method="get" action="/search-student" style="display: flex">
            <input type="text" id="searchBox" onkeyup="search()" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên">
            <!-- Fetch unique malop values from studentList -->
            <%
                StudentDAO studentDAO = new StudentDAO();
                List<Student> studentList = studentDAO.getAllStudents();

                // Use a Set to store unique malop values
                Set<String> uniqueClasses = new HashSet<>();
                for (Student student : studentList) {
                    uniqueClasses.add(student.getMalop());
                }
            %>

            <!-- Create select dropdown for malop -->
            <select id="classSelect" class="form-control" style="margin:15px" onchange="filterByClass()">
                <option value="">Chọn lớp</option>
                <%
                    for (String malop : uniqueClasses) {
                %>
                <option value="<%= malop %>"><%= malop %></option>
                <% } %>
            </select>

        </form>
    </div>


    <table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
        <thead class="thead-CCFFFF">
        <tr class="list-header">
            <th scope="col">Mã học sinh</th>
            <th scope="col">Tên học sinh</th>
            <th scope="col">Ngày sinh</th>
            <th scope="col">Mã lớp</th>
            <th scope="col">Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Student student : studentList) {
        %>
        <tr>
            <td><%= student.getMahs() %></td>
            <td><%= student.getHovaten() %></td>
            <td><%= student.getNgaysinh() %></td>
            <td><%= student.getMalop() %></td>
            <td>
                <a href="/show-diemthi?id=<%= student.getMahs() %>" class="btn btn-info">Xem điểm</a>
                <a href="/add-diemthi?id=<%= student.getMahs() %>" class="btn btn-success">Nhập điểm</a>
            </td>
        </tr>
        <% } %>

        </tbody>
    </table>
</div>

<script type="text/javascript">
    function confirmDelete(studentId) {
        if (confirm("Bạn có chắc chắn muốn xóa sinh viên này?")) {
            window.location.href = "delete-student?id=" + studentId;
        } else {
            return false;
        }
    }

    function search() {
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.getElementsByTagName("tr");
        for (var i = 0; i < rows.length; i++) {
            var hovatenCell = rows[i].getElementsByTagName("td")[1];
            if (hovatenCell) {
                var hovatenValue = hovatenCell.textContent.toLowerCase() || hovatenCell.innerText.toLowerCase();
                if (hovatenValue.indexOf(searchValue) > -1) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }

    function filterByClass() {
        var selectedClass = document.getElementById("classSelect").value;
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.getElementsByTagName("tr");
        for (var i = 0; i < rows.length; i++) {
            var hovatenCell = rows[i].getElementsByTagName("td")[1];
            var malopCell = rows[i].getElementsByTagName("td")[3];
            if (hovatenCell && malopCell) {
                var hovatenValue = hovatenCell.textContent.toLowerCase() || hovatenCell.innerText.toLowerCase();
                var malopValue = malopCell.textContent || malopCell.innerText;

                var matchesClass = selectedClass === "" || malopValue === selectedClass;
                var matchesSearch = hovatenValue.indexOf(searchValue) > -1;

                if (matchesClass && matchesSearch) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }
</script>

<%@ include file="/templates/admin/inc/footer.jsp" %>
