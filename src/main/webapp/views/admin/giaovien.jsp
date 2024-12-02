<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/templates/admin/inc/header.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Teacher" %>
<%@ page import="dao.TeacherDAO" %>
<%@ page import="controller.TeacherController" %>
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
					<h1 class="m-0">Giáo viên</h1>
				</div><!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
						<li class="breadcrumb-item active">Giáo viên</li>
					</ol>
				</div>
			</div>
		</div>
	</div>

	<% if (!errors.isEmpty()) { %>
	<div class="alert alert-danger">
		<ul>
			<% for (String error : errors) { %>
			<li><%= error %></li>
			<% } %>
		</ul>
	</div>
	<% } %>


	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalThem" style="margin-left: 15px">Thêm</button>
	<hr>
	<!-- Thêm form tìm kiếm -->
	<div class="panel-heading">
		<form method="get" action="/search-teacher" style="display: flex">
			<input type="text" id="searchBox" class="form-control" style="margin:15px" placeholder="Tìm kiếm theo tên" onkeyup="search()">
		</form>
	</div>

	<table class="table table-bordered" id="datatable" style="text-align:center; margin-left: 15px;margin-right: 15px">
		<thead class="thead-CCFFFF">
		<tr class="list-header">
			<th scope="col">Mã Giáo Viên</th>
			<th scope="col">Tên Giáo Viên</th>
			<th scope="col">Ngày Sinh</th>
			<th scope="col">Môn dạy</th>
			<th scope="col">Email</th>
			<th scope="col">Số điện thoại</th>
			<th scope="col">Chức năng</th>
		</tr>
		</thead>
		<tbody>
		<%
			TeacherDAO teacherDAO = new TeacherDAO();
			List<Teacher> teacherList = teacherDAO.getAllTeachers();
			for (Teacher teacher : teacherList) {
		%>
		<tr>
			<td><%= teacher.getMagv() %></td>
			<td><%= teacher.getHoten() %></td>
			<td><%= teacher.getNgaysinh() %></td>
			<td><%= teacher.getMonday() %></td>
			<td><%= teacher.getEmail() %></td>
			<td><%= teacher.getSdt() %></td>
			<td>
				<a href="/edit-teacher?id=<%= teacher.getMagv() %>" class="btn btn-warning">Sửa</a>
				<a href="#" class="btn btn-danger" onclick="return confirmDelete('<%= teacher.getMagv() %>')">Xóa</a>
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
				<h5 class="modal-title" id="exampleModalLabel">Thêm Giảng Viên</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="/add-teacher" method="post" onsubmit="return validateAddForm()">
					<div class="form-group row">
						<label for="magv" class="col-sm-3">Mã Giáo Viên</label>
						<input type="text" class="form-control col-sm-8" id="magv" name="magv" required>
					</div>
					<div class="form-group row">
						<label for="hoten" class="col-sm-3">Tên Giáo Viên</label>
						<input type="text" class="form-control col-sm-8" id="hoten" name="hoten" required>
					</div>
					<div class="form-group row">
						<label for="ngaysinh" class="col-sm-3">Ngày Sinh</label>
						<input type="text" class="form-control col-sm-8" id="ngaysinh" name="ngaysinh" required>
					</div>
					<div class="form-group row">
						<label for="monday" class="col-sm-3">Môn dạy</label>
						<input type="text" class="form-control col-sm-8" id="monday" name="monday" required>
					</div>
					<div class="form-group row">
						<label for="email" class="col-sm-3">Email</label>
						<input type="email" class="form-control col-sm-8" id="email" name="email" required>
					</div>
					<div class="form-group row">
						<label for="sdt" class="col-sm-3">Số điện thoại</label>
						<input type="text" class="form-control col-sm-8" id="sdt" name="sdt" required>
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
		var magv = document.getElementById("magv").value;
		var hoten = document.getElementById("hoten").value;
		var ngaysinh = document.getElementById("ngaysinh").value;
		var sdt = document.getElementById("sdt").value;

		var regexName = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/; // Only letters and spaces
		var regexDate = /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$/; // Date format DD/MM/YYYY
		var regexPhone = /^[0-9]{10,13}$/; // Phone number with 10 to 13 digits
		var regexMagv = /^\d+$/; // Only digits

		// Kiểm tra các điều kiện hợp lệ của dữ liệu nhập vào
		if (!regexName.test(hoten)) {
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

		// Kiểm tra sự tồn tại của mã giáo viên trước khi submit form
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					var response = this.responseText;
					if (response === "exists") {
						alert("Mã giáo viên đã tồn tại");
					} else {
						document.getElementById("addTeacherForm").submit();
					}
				} else {
					alert("Đã xảy ra lỗi khi kiểm tra mã giáo viên");
				}
			}
		};
		xhttp.open("GET", "/check-magv?magv=" + magv, true);
		xhttp.send();

		return false; // Ngăn người dùng submit form trước khi kiểm tra xong
	}



	function confirmDelete(teacherId) {
		if (confirm("Bạn có chắc chắn muốn xóa giáo viên này?")) {
			window.location.href = "/delete-teacher?id=" + teacherId;
		} else {
			return false;
		}
	}
	function search() {
		// Lấy giá trị của ô tìm kiếm
		var searchValue = document.getElementById("searchBox").value.toLowerCase();
		// Lặp qua tất cả các hàng trong bảng
		var rows = document.getElementsByTagName("tr");
		for (var i = 0; i < rows.length; i++) {
			// Lấy giá trị của ô hoten trong hàng đó

			var Hoten = rows[i].getElementsByTagName("td")[1];
			if (Hoten) {
				var HotenValue = Hoten.textContent.toLowerCase() || Hoten.innerText.toLowerCase();
				// Kiểm tra nếu giá trị của ô hoten không chứa giá trị tìm kiếm
				if (HotenValue.indexOf(searchValue) > -1) {
					rows[i].style.display = "";
				} else {
					rows[i].style.display = "none";
				}
			}
		}
	}
</script>
<%@include file="/templates/admin/inc/footer.jsp" %>
