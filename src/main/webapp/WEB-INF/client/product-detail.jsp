<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Product detail</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style type="text/css">
        .header__fixed {
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

        .hidden {
            display: none;
        }

        .review-statistics {
            margin-bottom: 20px;
        }

        .review-statistics h4 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .stars {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .stars .rating-row {
            display: flex;
            align-items: center;
            font-size: 16px;
        }

        .stars .rating-row span {
            width: 30px;
            text-align: center;
        }

        .stars .rating-row .bar {
            flex-grow: 0.5;
            height: 10px;
            background-color: #e0e0e0;
            margin: 0 10px;
            border-radius: 5px;
            position: relative;
        }

        .stars .rating-row .bar .fill {
            height: 100%;
            background-color: #ffa600;
            border-radius: 5px;
        }

        .stars .rating-row .percentage {
            width: 50px;
            text-align: right;
        }

        .star-icon {
            color: #ffa600;
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
            background-color: #ffa600;
            color: #fff;
            padding: 2px 5px;
            border-radius: 3px;
            margin-left: 10px;
            font-size: 14px;
        }

        .review-item p {
            margin: 10px 0;
            /*border-bottom: 1px solid #d9d9d9;*/
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
            background-color: #456bbd;
            color: whitesmoke;
            margin-right: 20px;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            cursor: pointer;
        }

        .review-footer button:hover {
            background-color: #4573d3;
        }

        .review-form {
            display: none;
            margin-top: 20px;
        }

        .star {
            cursor: pointer;
            font-size: 2em;
            color: gray;
            margin: 0 6px;
            border-radius: 30px;
        }


        .star.selected {
            color: #ffa600;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 3% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-content form {
            display: flex;
            flex-direction: column;
        }

        .modal-content form label {
            margin-top: 10px;
        }

        .modal-content form textarea {
            width: 100%;
            border-radius: 10px;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
        }

        .modal-content form button {
            align-self: flex-end;
            margin-top: 20px;
            background-color: #7fad39;
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            cursor: pointer;
        }

        .modal-content form button:hover {
            background-color: #8fbe41;
        }

        /* CSS cho hình ảnh xem trước */
        #image-preview {
            margin-top: 10px;
        }

        /* Đảm bảo ô nhập "Tên" và "Số điện thoại" nằm trên cùng một hàng và cách nhau ra */
        #reviewModal form .form-row {
            display: flex;
            justify-content: space-between; /* Cách nhau ra */
            align-items: center;
            /*margin-bottom: 5px;*/
        }

        #reviewModal form .form-group {
            flex: 0 0 calc(48% - 5px); /* Độ rộng của mỗi ô */
        }

        #reviewModal form .form-group label {
            display: block;
            /*margin-bottom: 5px;*/
        }

        #reviewModal form .form-group input[type="text"],
        #reviewModal form .form-group input[type="tel"] {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .preview-image {
            max-width: 50px; /* Kích thước mặc định */
            height: 50px;
            margin-right: 10px;
            margin-bottom: 10px;
        }
    </style>
    <jsp:include page="./link/link.jsp"></jsp:include>
</head>

<body>
<div class="page">
    <span class="header__fixed">
        <jsp:include page="header/header.jsp"></jsp:include>
    </span>
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
    <div class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__pic">
                        <div class="product__details__pic__item">
                            <img class="product__details__pic__item--large" src="${detail.image}" alt="">
                        </div>
                        <div class="product__details__pic__slider__nav">
                            <div class="owl-prev"><i class="fa fa-angle-left"></i></div>
                            <div class="product__details__pic__slider owl-carousel">
                                <c:forEach var="o" items="${listImageProduct}">
                                    <div class="product__details__pic__slider__item">
                                        <img data-imgbigurl="img/product/details/product-details-3.jpg" src="${o.url}"
                                             alt="">
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
                            <c:if test="${not empty reviews}"> <span>(${allreviews} Đánh giá)</span></c:if>
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
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Mô tả</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Thông tin sản phẩm</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">Đánh giá</a>
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
                                    <h6>Thông tin sản phẩm</h6>
                                    <p>Thông tin sản phẩm tại đây.</p>
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <div class="review-container">
                                        <div class="reviews">
                                            <h4><b>Đánh giá cho sản phẩm ${detail.name}</b></h4>
                                            <br>
                                            <c:if test="${empty reviews}"><h5 style="color: gray">Chưa có đánh giá nào cho sản phẩm này</h5></c:if>
                                            <c:if test="${not empty reviews}">
                                                <!-- Review Statistics Section -->
                                                <div class="review-statistics">
                                                    <h5><b>${averageRating} <i class="fa fa-star star-icon"></i> ${allreviews} Đánh giá</b></h5>
                                                    <div class="stars">
                                                        <c:forEach var="entry" items="${ratingPercentage}">
                                                            <c:set var="i" value="${entry.key}"/>
                                                            <div class="rating-row">
                                                                <span>${i} <i class="fa fa-star star-icon"></i></span>
                                                                <div class="bar">
                                                                    <div class="fill" style="width: ${entry.value}%;"></div>
                                                                </div>
                                                                <span class="percentage">${entry.value}%</span>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <!-- End of Review Statistics Section -->

                                            <c:forEach var="review" items="${reviews}" varStatus="loop">
                                                <div class="review-item ${loop.index > 1 ? 'hidden' : ''}">
                                                    <h3><b>${review.nameCommenter}</b>
                                                        <c:forEach var="i" begin="1" end="${review.rating}">
                                                            <i class="fa fa-star star selected"></i>
                                                        </c:forEach>
                                                        <c:forEach var="i" begin="${review.rating + 1}" end="5">
                                                            <i class="fa fa-star star"></i>
                                                        </c:forEach>
                                                    </h3>
                                                    <br>
                                                    <img style="width: 100px;height: 100px;border-radius: 6px" src="${review.image}">
                                                    <h3>${review.comment}</h3>
                                                    <p>Đã đánh giá vào ngày ${review.dateCreated}</p>
                                                    <c:if test="${not empty review.response}">
                                                        <div class="response">
                                                            <p>${review.response}</p>
                                                            <p class="response-date">Response Date</p>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="review-footer">
                                            <c:if test="${not empty reviews}">
                                                <button id="showAllReviewsBtn">Xem tất cả ${allreviews} đánh giá</button>
                                            </c:if>
                                            <button id="writeReviewBtn">Viết đánh giá</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="reviewModal" class="modal">
                        <div class="modal-content">
                            <span class="close">&times;</span>
                            <h2>Viết đánh giá của bạn</h2>
                            <form action="ReviewControll" method="post" enctype="multipart/form-data">
                                <input type="hidden" id="id" name="id" value="${detail.id}">
                                <label for="rating">Đánh giá</label>
                                <div id="rating" style="text-align: center;">
                                    <i class="fa fa-star star" data-value="1"></i>
                                    <i class="fa fa-star star" data-value="2"></i>
                                    <i class="fa fa-star star" data-value="3"></i>
                                    <i class="fa fa-star star" data-value="4"></i>
                                    <i class="fa fa-star star" data-value="5"></i>
                                </div>
                                <input type="hidden" id="ratingInput" name="rating" value="0">
                                <label for="comment">Bình luận</label>
                                <textarea id="comment" name="comments" rows="6"
                                          placeholder="Mời bạn chia sẻ cảm nhận..." required></textarea>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="name">Họ tên (bắt buộc)</label>
                                        <input type="text" id="name" name="name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Số điện thoại (bắt buộc)</label>
                                        <input type="tel" id="phone" name="phone" required>
                                    </div>
                                </div>
                                <label for="images">Gửi ảnh thực tế</label>
                                <span id="image-preview"></span>
                                <input type="file" id="images" name="images" accept="image/*" multiple>
                                <button type="submit">Gửi</button>
                            </form>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="footer/footer.jsp"></jsp:include>
</div>
<script src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/jquery-ui.min.js"></script>
<script src="assets/js/jquery.slicknav.js"></script>
<script src="assets/js/mixitup.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>
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

    var batchQuantities = {};

    function updateQuantity() {
        var batchSelect = document.getElementById("batchSelect");
        var selectedBatchId = batchSelect.value;
        var quantity = batchQuantities[selectedBatchId] || 0;
        document.getElementById("batchQuantity").textContent = quantity;
    }

    window.onload = function () {
        var batches = document.querySelectorAll('#batchSelect option');
        batches.forEach(function (batch) {
            var batchId = batch.value;
            var quantity = batch.getAttribute('data-quantity');
            batchQuantities[batchId] = quantity;
        });
        updateQuantity();
    }

    document.addEventListener('DOMContentLoaded', (event) => {
        const modal = document.getElementById("reviewModal");
        const btn = document.getElementById("writeReviewBtn");
        const span = document.getElementsByClassName("close")[0];

        btn.onclick = function () {
            modal.style.display = "block";
        }

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }


        const stars = document.querySelectorAll('.star');
        const ratingInput = document.getElementById('ratingInput');

        stars.forEach(star => {
            star.addEventListener('click', (e) => {
                const rating = e.target.getAttribute('data-value');
                ratingInput.value = rating;

                stars.forEach(star => {
                    if (star.getAttribute('data-value') <= rating) {
                        star.classList.add('selected');
                    } else {
                        star.classList.remove('selected');
                    }
                });
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        const imagesInput = document.getElementById('images');
        const imagePreview = document.getElementById('image-preview');

        // Xử lý sự kiện khi người dùng chọn ảnh
        imagesInput.addEventListener('change', function () {
            // Xóa các hình ảnh hiện có trước đó
            imagePreview.innerHTML = '';

            // Lặp qua các tệp đã chọn
            for (let i = 0; i < imagesInput.files.length; i++) {
                const file = imagesInput.files[i];
                const reader = new FileReader();

                // Đọc tệp và hiển thị hình ảnh
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.alt = file.name;
                    img.classList.add('preview-image');
                    imagePreview.appendChild(img);
                }

                // Đọc tệp ảnh dưới dạng URL
                reader.readAsDataURL(file);
            }
        });
    });
    document.addEventListener('DOMContentLoaded', function () {
        const showAllReviewsBtn = document.getElementById('showAllReviewsBtn');
        const reviewItems = document.querySelectorAll('.review-item');

        showAllReviewsBtn.addEventListener('click', function () {
            // Hiển thị tất cả các đánh giá
            reviewItems.forEach(function (item) {
                item.classList.remove('hidden');
            });
            // Ẩn nút "Xem tất cả đánh giá" sau khi đã hiển thị tất cả
            showAllReviewsBtn.style.display = 'none';
        });
    });
</script>
</body>
</html>