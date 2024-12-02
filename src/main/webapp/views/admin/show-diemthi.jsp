<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="model.DiemThi" %>
<%@ page import="dao.StudentDAO" %>
<%@ page import="dao.DiemThiDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Điểm Thi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container-fluid">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <br>
                    <h1 class="m-0">Xem Điểm Học Sinh</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/views/admin/index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Xem điểm</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <hr>
    <div class="container-fluid">
        <%
            String mahs = request.getParameter("id");
            if (mahs != null) {
                StudentDAO studentDAO = new StudentDAO();
                DiemThiDAO diemThiDAO = new DiemThiDAO();
                Student student = studentDAO.getStudentByMahs(mahs);
                if (student != null) {
        %>
        <h2>Thông tin học sinh: <%= student.getHovaten() %></h2>
        <table class="table table-bordered" style="text-align: center;">
            <thead class="thead-dark">
            <tr>
                <th>Mã học sinh</th>
                <th>Họ Tên</th>
                <th>Ngày Sinh</th>
                <th>Lớp</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%= student.getMahs() %></td>
                <td><%= student.getHovaten() %></td>
                <td><%= student.getNgaysinh() %></td>
                <td><%= student.getMalop() %></td>
            </tr>
            </tbody>
        </table>

        <%
            List<String> namhocList = diemThiDAO.getDistinctNamHoc(mahs);
            double totalScore = 0;
            int totalSubjects = 0;
            for (String namhoc : namhocList) {
                List<DiemThi> diemThiList = diemThiDAO.getDiemThiByMahsAndNamhoc(mahs, namhoc);
                totalSubjects += diemThiList.size();
        %>
        <h2>Điểm học sinh (Năm học: <%= namhoc %>)</h2>
        <table class="table table-bordered" style="text-align: center;">
            <thead class="thead-dark">
            <tr>
                <th>Môn học</th>
                <th>Điểm 15p kì 1</th>
                <th>Điểm giữa kì 1</th>
                <th>Điểm cuối kì 1</th>
                <th>Điểm TB kì 1</th>
                <th>Điểm 15p kì 2</th>
                <th>Điểm giữa kì 2</th>
                <th>Điểm cuối kì 2</th>
                <th>Điểm TB kì 2</th>
                <th>Điểm tổng kết cả năm</th>
                <th>Chức năng</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (DiemThi diemThi : diemThiList) {
                    totalScore += (diemThi.getDiemtbki1() + diemThi.getDiemtbki2()) / 2;
            %>
            <tr>
                <td><%= diemThi.getTenmonhoc() %></td>
                <td><%= diemThi.getDiem15pki1() %></td>
                <td><%= diemThi.getDiemgiuaki1() %></td>
                <td><%= diemThi.getDiemcuoiki1() %></td>
                <td><%= String.format("%.2f", ((diemThi.getDiem15pki1() + (diemThi.getDiemgiuaki1() * 2) + (diemThi.getDiemcuoiki1() * 3)) / 6.0)) %></td>
                <td><%= diemThi.getDiem15pki2() %></td>
                <td><%= diemThi.getDiemgiuaki2() %></td>
                <td><%= diemThi.getDiemcuoiki2() %></td>
                <td><%= String.format("%.2f", ((diemThi.getDiem15pki2() + (diemThi.getDiemgiuaki2() * 2) + (diemThi.getDiemcuoiki2() * 3)) / 6.0)) %></td>
                <%
                    double diemTBKi1 = (diemThi.getDiem15pki1() + (diemThi.getDiemgiuaki1() * 2) + (diemThi.getDiemcuoiki1() * 3)) / 6.0;
                    double diemTBKi2 = (diemThi.getDiem15pki2() + (diemThi.getDiemgiuaki2() * 2) + (diemThi.getDiemcuoiki2() * 3)) / 6.0;
                    double diemTBCaNam = (diemTBKi1 + diemTBKi2) / 2.0;
                %>
                <td><%= String.format("%.2f", diemTBCaNam) %></td>
                <td>
                    <a href="/edit-diemthi?id=<%= diemThi.getMahs() %>" class="btn btn-info">Sửa</a>
<%--                    <a href="/delete-score?id=<%= diemThi.getMahs() %>" class="btn btn-danger">Xóa</a>--%>
                </td>
            </tr>


            <% } %>
            </tbody>
        </table>
        <%
            }
            if (totalSubjects > 0) {
                totalScore /= totalSubjects;
        %>
        <% } %>
        <%
        } else {
        %>
        <p class="alert alert-danger">Học sinh không tồn tại.</p>
        <%
            }
        } else {
        %>
        <p class="alert alert-warning">Vui lòng chọn một học sinh để xem điểm.</p>
        <%
            }
        %>
    </div>
</div>
</div>
</body>
</html>
