<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<html>
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
          <a class="sidebar-brand brand-logo" href="index.html"><img src="assets/images/logo.svg" alt="logo" /></a>
          <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="assets/images/logo-mini.svg" alt="logo" /></a>
        </div>
        <ul class="nav">
          <li class="nav-item nav-category">
            <span class="nav-link">MENU ADMIN</span>
          </li>
          <li class="nav-item menu-items">
              <c:url var="index" value="IndexAdminControll"></c:url>
			<a class="nav-link" href="${pageContext.request.contextPath}/${index}">
              <span class="menu-icon">
                <i class="mdi mdi-speedometer"></i>
              </span>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item menu-items">
              <c:url var="usermanager" value="ListUsersControll"></c:url>
          
			<a class="nav-link" href="${pageContext.request.contextPath}/${usermanager}">
              <span class="menu-icon">
                <i class="mdi mdi-playlist-play"></i>
              </span>
              <span class="menu-title">User Manager</span>
            </a>
          </li>
          <li class="nav-item menu-items">
              <c:url var="listProduct" value="ListProductsControll"></c:url>
          
			<a class="nav-link" href="${pageContext.request.contextPath}/${listProduct}">
              <span class="menu-icon">
                <i class="mdi mdi-table-large"></i>
              </span>
              <span class="menu-title">List Products</span>
            </a>
          </li>
              <c:url var="bill" value="BillControll"></c:url>
          <li class="nav-item menu-items">
            <a class="nav-link" href="${pageContext.request.contextPath}/${bill}">
              <span class="menu-icon">
                <i class="mdi mdi-chart-bar"></i>
              </span>
              <span class="menu-title">Bill</span>
            </a>
          </li>
              <c:url var="billDetail" value="BillDetailControll"></c:url>
          <li class="nav-item menu-items">
            <a class="nav-link" href="${pageContext.request.contextPath}/${billDetail}">
              <span class="menu-icon">
                <i class="mdi mdi-contacts"></i>
              </span>
              <span class="menu-title">Bill Detail</span>
            </a>
          </li>
        </ul>
      </nav>
</html>