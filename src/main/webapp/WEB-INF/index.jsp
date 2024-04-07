<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Trang chủ</title>
    <!-- Css Styles -->
    <jsp:include page="client/link/link.jsp"></jsp:include>
    <style>.container .row .col-lg-6 ul li {
        margin-right: 30px;
    }</style>
</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>
<!-- Header Section Begin -->
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
                                    <c:url var="indexAd" value="IndexAdminControll"></c:url>
                                    <c:url var="profile" value="UpdateProfileControll"></c:url>
                                    <c:url var="changepass" value="ChangePassword"></c:url>
                                    <c:url var="logout" value="LogoutControll"></c:url>
                                    <ul>
                                        <i><img src="assets/img/avatar.png" alt="">${sessionScope.account.name}<i
                                                class="fa fa-caret-down"></i></i>

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

                        <li><a href="./IndexControll">Trang chủ</a></li>
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
<section class="hero">
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
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="#">
                            <div class="hero__search__categories">
                                Tất cả danh mục
                                <span class="arrow_carrot-down"></span>
                            </div>
                            <input type="text" placeholder="Bạn cần gì?">
                            <button type="submit" class="site-btn">TÌM KIẾM</button>
                        </form>
                    </div>
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
                <div class="hero__item set-bg" data-setbg="assets/img/hero/banner.jpg">
                    <div class="hero__text">
                        <span>TRÁI CÂY TƯƠI</span>
                        <h2>Rau quả <br/>100% Hữu cơ</h2>
                        <p>Có sẵn nhận và giao hàng miễn phí</p>
                        <a href="#" class="primary-btn">MUA HÀNG</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->

<!-- Categories Section Begin -->
<section class="categories">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <c:forEach var="p" items="${listTop}">
                    <div class="col-lg-3">
                        <div class="categories__item set-bg">
                            <a href="${detail}?pid=${p.id}"><img src="${p.image}"></a>
                            <h5><a href="${detail}?pid=${p.id}">${p.name}</a></h5>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- Categories Section End -->

<!-- Featured Section Begin -->
<section class="featured spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Sản phẩm nổi bật</h2>
                </div>

            </div>
        </div>

        <div class="row featured__filter" id="content">
            <c:forEach items="${listOutstandingProduct}" var="o">
                <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg">
                            <a href="${detail}?pid=${o.id}">
                                <img src="${o.image}" alt="${o.name}">
                            </a>
                        </div>
                        <div class="featured__item__text">
                            <a class="product-name" href="${detail}?pid=${o.id}" style="color: black">
                                    ${o.name}</a>
                            <h5>${o.price}</h5>
                        </div>
                        <div class="text-center">
                            <c:url var="addToCart" value="/AddToCartControl"></c:url>
                            <form action="${addToCart}?pid=${o.id}" method="post" enctype="multipart/form-data">
                                <button
                                        style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; font-weight: 700"
                                        type="submit">
                                    <a href="${detail}?pid=${o.id}" style="color:#ffffff">
                                        MUA NGAY</a>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</section>
<!-- Featured Section End -->

<!-- Banner Begin -->
<div class="banner">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img src="assets/img/banner/banner-1.jpg" alt="">
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img src="assets/img/banner/banner-2.jpg" alt="">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Banner End -->

<!-- Latest Product Section Begin -->
<section class="latest-product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="latest-product__text">
                    <h4>Sản phẩm tươi</h4>
                    <div class="latest-product__slider owl-carousel">
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>

                        </div>
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="latest-product__text">
                    <h4>Sản phẩm sạch</h4>
                    <div class="latest-product__slider owl-carousel">
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>

                        </div>
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="latest-product__text">
                    <h4>Sản phẩm ngon</h4>
                    <div class="latest-product__slider owl-carousel">
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>

                        </div>
                        <div class="latest-prdouct__slider__item">
                            <c:forEach var="b" items="${listRandProduct}">
                                <a href="${detail}?pid=${b.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${b.image}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${b.name}</h6>
                                        <span>${b.price}</span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Latest Product Section End -->

<!-- Blog Section Begin -->
<section class="from-blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title from-blog__title">
                    <h2>From The Blog</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-1.jpg" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 4,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Mẹo chọn hoa quả tươi ngon</a></h5>
                        <p> Chọn hoa quả có màu sắc tươi sáng và đồng đều trên toàn bề mặt.
                            Tránh chọn những loại hoa quả có vết nứt, sưng lên hoặc có dấu hiệu của vi khuẩn.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-2.jpg" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 4,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Mẹo bảo quản hoa quả tươi lâu</a></h5>
                        <p>Một số túi hoa quả được thiết kế để kiểm soát độ ẩm và khí,
                            giúp giữ cho hoa quả tươi lâu hơn. Đặc biệt là các loại túi có thể hấp thụ ethylene. </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-3.jpg" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 8,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Ăn hoa quả đúng cách</a></h5>
                        <p>Trước khi ăn, luôn rửa hoa quả dưới nước sạch để loại bỏ bụi bẩn,
                            vi khuẩn và hóa chất bảo quản nếu có.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Blog Section End -->

<!-- Footer Section Begin -->
<jsp:include page="client/footer/footer.jsp"></jsp:include>
<!-- Footer Section End -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

</body>

</html>