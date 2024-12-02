<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>

<%
    // Nhận tham số id từ URL
    int userId = Integer.parseInt(request.getParameter("id"));

    // Lấy thông tin người dùng từ cơ sở dữ liệu
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(userId);

    // if (user == null) {
    //     out.println("<p>Không tìm thấy người dùng với ID này.</p>");
    //     return;
    // }
%>

<!-- Main Sidebar Container -->
<%@include file="/templates/admin/inc/menu.jsp" %>

<div class="container" style="margin-right: 100px">
    <h2 style="margin-top: 20px">Edit User</h2>
    <form id="editUserForm" action="/edit-user" method="post">
        <div class="form-group">
            <label for="editUserId">User ID</label>
            <input type="text" class="form-control" name="id" id="editUserId" value="<%= user.getId() %>" readonly required>
        </div>
        <div class="form-group">
            <label for="editEmail">Email</label>
            <input type="email" class="form-control" name="email" id="editEmail" value="<%= user.getEmail() %>" placeholder="" required>
        </div>
        <div class="form-group">
            <label for="editPassword">Password</label>
            <input type="password" class="form-control" name="password" id="editPassword" value="<%= user.getPassword() %>" placeholder="" required>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</div>

<%@include file="/templates/admin/inc/footer.jsp" %>
