<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="log" value="Login/Sign up"></c:set>

<header class="header">
    <!-- Header Top -->
    <div class="header__top">
        <div class="container">
            <div class="row">
                <!-- Left Section -->
                <div class="col-lg-6">
                    <div class="header__top__left">
                        <ul>
                            <li><i class="fa fa-envelope"></i> kfood@23Incheon.com</li>
                            <li>Seoul</li>
                        </ul>
                    </div>
                </div>
                <!-- Right Section -->
                <div class="col-lg-6">
                    <div class="header__top__right">
                        <!-- Social Icons -->
                        <div class="header__top__right__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-linkedin"></i></a>
                            <a href="#"><i class="fa fa-pinterest-p"></i></a>
                        </div>
                        <!-- Language Selection -->
                        <div class="header__top__right__language">
                            <a href="I18N?lang=English"><img src="assets/img/usa.png" alt=""></a>
                            <a href="I18N?lang=Vietnamese"><img src="assets/img/vietnam.png" alt=""></a>
                        </div>
                        <!-- Authentication Section -->
                        
                        <c:if test="${empty sessionScope.account}">
                            <c:url var="login" value="LoginControll"></c:url>
                            <div class="header__top__right__auth">
                                <a href="${pageContext.request.contextPath}/${login}"><i><img
                                        src="client/assets/img/login.png" alt=""></i>Đăng nhập/Đăng ký</a>
                            </div>
                        </c:if>
                        <c:if test="${not empty sessionScope.account}">
                            <div class="header__top__right__auth">
                                <!-- Dropdown for Logged-in User -->
                                <div class="dropdown">

<%--                                    <c:url var="url" value="assets"></c:url>--%>
                                    <ul> 
                                        <i><img src="assets/img/avatar.png" alt="">${sessionScope.account.name}<i class="fa fa-caret-down"></i></i>
                                      
                                    </ul>
                                    <div class="dropdown-content">
                                    <c:if test="${sessionScope.account.isAdmin == 1}">
                                    	<a href="/IndexAdminControll">
                                            <b>Quản lý</b>
                                        </a>
                                    </c:if>
                                        <a href="/UpdateProfileControll">
                                        	<b>Tài khoản</b></a>
                                        <a href="/ChangePassword">
                                            <b>Đổi mật khẩu</b>
                                        </a>
                                        <a href="/LogoutControll">
                                            <b>Đăng xuất</b>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Header Bottom -->
    <div class="container">
        <div class="row">
            <!-- Logo Section -->
            <div class="col-lg-3">
                <div class="header__logo">
                    <a href="../index.jsp"><img src="client/assets/img/logo.png" alt=""></a>
                </div>
            </div>
            <!-- Navigation Section -->
            <div class="col-lg-6">
                <nav class="header__menu">
                    <ul>
                        <!-- URL Definitions -->
                        <c:url var="index" value="IndexControll"></c:url>
                        <c:url var="showProduct" value="ShowProductControl"></c:url>
                        <c:url var="about" value="IntroduceControll"></c:url>
                        <c:url var="orderplace" value="OrderPlaceControl"></c:url>
                        <c:url var="contact" value="ContactControll"></c:url>
                        <c:url var="cart" value="CartControll"></c:url>
                        <!-- Menu Items -->
                        <li class="active"><a href="/IndexControll">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/${showProduct}?cid=0">Sản phẩm</a>
                            <!-- Dropdown Menu for Product Categories -->
                            <ul class="header__menu__dropdown">
                                <li class=""><a href="${pageContext.request.contextPath}/${showProduct}?cid=0">All</a></li>
                                <li class=""><a href="${pageContext.request.contextPath}/${showProduct}?cid=1">Noodle</a></li>
                                <li class=""><a href="${pageContext.request.contextPath}/${showProduct}?cid=2">Chicken</a></li>
                                <li class=""><a href="${pageContext.request.contextPath}/${showProduct}?cid=3">Rice</a></li>
                            </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/${about}">Giới thiệu</a></li>
                        <!-- Show Order Menu Item only if User is Logged In -->
                        <c:if test="${sessionScope.account!=null}">
                            <li><a href="${pageContext.request.contextPath}/${orderplace}">Đơn đã đặt</a></li>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}/${contact}">Liên hệ</a></li>
                    </ul>
                </nav>
            </div>
            <!-- Cart Section -->
            <div class="col-lg-3">
                <div class="header__cart">
                    <ul>
                        <li><a href="./CartControll">
                                <i><img style="width: 40px; height: 40px;" src="assets/img/cart.svg" alt=""></i>
                                <c:if test="${empty sessionScope.size}"><span>0</span></c:if>
                                <c:if test="${not empty sessionScope.size}"><span>${sessionScope.size}</span></c:if>
                            </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Hero Section Begin -->
<section class="hero hero-normal">
    <div class="container">
        <div class="row">
            <!-- Hero Categories -->
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <span>KOREAN RESTAURANT</span>
                    </div>
                </div>
            </div>
            <!-- Hero Search -->
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <!-- Search URL -->
                        <c:url var="search" value="SearchControl"></c:url>
                        <form action="${pageContext.request.contextPath}/${search}" method="get" class="form-inline sk-search-in-nav">
                            <!-- Search Categories Dropdown -->
                            <div class="hero__search__categories">
                                All Categories <span class="arrow_carrot-down"></span>
                            </div>
                            <!-- Search Input -->
                            <input type="text" placeholder="What do you need?"
                                name="query">
                            <!-- Search Button -->
                            <button type="submit" class="site-btn">
                              Search
                            </button>
                        </form>
                    </div>
                    <!-- Hero Phone Contact -->
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>+65 11.188.888</h5>
                            <span>Contact</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>