<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Subject" %>
<%@ page import="dao.SubjectDAO" %>
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
                    <h1 class="m-0">Danh sách môn học</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Môn học</li>
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
        <form method="get" action="/search-subject" style="display: flex">
            <input type="text" id="searchBox" onkeyup="search()" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên môn học">
        </form>
    </div>

    <table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
        <thead class="thead-CCFFFF">
        <tr class="list-header">
            <th scope="col">Mã môn học</th>
            <th scope="col">Tên môn học</th>
            <th scope="col">Số tiết</th>
            <th scope="col">Hình thức thi</th>
            <th scope="col">Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <%
            SubjectDAO subjectDAO = new SubjectDAO();
            List<Subject> subjectList = subjectDAO.getAllSubjects();
            for (Subject subject : subjectList) {
        %>
        <tr>
            <td><%= subject.getMamh() %></td>
            <td><%= subject.getTenmonhoc() %></td>
            <td><%= subject.getSotiet() %></td>
            <td><%= subject.getHinhthucthi() %></td>
            <td>
                <a href="/edit-subject?id=<%= subject.getMamh() %>" class="btn btn-warning">Sửa</a>
                <a href="#" class="btn btn-danger" onclick="return confirmDelete('<%= subject.getMamh() %>')">Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Form Thêm -->
<div class="modal fade" id="modalThem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm môn học</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addSubjectForm" action="/add-subject" method="post" onsubmit="return validateAddForm()">
                    <div class="form-group row">
                        <label for="mamh" class="col-sm-3">Mã môn học</label>
                        <input type="text" class="form-control col-sm-8" id="mamh" name="mamh" required>
                    </div>
                    <div class="form-group row">
                        <label for="tenmonhoc" class="col-sm-3">Tên môn học</label>
                        <input type="text" class="form-control col-sm-8" id="tenmonhoc" name="tenmonhoc" required>
                    </div>
                    <div class="form-group row">
                        <label for="sotiet" class="col-sm-3">Số tiết</label>
                        <input type="number" class="form-control col-sm-8" id="sotiet" name="sotiet" required>
                    </div>
                    <div class="form-group row">
                        <label for="hinhthucthi" class="col-sm-3">Hình thức thi</label>
                        <input type="text" class="form-control col-sm-8" id="hinhthucthi" name="hinhthucthi" required>
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

<script type="text/javascript">
    function validateAddForm() {
        var mamh = document.getElementById("mamh").value;
        var tenmonhoc = document.getElementById("tenmonhoc").value;
        var sotiet = document.getElementById("sotiet").value;
        var hinhthucthi = document.getElementById("hinhthucthi").value;

        var regexName = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/; // Only letters and spaces
        var regexSotiet = /^[1-9][0-9]?$|^150$/;
        var regexHinhthucthi = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/; // Only letters and spaces
        var regexMamh = /^\d+$/; // Only digits

        if (!regexName.test(tenmonhoc)) {
            alert("Tên môn học chỉ chứa ký tự chữ và khoảng trắng");
            return false;
        }
        if (!regexSotiet.test(sotiet)) {
            alert("Số tiết phải là số nguyên và không lớn hơn 150");
            return false;
        }
        if (!regexHinhthucthi.test(hinhthucthi)) {
            alert("Hình thức thi chỉ chứa ký tự chữ và khoảng trắng");
            return false;
        }

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = this.responseText;
                if (response === "exists") {
                    alert("Mã môn học đã tồn tại");
                } else {
                    document.getElementById("addSubjectForm").submit();
                }
            } else if (this.readyState == 4) {
                alert("Đã xảy ra lỗi khi kiểm tra mã môn học");
            }
        };
        xhttp.open("GET", "/check-mamh?mamh=" + mamh, true);
        xhttp.send();


        return false; // Prevent form submission
    }

    function confirmDelete(subjectId) {
        if (confirm("Bạn có chắc chắn muốn xóa môn học này?")) {
            window.location.href = "/delete-subject?id=" + subjectId;
        } else {
            return false;
        }
    }

    function search() {
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.getElementsByTagName("tr");
        for (var i = 0; i < rows.length; i++) {
            var tenMonHoc = rows[i].getElementsByTagName("td")[1];
            if (tenMonHoc) {
                var tenMonHocValue = tenMonHoc.textContent.toLowerCase() || tenMonHoc.innerText.toLowerCase();
                if (tenMonHocValue.indexOf(searchValue) > -1) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }
</script>

<%@include file="/templates/admin/inc/footer.jsp" %>
