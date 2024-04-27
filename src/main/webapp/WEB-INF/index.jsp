<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="zxx">

<head>
    <%@ page isELIgnored="false" %>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ogani | Template</title>
      <!-- Css Styles -->
    <jsp:include page="client/link/link.jsp"></jsp:include>
    <style>
        .container .row .col-lg-6 ul li{
        margin-right: 30px;
    }
    .header__fixed{
        position: fixed;
        top: 0;
        width: 100%;
        height: 140px;
        background-color: #fff; /* Chỉ định màu nền nếu cần */
        z-index: 900;/* Đảm bảo nó nằm trên các phần tử khác */
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.4);
    }
    </style>
</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>

<span class="header__fixed">
	<jsp:include page="client/header/header.jsp"></jsp:include>

</span>
<!-- Breadcrumb Section Begin -->
<div style="height: 140px"></div><br>

<!-- Categories Section Begin -->
<div class="container">
<div class="hero__item set-bg" data-setbg="assets/img/hero/banner.jpg">
    <div class="hero__text">
        <span>TRÁI CÂY TƯƠI</span>
        <h2>Rau quả <br />100% Hữu cơ</h2>
        <p>Có sẵn nhận và giao hàng miễn phí</p>
        <a href="#" class="primary-btn">MUA HÀNG</a>
</div>
    </div>
    <br><br><br>
</div>
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
        <div class="row featured__filter">
        <c:forEach items="${list4Rand}" var="o" >
            <div class="product col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat" style="height: 400px">
                <div class="featured__item">
                    <div class="featured__item__pic set-bg" >
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
                        <c:url var="addToCart" value="/AddToCartControll"></c:url>
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
        <div class="row featured__filter" id="content">
            <c:forEach items="${listOutstandingProduct}" var="o" >
            <div class="product col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                <div class="featured__item">
                    <div class="featured__item__pic set-bg" >
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
                        <c:url var="addToCart" value="/AddToCartControll"></c:url>
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
       <div style="padding-left: 500px;">
           <button onclick="loadMore()" class="btn-btn-primary"
                   style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #a20303; font-weight: 700;
        color:white">Load more</button>
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
<jsp:include page="./client/footer/footer.jsp"></jsp:include>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function loadMore() {
        var amount = document.getElementsByClassName("product").length;
        $.ajax({
            url: "/LoadMoreControl",
            type: "get", //send it through get method
            data: {
                exits: amount
            },
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML += data;
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    }
</script>
</body>

</html>