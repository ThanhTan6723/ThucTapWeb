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

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
	<jsp:include page="link/link.jsp"></jsp:include>
    <style>
        .paging a .active{
            color: #00a045;
            font-weight: bold;
        }
    </style>
</head>

<body>
<jsp:include page="header/header.jsp"></jsp:include>
<c:url var="detail" value="DetailControl"></c:url>


<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="img/breadcrumb.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>Organi Shop</h2>
					<div class="breadcrumb__option">
						<a href="./IndexControll">Home</a>
						<span>Shop</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Breadcrumb Section End -->

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
					<div class="sidebar__item">
						<h4>Price</h4>
						<div class="price-range-wrap">
							<div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
								 data-min="10" data-max="540">
								<div class="ui-slider-range ui-corner-all ui-widget-header"></div>
								<span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
								<span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
							</div>
							<div class="range-slider">
								<div class="price-input">
									<input type="text" id="minamount">
									<input type="text" id="maxamount">
								</div>
							</div>
						</div>
					</div>
					<div class="sidebar__item sidebar__item__color--option">
						<h4>Colors</h4>
						<div class="sidebar__item__color sidebar__item__color--white">
							<label for="white">
								White
								<input type="radio" id="white">
							</label>
						</div>
						<div class="sidebar__item__color sidebar__item__color--gray">
							<label for="gray">
								Gray
								<input type="radio" id="gray">
							</label>
						</div>
						<div class="sidebar__item__color sidebar__item__color--red">
							<label for="red">
								Red
								<input type="radio" id="red">
							</label>
						</div>
						<div class="sidebar__item__color sidebar__item__color--black">
							<label for="black">
								Black
								<input type="radio" id="black">
							</label>
						</div>
						<div class="sidebar__item__color sidebar__item__color--blue">
							<label for="blue">
								Blue
								<input type="radio" id="blue">
							</label>
						</div>
						<div class="sidebar__item__color sidebar__item__color--green">
							<label for="green">
								Green
								<input type="radio" id="green">
							</label>
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
			<div class="col-lg-9 col-md-7">
				<div class="product__discount">
					<div class="section-title product__discount__title">
						<h2>Giảm giá</h2>
					</div>
					<div class="row">
						<div class="product__discount__slider owl-carousel">
							<c:forEach var="b" items="${listSale}">
							<div class="col-lg-4">
								<a href="${detail}?pid=${b.id}">
								<div class="product__discount__item">
									<div class="product__discount__item__pic set-bg"
										 data-setbg="${b.image}">
										<div class="product__discount__percent">-20%</div>
									</div>
									<div class="product__discount__item__text">
										<span>Dried Fruit</span>
										<h5><a href="#">${b.name}</a></h5>
										<div class="product__item__price">${b.price} <span>$30.00</span></div>
									</div>
								</div>
								</a>
							</div>
							</c:forEach>

						</div>
					</div>
				</div>
				<div class="sk-page-title">
					<h4 >
						<c:choose>
							<c:when test="${cid==0}">
								All
							</c:when>
							<c:when test="${cid==1}">
								Noodle
							</c:when>
							<c:when test="${cid==2}">
								Chicken
							</c:when>
							<c:when test="${cid==3}">
								Rice
							</c:when>
						</c:choose>
					</h4>
				</div>
				<div class="filter__item">
					<div class="row">
						<div class="col-lg-4 col-md-5">
							<div class="filter__sort">
								<span>Sort By</span>
								<select>
									<option value="0">Default</option>
									<option value="0">Default</option>
								</select>
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
				<div class="paging" style="padding-left: 300px">
					<c:forEach begin="1" end="${endPage}" var="i">
						<button style="padding: 10px 23px; border-radius: 5px; border: none;  font-weight: 700">
							<a href="/ShowProductControl?cid=${cid}&sort=${sort}&index=${i}" style="color: #7fad39;">${i}</a>
						</button>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- Product Section End -->
<jsp:include page="footer/footer.jsp"></jsp:include>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</body>

</html>