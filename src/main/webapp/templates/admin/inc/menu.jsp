<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="<%=request.getContextPath() %>/views/admin/index.jsp" class="brand-link">
    <img src="<%=request.getContextPath() %>/templates/admin/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
    <span class="brand-text font-weight-light">Quản lý điểm học sinh</span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
      <div class="image">
        <img src="<%=request.getContextPath() %>/templates/admin/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
        <li class="nav-item menu-open">
          <a href="<%=request.getContextPath()%>/views/admin/index.jsp" class="nav-link active">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>Trang chủ</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/hocsinh.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Học sinh</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/giaovien.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Giáo viên</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/lop.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Lớp</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/monhoc.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Môn học</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/diemthi.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Điểm thi</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="<%=request.getContextPath()%>/views/admin/users.jsp" class="nav-link">
            <i class="nav-icon fas fa-th"></i>
            <p>Tài khoản</p>
          </a>
        </li>
        <li class="nav-item menu-open" style="margin-top: 200px; background-color: #007bff; font-family: Source Sans Pro; border-radius: 10px; text-align: center;">
          <a href="<%=request.getContextPath()%>/views/login.jsp" class="nav-link" style="display: flex; align-items: center; justify-content: center;">
            <i class="nav-icon" style="margin-right: 5px;">
              <img width="20" height="20" src="https://img.icons8.com/metro/26/exit.png" alt="exit"/>
            </i>
            <p style="margin-top: 5px;">LOG OUT</p>
          </a>
        </li>
      </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>
