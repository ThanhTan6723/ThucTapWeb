<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>Product detail</title>
<style type="text/css">
    .header__fixed{
        position: fixed;
        top: 0;
        width: 100%;
        height: 140px;
        background-color: #fff;
        z-index: 900;
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.4);
    }
    .product__details__pic__slider__nav {
        position: relative;
    }

        .product__details__pic__slider__nav {
            position: relative;

        }

    .owl-prev,
    .owl-next {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        z-index: 1;
        margin: 0 -30px;
    }

        .owl-next {
            right: 0;
        }

        .review-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .reviews {
            margin-top: 20px;
        }
        .review-item {
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 0;
        }
        .review-item:last-child {
            border-bottom: none;
        }
        .review-item h3 {
            margin: 0;
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        .review-item h3 span {
            background-color: #4caf50;
            color: #fff;
            padding: 2px 5px;
            border-radius: 3px;
            margin-left: 10px;
            font-size: 14px;
        }
        .review-item p {
            margin: 10px 0;
        }
        .review-item .response {
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 5px;
        }
        .review-item .response p {
            margin: 0;
        }
        .review-item .response .response-date {
            font-size: 12px;
            color: #888;
        }

        .review-footer {
            display: flex;
            justify-content: flex-start;
            margin-top: 20px;

        }
        .review-footer button {
            background-color: #0176f3;
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            cursor: pointer;
        }
        .review-footer button:hover {
            background-color: #0056b3;
        }
    </style>
    <%@ page isELIgnored="false" %>
    <jsp:include page="./link/link.jsp"></jsp:include>

</head>

<body>
	<div class="page">

<span class="header__fixed">
	<jsp:include page="header/header.jsp"></jsp:include>
</span>
        <!-- Breadcrumb Section Begin -->
        <div style="height: 140px"></div>
        <!-- Breadcrumb Section Begin -->

        <section class="breadcrumb-section set-bg" data-setbg="assets/img/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Chi tiết sản phẩm</h2>
                            <div class="breadcrumb__option">
                                <a href="./IndexControll">Trang chủ</a>
                                <span>${detail.name} </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Product Details Section Begin -->
        <section class="product-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="product__details__pic">
                            <div class="product__details__pic__item">
                                <img class="product__details__pic__item--large"
                                     src="${detail.image}" alt="" style="width: 400px;height: 400px">
                            </div>
                            <div class="product__details__pic__slider__nav">
                                <div class="owl-prev"><i class="fa fa-angle-left"></i></div>
                                <div class="product__details__pic__slider owl-carousel">
                                    <c:forEach var="o" items="${listImageProduct}">
                                        <div class="product__details__pic__slider__item">
                                            <img data-imgbigurl="img/product/details/product-details-3.jpg" src="${o.url}" alt="">
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="owl-next"><i class="fa fa-angle-right"></i></div>
                            </div>


                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="product__details__text">
                            <h3>${detail.name}</h3>
                            <div class="product__details__rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-half-o"></i>
                                <span>(18 reviews)</span>
                            </div>
                            <div class="product__details__price">${detail.price}</div>
                            <b>Phân loại: </b> ${nameCategory}<br>
                            <b>Mô tả: </b> ${detail.description}<br>
                                     <b>Kho: </b> <span id="batchQuantity">${productCurrentQuantities[detail.id]}</span>
                            <c:url var="addToCart" value="AddToCartControl"></c:url>
                            <br>
                                <form action="${addToCart}?pid=${detail.id}" method="post">
                                   <b>Số lượng:</b> <input style="width: 80px; border-radius: 5px; text-align: center;" type="number" class="single-input-selector" value="1"
                                           min="1" max="${productCurrentQuantities[detail.id]}" name="quantity" placeholder="">
                                    <br><br>
                                    <button style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; text-transform: uppercase; font-weight: 700; color: #fff"
                                            type="submit" class="button" title="<c:out value="Đặt hàng" />">
                                        <span><c:out value="Đặt hàng" /></span>
                                    </button>
                                </form>

                            <ul>
                                <li><b>Share on</b>
                                    <div class="share">
                                        <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-instagram"></i></a>
                                        <a href="#"><i class="fa fa-pinterest"></i></a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                                       aria-selected="true">Nhà cung cấp</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab"
                                       aria-selected="false">Information</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab"
                                       aria-selected="false">Reviews <span>(1)</span></a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <h6>Thông tin về nhà cung cấp</h6>
                                        <c:forEach var="o" items="${listProvider}">
                                        <p>-Tên nhà cung cấp: ${o.name}</p>
                                        <p>Địa chỉ: ${o.address}</p>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="tab-pane" id="tabs-2" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <h6>Products Infomation</h6>
                                        <p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                            Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                            Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam
                                            sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo
                                            eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.
                                            Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Praesent
                                            sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac
                                            diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante
                                            ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
                                            Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
                                            Proin eget tortor risus.</p>
                                        <p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                            ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                            elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                            porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                            nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</p>
                                    </div>
                                </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <div class="review-container">
                                        <div class="reviews">
                                            <div class="review-item">
                                                <h4>Đánh giá sản phẩm</h4>
                                                <br>
                                                <c:forEach items="${listReviews}" var="r">
                                                    <h3>${r.accountCreated.name}<span>Đã mua tại Golden Fields</span></h3>
                                                    <p>${r.comment}</p>
                                                    <div class="line" style="border-bottom: 1px solid #e0e0e0;
                                                    margin: 15px 0;"></div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="review-footer">
                                            <button style="margin-right: 20px;background-color: white;border: 1px solid gray; color: black">Xem đánh giá</button>
                                            <button>Viết đánh giá</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </section>
        <!-- Product Details Section End -->

        <!-- Related Product Section Begin -->
        <section class="related-product">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title related__product__title">
                            <h2>Sản phẩm liên quan</h2>
                        </div>
                    </div>
                </div>
                <section class="categories">
                    <div class="container">
                        <div class="row">
                            <div class="categories__slider owl-carousel">
                                <c:forEach var="p" items="${relativeProduct}">
                                    <div class="col-lg-3">
                                        <div class="categories__item set-bg">
                                            <a href="./DetailControl?pid=${p.id}"><img src="${p.image}"></a>
                                            <h5><a href="./DetailControl?pid=${p.id}">${p.name}</a></h5>
                                        </div>
                                    </div>

                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </section>
        <!-- Related Product Section End -->
		<jsp:include page="footer/footer.jsp"></jsp:include>
	</div>
<script>
    $(document).ready(function () {
        $(".product__details__pic__slider").owlCarousel({
            items: 1,
            nav: false,
            dots: false,
            loop: true,
            autoplay: true,
            autoplayTimeout: 5000,
            autoplayHoverPause: true,
        });
        $(".owl-prev").click(function () {
            $(".product__details__pic__slider").trigger("prev.owl.carousel");
        });
        $(".owl-next").click(function () {
            $(".product__details__pic__slider").trigger("next.owl.carousel");
        });
    });
        // Chứa số lượng của các batch
        var batchQuantities = {};


    document.addEventListener('DOMContentLoaded', () => {
        const stars = document.querySelectorAll('.star');
        let selectedRating = 0;

        stars.forEach((star, index) => {
            star.addEventListener('click', () => {
                const starValue = index + 1;
                if (selectedRating >= starValue) {
                    selectedRating = starValue - 1; // Bỏ màu nếu nhấn vào ngôi sao hoặc ngôi sao trước nó
                } else {
                    selectedRating = starValue; // Chọn sao mới
                }
                updateStars(selectedRating);
            });
        });

        function updateStars(rating) {
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('selected');
                } else {
                    star.classList.remove('selected');
                }
            });
        }

        document.getElementById('submit-review').addEventListener('click', () => {
            const comment = document.getElementById('comment').value;
            if (selectedRating && comment) {
                const reviewContainer = document.getElementById('reviews');
                const newReview = document.createElement('div');
                newReview.classList.add('review');
                newReview.innerHTML = `
                <p><strong>Rating:</strong> ${'★'.repeat(selectedRating)}</p>
                <p>${comment}</p>
            `;
                reviewContainer.prepend(newReview);
                document.getElementById('comment').value = '';
                updateStars(0); // Reset sao sau khi gửi đánh giá
                selectedRating = 0;
            } else {
                alert('Vui lòng chọn số sao và viết bình luận.');
            }
        });
    });

        function updateQuantity() {
        var batchSelect = document.getElementById("batchSelect");
        var selectedBatchId = batchSelect.value;
        var quantity = batchQuantities[selectedBatchId] || 0;
        document.getElementById("batchQuantity").textContent = quantity;
    }

        window.onload = function() {
        var batches = document.querySelectorAll('#batchSelect option');
        batches.forEach(function(batch) {
        var batchId = batch.value;
        var quantity = batch.getAttribute('data-quantity');
        batchQuantities[batchId] = quantity;
    });
        // Gọi hàm để cập nhật số lượng khi trang tải lần đầu
        updateQuantity();
    }

    </script>
    <script src="assets/js/jquery-3.3.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.nice-select.min.js"></script>
    <script src="assets/js/jquery-ui.min.js"></script>
    <script src="assets/js/jquery.slicknav.js"></script>
    <script src="assets/js/mixitup.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>