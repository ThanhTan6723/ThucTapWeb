<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<html>
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
          <a class="sidebar-brand brand-logo" href="IndexAdminControll"><img src="assetsAdmin/images/logo.svg" alt="logo" /></a>
          <a class="sidebar-brand brand-logo-mini" href="IndexAdminControll"><img src="assetsAdmin/images/logo-mini.svg" alt="logo" /></a>
        </div>
        <ul class="nav">
          <li class="nav-item nav-category">
            <span class="nav-link">MENU ADMIN</span>
          </li>
          <li class="nav-item menu-items">
			<a class="nav-link" href="IndexAdminControll">
              <span class="menu-icon">
                <i class="mdi mdi-speedometer"></i>
              </span>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item menu-items">
			<a class="nav-link" href="./LoadUserPage">
              <span class="menu-icon">
                <i class="mdi mdi-playlist-play"></i>
              </span>
              <span class="menu-title">Quản lý người dùng</span>
            </a>
          </li>

            <li class="nav-item menu-items">
                <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <span class="menu-icon">
                <i class="mdi mdi-laptop"></i>
              </span>
                    <span class="menu-title">Kho</span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse" id="ui-basic">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item"> <a class="nav-link" href="./LoadProductsPage">Danh sách sản phẩm</a></li>
                        <li class="nav-item"> <a class="nav-link" href="">Thêm sản phẩm</a></li>
                        <li class="nav-item"> <a class="nav-link" href="./ExpiredProduct">Sản phẩm hết hạn</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item menu-items">
                <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              <span class="menu-icon">
                <i class="mdi mdi-security"></i>
              </span>
                    <span class="menu-title">Nhà cung cấp </span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse" id="auth">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item"> <a class="nav-link" href="../../pages/samples/blank-page.html"> Danh sách nhà cung cấp</a></li>
                        <li class="nav-item"> <a class="nav-link" href="../../pages/samples/error-404.html"> Thêm nhà cung cấp </a></li>
                        <li class="nav-item"> <a class="nav-link" href="../../pages/samples/error-500.html"> 500 </a></li>
                        <li class="nav-item"> <a class="nav-link" href="../../pages/samples/login.html"> Login </a></li>
                        <li class="nav-item"> <a class="nav-link" href="../../pages/samples/register.html"> Register </a></li>
                    </ul>
                </div>
            </li>
              <c:url var="bill" value="BillControll"></c:url>
          <li class="nav-item menu-items">
            <a class="nav-link" href="BillControll">
              <span class="menu-icon">
                <i class="mdi mdi-chart-bar"></i>
              </span>
              <span class="menu-title">Bill</span>
            </a>
          </li>
              <c:url var="billDetail" value="BillDetailControll"></c:url>
          <li class="nav-item menu-items">
            <a class="nav-link" href="BillDetailControll">
              <span class="menu-icon">
                <i class="mdi mdi-contacts"></i>
              </span>
              <span class="menu-title">Bill Detail</span>
            </a>
          </li>
        </ul>
      </nav>
</html>