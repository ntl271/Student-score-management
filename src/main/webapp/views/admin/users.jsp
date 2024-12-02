<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="controller.UserController" %>
<!-- Main Sidebar Container -->
<%@include file="/templates/admin/inc/menu.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Người dùng</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Người dùng</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

<%--    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalThem" style="margin-left: 15px">Thêm</button>--%>
    <hr>
    <!-- Thêm form tìm kiếm -->
    <div class="panel-heading">
        <form method="get" action="/search-user" style="display: flex">
            <input type="text" id="searchBox" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên" onkeyup="search()">
        </form>
    </div>

    <table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
        <thead class="thead-CCFFFF">
        <tr class="list-header">
            <th scope="col">User ID</th>
            <th scope="col">Email</th>
            <th scope="col">Password</th>
            <th scope="col">Chức năng</th>
        </tr>
        </thead>
        <tbody>
        <%
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUsers();
            for (User user : userList) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getEmail() %></td>
            <td>
                <span class="password" data-password="<%= user.getPassword() %>">****</span>
                <i class="toggle-password fas fa-eye" style="cursor: pointer;"></i>
            </td>

            <td>
                <a href="/edit-user?id=<%= user.getId() %>" class="btn btn-warning">Sửa</a>
                <a href="#" class="btn btn-danger" onclick="return confirmDelete('<%= user.getId() %>')">Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div class="modal fade" id="modalThem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm Người Dùng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/add-user" method="post">
                    <div class="form-group row">
                        <label for="id" class="col-sm-3">ID</label>
                        <input type="text" class="form-control col-sm-8" id="id" name="id" required>
                    </div>
                    <div class="form-group row">
                        <label for="email" class="col-sm-3">Email</label>
                        <input type="email" class="form-control col-sm-8" id="email" name="email" required>
                    </div>
                    <div class="form-group row">
                        <label for="password" class="col-sm-3">Password</label>
                        <input type="password" class="form-control col-sm-8" id="password" name="password" required>
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
    document.addEventListener('DOMContentLoaded', function() {
        const toggleButtons = document.querySelectorAll('.toggle-password');
        toggleButtons.forEach(button => {
            button.addEventListener('click', function() {
                const passwordSpan = this.previousElementSibling;
                const password = passwordSpan.dataset.password;
                const type = passwordSpan.textContent === '****' ? 'text' : 'password';
                passwordSpan.textContent = type === 'text' ? password : '****';
                this.classList.toggle('fa-eye-slash');
            });
        });
    });
</script>

<script type="text/javascript">
    function confirmDelete(userId) {
        if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
            window.location.href = "/delete-user?id=" + userId;
        } else {
            return false;
        }
    }
</script>

<script>
    function search() {
        // Lấy giá trị của ô tìm kiếm
        var searchValue = document.getElementById("searchBox").value.toLowerCase();
        // Lặp qua tất cả các hàng trong bảng
        var rows = document.getElementsByTagName("tr");
        for (var i = 0; i < rows.length; i++) {
            // Lấy giá trị của ô email trong hàng đó

            var Email = rows[i].getElementsByTagName("td")[1];
            if (Email) {
                var EmailValue = Email.textContent.toLowerCase() || Email.innerText.toLowerCase();

                // Kiểm tra xem giá trị của ô email có chứa giá trị tìm kiếm hay không
                if (EmailValue.indexOf(searchValue) > -1) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
    }
</script>

<%@include file="/templates/admin/inc/footer.jsp" %>

