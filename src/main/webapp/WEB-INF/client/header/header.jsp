<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<style>.container .row .col-lg-6 ul li{
    margin-right: 30px;
}
</style>

<c:set var="log" value="Login/Sign up"></c:set>

<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__left">
                        <ul>
                            <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                            <li>Miễn phí giao hàng cho các đơn trên $99</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__right">
                        <div class="header__top__right__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-linkedin"></i></a>
                            <a href="#"><i class="fa fa-pinterest-p"></i></a>
                        </div>
                        <div class="header__top__right__language">
                            <a href="I18N?lang=English"><img src="assets/img/usa.png" alt=""></a>
                            <a href="I18N?lang=Vietnamese"><img src="assets/img/vietnam.png" alt=""></a>
                        </div>

<%--
                        <c:if test="${empty sessionScope.account}">
--%>
                            <div class="header__top__right__auth">
                                <a href="./LoginControll"><i><img
                                        src="client/assets/img/login.png" alt=""></i>Đăng nhập/Đăng ký</a>
                            </div>
<%--
                        </c:if>
--%>
                        <c:if test="${not empty sessionScope.account}">
                            <div class="header__top__right__auth">
                                <!-- Dropdown for Logged-in User -->
                                <div class="dropdown">
                                    <c:url var="indexAd" value="IndexAdminControll"></c:url>
                                    <c:url var="profile" value="UpdateProfileControll"></c:url>
                                    <c:url var="changepass" value="ChangePassword"></c:url>
                                    <c:url var="logout" value="LogoutControll"></c:url>
                                        <%--                                    <c:url var="url" value="assets"></c:url>--%>
                                    <ul>
                                        <i><img src="assets/img/avatar.png" alt="">${sessionScope.account.name}<i class="fa fa-caret-down"></i></i>

                                    </ul>
                                    <div class="dropdown-content">
                                        <c:if test="${sessionScope.account.isAdmin == 1}">
                                            <a href="${pageContext.request.contextPath}/${indexAd}">
                                                <b>Quản lý</b>
                                            </a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/${profile}">
                                            <b>Tài khoản</b></a>
                                        <a href="${pageContext.request.contextPath}/${changepass}">
                                            <b>Đổi mật khẩu</b>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/${logout}">
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
                    <a href="./IndexControll"><img src="assets/img/logo.png" alt=""></a>
                </div>
            </div>
            <!-- Navigation Section -->
            <div class="col-lg-6">
                <nav class="header__menu">
                    <ul>

                        <li ><a href="./IndexControll">Trang chủ</a></li>
                        <li><a href="./ShowProductControl?cid=0">Sản phẩm</a>
                            <!-- Dropdown Menu for Product Categories -->
                            <ul class="header__menu__dropdown">
                                <li class=""><a href="./ShowProductControl?cid=0">All</a></li>
                                <li class=""><a href="./ShowProductControl?cid=1">Noodle</a></li>
                                <li class=""><a href="./ShowProductControl?cid=2">Chicken</a></li>
                                <li class=""><a href="./ShowProductControl?cid=3">Rice</a></li>
                            </ul>
                        </li>
                        <li><a href="./IntroduceControll">Giới thiệu</a></li>
                        <!-- Show Order Menu Item only if User is Logged In -->
                        <c:if test="${sessionScope.account!=null}">
                            <li><a href="./OrderPlaceControl">Đơn đã đặt</a></li>
                        </c:if>
                        <li><a href="./ContactControll">Liên hệ</a></li>
                    </ul>
                </nav>
            </div>
            <!-- Cart Section -->
            <div class="col-lg-3">
                <div class="header__cart">
                    <ul>
                        <li><a href="./CartControll">
                            <i class="fa fa-shopping-bag"></i>
                            <c:if test="${empty sessionScope.size}"><span>0</span></c:if>
                            <c:if test="${not empty sessionScope.size}"><span>${sessionScope.size}</span></c:if>
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<section class="hero hero-normal">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>Những loại rau quả</span>
                    </div>
                    <ul>
                        <li><a href="#">Rau xanh lá</a></li>
                        <li><a href="#">Quả dâu</a></li>
                        <li><a href="#">Quả lựu</a></li>
                        <li><a href="#">Quả lê</a></li>
                        <li><a href="#">Quả táo</a></li>
                        <li><a href="#">Cà chua</a></li>
                        <li><a href="#">Cà rốt</a></li>
                        <li><a href="#">Bí đỏ</a></li>
                        <li><a href="#">Bơ</a></li>
                        <li><a href="#">Dưa chuột</a></li>
                        <li><a href="#">Cải bắp cải</a></li>
                    </ul>
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
                                Tất cả danh mục <span class="arrow_carrot-down"></span>
                            </div>
                            <!-- Search Input -->
                            <input type="text" placeholder="Bạn cần gì?"
                                   name="query">
                            <!-- Search Button -->
                            <button type="submit" class="site-btn">
                                Tìm kiếm
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
                            <span>Hỗ trợ 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Hero Section End -->