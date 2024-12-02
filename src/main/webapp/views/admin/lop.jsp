<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Class" %>
<%@ page import="dao.ClassDAO" %>
<%@ page import="java.util.ArrayList" %>

<!-- Include menu -->
<%@ include file="/templates/admin/inc/menu.jsp" %>

<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    if (errors == null) {
        errors = new ArrayList<>();
    }
%>

<!-- Content Wrapper -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Lớp học</h1>
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

    <!-- Button to add new class -->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalThem" style="margin-left: 15px">Thêm</button>

    <!-- Search form -->
    <div class="panel-heading">
        <form method="get" action="#" style="display: flex">
            <input type="text" id="searchBox" onkeyup="search()" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên">
        </form>
    </div>

    <!-- Table to display classes -->
    <table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
        <thead class="thead-CCFFFF">
        <tr class="list-header">
            <th scope="col">Mã lớp</th>
            <th scope="col">Tên lớp</th>
            <th scope="col">Mã giáo viên</th>
            <th scope="col">Sĩ số</th>
            <th scope="col">Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <% ClassDAO classDAO = new ClassDAO();
            List<Class> classList = classDAO.getAllClasses();
            for (Class clazz : classList) { %>
        <tr>
            <td><%= clazz.getMalop() %></td>
            <td><%= clazz.getTenlop() %></td>
            <td><%= clazz.getMagv() %></td>
            <td><%= clazz.getSiso() %></td>
            <td>
                <a href="/edit-class?id=<%= clazz.getMalop() %>" class="btn btn-warning">Sửa</a>
                <a href="#" class="btn btn-danger" onclick="return confirmDelete('<%= clazz.getMalop() %>')">Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Modal for Add Class -->
<div class="modal fade" id="modalThem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm lớp học</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addClassForm" action="/add-class" method="post" onsubmit="return validateAddForm()">
                    <div class="form-group row">
                        <label for="malop" class="col-sm-3">Mã lớp</label>
                        <input type="text" class="form-control col-sm-8" id="malop" name="malop" required>
                    </div>
                    <div class="form-group row">
                        <label for="tenlop" class="col-sm-3">Tên lớp</label>
                        <input type="text" class="form-control col-sm-8" id="tenlop" name="tenlop" required>
                    </div>
                    <div class="form-group row">
                        <label for="magv" class="col-sm-3">Mã giáo viên</label>
                        <input type="text" class="form-control col-sm-8" id="magv" name="magv" required>
                    </div>
                    <div class="form-group row">
                        <label for="siso" class="col-sm-3">Sĩ số</label>
                        <input type="number" class="form-control col-sm-8" id="siso" name="siso" required>
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

<!-- JavaScript for validation, deletion confirmation, and search -->
<script type="text/javascript">
    function validateAddForm() {
        var malop = document.getElementById("malop").value;
        var tenlop = document.getElementById("tenlop").value;
        var siso = document.getElementById("siso").value;

        var regexName = /^[a-zA-Z0-9À-Ỹà-ỹ\s]+$/; // Letters, numbers, and spaces
        var regexSiSo = /^[1-9][0-9]?$|^100$/; // Integer between 1 and 100
        var regexMalop = /^\d+$/; // Only digits

        // Validate Ten lop (class name)
        if (!regexName.test(tenlop)) {
            alert("Tên lớp chỉ chứa ký tự chữ và khoảng trắng");
            return false;
        }

        // Validate Siso (class size)
        if (!regexSiSo.test(siso)) {
            alert("Sĩ số phải là số nguyên và không lớn hơn 100");
            return false;
        }

        // Validate Malop (class ID) using AJAX
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    var response = this.responseText;
                    if (response === "exists") {
                        alert("Mã lớp đã tồn tại");
                    } else {
                        document.getElementById("addClassForm").submit();
                    }
                } else {
                    alert("Đã xảy ra lỗi khi kiểm tra mã lớp");
                }
            }
        };
        xhttp.open("GET", "/check-malop?malop=" + malop, true);
        xhttp.send();

        return false; // Prevent form submission
    }

    function confirmDelete(classId) {
        if (confirm("Bạn có chắc chắn muốn xóa lớp học này?")) {
            window.location.href = "/delete-class?id=" + classId;
        } else {
            return false;
        }
    }

    function search() {
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.getElementById("datatable").getElementsByTagName("tr");
        for (var i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
            var tenlop = rows[i].getElementsByTagName("td")[1];
            if (tenlop) {
                var tenlopValue = tenlop.textContent.toLowerCase() || tenlop.innerText.toLowerCase();
                if (tenlopValue.indexOf(searchValue) > -1) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }
</script>
<%@ include file="/templates/admin/inc/footer.jsp" %>
