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
	<title>Golden Fields</title>

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
	<jsp:include page="link/link.jsp"></jsp:include>
	<style>
		.paging a .active{
			color: #00a045;
			font-weight: bold;
		}
		.header__fixed{
			position: fixed;
			top: 0;
			width: 100%;
			/*height: 140px;*/
			background-color: #fff;
			z-index: 900;
			/*box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.4);*/
		}
		.page-btn {
			padding: 10px 23px;
			border-radius: 5px;
			border: none;
			background-color: #c2c4c5;
			color: black;
			font-weight: 700;
		}

		.page-btn.active {
			background-color: #7fad39;
			color: white;
		}
		.product-carousel {
			display: flex;
			overflow-x: hidden;
		}

		.product-carousel .product__discount__item {
			flex: 0 0 auto;
			margin-right: 10px; /* Điều chỉnh khoảng cách giữa các sản phẩm */
			width: calc(25% - 10px); /* 4 sản phẩm trên mỗi hàng */
		}

		.prev, .next {
			cursor: pointer;
			position: absolute;
			top: 50%;
			transform: translateY(-50%);
			background-color: #f1f1f1;
			color: #000;
			padding: 10px;
			border: none;
			outline: none;
			z-index: 1;
		}

		.product-carousel-container {
			display: flex;
			align-items: center;
			position: relative;
		}

		.product-carousel {
			display: flex;
			overflow-x: hidden;
			scroll-behavior: smooth;
			flex-grow: 1;
		}
		.product-carousel .product__discount__item {
			flex: 0 0 auto;
			margin-right: 10px; /* Điều chỉnh khoảng cách giữa các sản phẩm */
			width: calc(25% - 10px); /* 4 sản phẩm trên mỗi hàng */
		}

		.prev, .next {
			cursor: pointer;
			background-color: rgb(212, 213, 215);
			color: #000;
			padding: 10px;
			border: none;
			outline: none;
			position: absolute;
			top: 40%;
			transform: translateY(-50%);
			z-index: 1;
		}

		.prev {
			left: -38px;
		}

		.next {
			right: -25px;
		}



	</style>
</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>

<span class="header__fixed">
	<jsp:include page="header/header.jsp"></jsp:include>
</span>
<<<<<<< HEAD
=======
<!-- Breadcrumb Section Begin -->
<div style="height: 140px"></div>
<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="assets/img/breadcrumb.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Sản phẩm</h2>
					<div class="breadcrumb__option">
						<a href="./IndexControll">Trang chủ</a>
						<span>Sản phẩm </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Breadcrumb Section End -->

>>>>>>> 6ff298deeaef2af48903f2737f7c49c7fe51d41d
<!-- Product Section Begin -->
<section class="product spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-3 col-md-5">
				<div class="sidebar">
					<div class="sidebar__item">
						<h4>Những loại rau quả</h4>
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
							<li><a href="#">Cải bắp cải</a></li>
						</ul>
					</div>
					<div class="sidebar__item sidebar__item__color--option">
						<h5><b>LỌC SẢN PHẨM</b></h5>
						<div id="filter" class="filter-container">
							<form action="./ShowProductControl" method="post" >
								<fieldset style="border: 2px solid #82ae46;">
									<legend style="width:150px; font-size: 18px;">Danh mục</legend>
									<label style="display: block; margin-bottom: 10px; margin-left: 10px">
										<input type="radio" class="price_sortFilter" name="category" value="1"> Mục 1
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="price_sortFilter" name="category" value="2"> Mục 2
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="price_sortFilter" name="category" value="3"> Mục 3
									</label>
								</fieldset>

								<fieldset style="border: 2px solid #82ae46;">
									<legend style="width: 150px; font-size: 18px;">Khoảng giá</legend>
									<div style="display: flex;">
										<label style="display: block; margin-bottom: 10px;margin-left: 10px">
											<input type="number" class="price_fromFilter" name="price_from" placeholder="Từ" style="width: 100px;">
										</label>
										<label style="display: block; margin-bottom: 10px; margin-right: 10px;margin-left: 10px">
											<input type="number" class="price_toFilter" name="price_to" placeholder="Đến" style="width: 100px;">
										</label>
									</div>
								</fieldset>
								<fieldset style="border: 2px solid #82ae46;">
									<legend style="width: 150px; font-size: 18px;">Địa chỉ</legend>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="name_sortAscFilter" name="provider" value="1"> Thành phố HCM
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="name_sortDescFilter" name="provider" value="2"> Đà Nẵng
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="name_sortDescFilter" name="provider" value="3"> Hà Nội
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="name_sortDescFilter" name="provider" value="4"> Nghệ An
									</label>
								</fieldset>
								<input style="margin-top: 5px" type="submit" value="Lọc">
							</form>
						</div>
					</div>
					<div class="sidebar__item">
						<h4>Popular Size</h4>
						<div class="sidebar__item__size">
							<label for="large">
								Large
								<input type="radio" id="large">
							</label>
						</div>
						<div class="sidebar__item__size">
							<label for="medium">
								Medium
								<input type="radio" id="medium">
							</label>
						</div>
						<div class="sidebar__item__size">
							<label for="small">
								Small
								<input type="radio" id="small">
							</label>
						</div>
						<div class="sidebar__item__size">
							<label for="tiny">
								Tiny
								<input type="radio" id="tiny">
							</label>
						</div>
					</div>

					<div class="sidebar__item">

					<div class="latest-product__text">
							<h4>Latest Products</h4>
							<div class="latest-product__slider owl-carousel">

							</div>
						</div>
					</div>
				</div>

		</div>
			<div class="col-lg-9 col-md-7">
				<div class="product__discount">
					<div class="section-title product__discount__title">
						<h2>Giảm giá</h2>
					</div>
                    <div class="row">
                        <div class="product-carousel-container">
                            <button class="prev" onclick="scrollCarousel(-1)">&#10094;</button>
                            <div class="product-carousel">
                                <c:forEach var="b" items="${listSale}">
                                    <div class="product__discount__item">
                                        <div class="product__discount__item__pic set-bg" data-setbg="${b.image}">
                                            <div class="product__discount__percent">-20%</div>
                                        </div>
                                        <div class="product__discount__item__text">
                                            <span>Dried Fruit</span>
                                            <h5><a href="${detail}?pid=${b.id}">${b.name}</a></h5>
                                            <div class="product__item__price">${b.price} <span>$30.00</span></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <button class="next" onclick="scrollCarousel(1)">&#10095;</button>
                        </div>
                    </div>
                </div>
				<div class="filter__item">
					<div class="row">
						<div class="col-lg-4 col-md-5">
							<div class="filter__sort">
								<c:url var="showProduct" value="/ShowProductControl"></c:url>

								<form class="form-inline form-viewpro" id="productForm" method="get">
									<input type="hidden" name="cid" value="${cid}">

									<span>Sort By</span>

									<select class="sort-by-script" name="sort" id="selectFilter" onchange="submitForm()">
										<option value="id-asc" <c:if test="${sort=='id-asc'}">selected</c:if>>Mặc định</option>
										<option value="price-asc" <c:if test="${sort=='price-asc'}">selected</c:if>>Giá tăng dần</option>
										<option value="price-desc" <c:if test="${sort=='price-desc'}">selected</c:if>>Giá giảm dần</option>
										<option value="name-asc" <c:if test="${sort=='name-asc'}">selected</c:if>>A-Z</option>
										<option value="name-desc" <c:if test="${sort=='name-desc'}">selected</c:if>>Z-A</option>
									</select>
								</form>

								<script>
									function submitForm() {
										var form = document.getElementById("productForm");
										form.action = "${showProduct}?cid=" + form.elements["cid"].value;
										form.submit();
									}
								</script>
							</div>
						</div>
						<div class="col-lg-4 col-md-4">
							<div class="filter__found">
								<h6><span></span> Products found</h6>
							</div>
						</div>
						<div class="col-lg-4 col-md-3">
							<div class="filter__option">
								<span class="icon_grid-2x2"></span>
								<span class="icon_ul"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row" id="content">
					<c:forEach items="${listProducts}" var="o">
						<div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
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
				<div class="paging" style="padding-left: 300px">
					<c:forEach begin="1" end="${endPage}" var="i">
						<button class="page-btn ${i == 1 ? 'active' : ''}" onclick="loadPage(${i})">
							<span>${i}</span>
						</button>
					</c:forEach>
				</div>


			</div>
		</div>
	</div>
</section>
<!-- Product Section End -->
<jsp:include page="footer/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
	function loadPage(page) {
		var cid = '${param.cid}';
		var sort = '${param.sort}';
		var category = $('#category').val(); // Lấy giá trị của thẻ select category
		var priceSort = $('#price_sort').val(); // Lấy giá trị của thẻ select price_sort
		var nameSort = $('#name_sort').val(); // Lấy giá trị của thẻ select name_sort
		var priceFrom = $('#price_from').val(); // Lấy giá trị của thẻ input price_from
		var priceTo = $('#price_to').val(); // Lấy giá trị của thẻ input price_to
		var provider = $('#provider').val(); // Lấy giá trị của thẻ select provider

		$.ajax({
			url: 'ShowProductControl?page=' + page,
			type: 'GET',
			data: {
				cid: cid,
				sort: sort,
				category: category,
				price_sort: priceSort,
				name_sort: nameSort,
				price_from: priceFrom,
				price_to: priceTo,
				provider: provider
			},
			success: function(response) {
				$('#content').html(response);
			},
			error: function(xhr, status, error) {
				console.error(xhr.responseText);
			}
		});
	}

</script>


<script>
	document.addEventListener('DOMContentLoaded', function() {
		var buttons = document.querySelectorAll('.page-btn');
		buttons.forEach(function(button) {
			button.addEventListener('click', function() {
				buttons.forEach(function(btn) {
					btn.classList.remove('active');
				});
				this.classList.add('active');
			});
		});
	});

</script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		// Lấy tất cả các fieldset
		const fieldsets = document.querySelectorAll('fieldset');

		// Lấy nút Lọc
		const filterButton = document.querySelector('input[type="submit"]');

		// Lắng nghe sự kiện khi người dùng thay đổi trạng thái của các input radio và number
		fieldsets.forEach(fieldset => {
			const inputs = fieldset.querySelectorAll('input[type="radio"], input[type="number"]');
			inputs.forEach(input => {
				input.addEventListener('change', checkFields);
			});
		});

		// Hàm kiểm tra các trường đã được chọn đủ chưa
		function checkFields() {
			let anyFieldSelected = false;
			fieldsets.forEach(fieldset => {
				const radioInputs = fieldset.querySelectorAll('input[type="radio"]:checked');
				const numberInputs = fieldset.querySelectorAll('input[type="number"]');
				if (fieldset.querySelector('.price_fromFilter') && fieldset.querySelector('.price_toFilter')) {
					const priceFrom = parseFloat(fieldset.querySelector('.price_fromFilter').value);
					const priceTo = parseFloat(fieldset.querySelector('.price_toFilter').value);
					if (!isNaN(priceFrom) && !isNaN(priceTo) && priceFrom < priceTo) {
						anyFieldSelected = true;
					}
				}
				if (radioInputs.length > 0 || Array.from(numberInputs).some(input => input.value !== '')) {
					anyFieldSelected = true;
				}
			});
			// Kích hoạt nút Lọc nếu có bất kỳ trường nào được chọn
			filterButton.disabled = !anyFieldSelected;
		}

		// Ban đầu, kiểm tra trạng thái mặc định
		checkFields();
	});
</script>

<script>
    function scrollCarousel(direction) {
        const carousel = document.querySelector('.product-carousel');
        const itemWidth = carousel.querySelector('.product__discount__item').clientWidth + 10; // Bao gồm cả margin-right

        if (direction === 1) {
            // Cuộn sang phải
            if (carousel.scrollLeft + carousel.clientWidth >= carousel.scrollWidth) {
                // Nếu đang ở cuối, cuộn lại đầu
                carousel.scrollTo({ left: 0, behavior: 'smooth' });
            } else {
                carousel.scrollBy({ left: itemWidth, behavior: 'smooth' });
            }
        } else {
            // Cuộn sang trái
            if (carousel.scrollLeft === 0) {
                // Nếu đang ở đầu, cuộn đến cuối
                carousel.scrollTo({ left: carousel.scrollWidth, behavior: 'smooth' });
            } else {
                carousel.scrollBy({ left: -itemWidth, behavior: 'smooth' });
            }
        }
    }
</script>
<!-- Js Plugins -->
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