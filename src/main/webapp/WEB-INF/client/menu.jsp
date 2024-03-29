<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.util.Map" %>
<%@page import="dao.client.I18NDAO" %>

<c:set var="showLanguage" value="<%= new dao.client.I18NDAO().vietnameseLanguage() %>" />
<c:if test="${not empty sessionScope.lang}">
    <c:choose>
        <c:when test="${sessionScope.lang eq 'Vietnamese'}">
            <c:set var="showLanguage" value="<%= new dao.client.I18NDAO().vietnameseLanguage() %>" />
        </c:when>
        <c:when test="${sessionScope.lang eq 'English'}">
            <c:set var="showLanguage" value="<%= new dao.client.I18NDAO().englishLanguage() %>" />
        </c:when>
    </c:choose>
</c:if>
<c:set var="showLanguage" scope="page" value="${showLanguage}" />


<!DOCTYPE html>
<html lang="zxx">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Menu</title>

<jsp:include page="./link/link.jsp"></jsp:include>
<style type="text/css">
.list {
	display: grid;
	grid-template-columns: 300px 300px 300px;
	column-gap: 20px;
}

.item .img img {
	height: 180px;
	transition: 0.5s;
}

.item .img {
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 20px;
}

.item .content {
	border-radius: 30px;
	padding: 30px 30px;
}

.item:hover img {
	transform: translate(0, -50px);
}

.listPage li {
	background-color: #7fad39;
	padding: 20px;
	display: inline-block;
	margin: 0 10px;
	cursor: pointer;
}

.listPage .active {
	background-color: #7fad39;
	color: #fff;
}

.listPage {
	padding: 10px;
	text-align: center;
	list-style: none;
}

.listPage li {
	background-color: #ffffffBD;
	padding: 20px;
	display: inline-block;
	margin: 0 10px;
	cursor: pointer;
}

.title, .price {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}

.title a {
	text-decoration: none;
}
</style>
</head>

<body>
	<jsp:include page="./header/header.jsp"></jsp:include>

	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-5">
					<div class="sidebar">

						<div class="sidebar__item sidebar__item__color--option">
							<h4>Colors</h4>
							<div class="sidebar__item__color sidebar__item__color--white">
								<label for="white"> White <input type="radio" id="white">
								</label>
							</div>
							<div class="sidebar__item__color sidebar__item__color--gray">
								<label for="gray"> Gray <input type="radio" id="gray">
								</label>
							</div>
							<div class="sidebar__item__color sidebar__item__color--red">
								<label for="red"> Red <input type="radio" id="red">
								</label>
							</div>
							<div class="sidebar__item__color sidebar__item__color--black">
								<label for="black"> Black <input type="radio" id="black">
								</label>
							</div>
							<div class="sidebar__item__color sidebar__item__color--blue">
								<label for="blue"> Blue <input type="radio" id="blue">
								</label>
							</div>
							<div class="sidebar__item__color sidebar__item__color--green">
								<label for="green"> Green <input type="radio" id="green">
								</label>
							</div>
						</div>
						<div class="sidebar__item">
							<h4>Popular Size</h4>
							<div class="sidebar__item__size">
								<label for="large"> Large <input type="radio" id="large">
								</label>
							</div>
							<div class="sidebar__item__size">
								<label for="medium"> Medium <input type="radio"
									id="medium">
								</label>
							</div>
							<div class="sidebar__item__size">
								<label for="small"> Small <input type="radio" id="small">
								</label>
							</div>
							<div class="sidebar__item__size">
								<label for="tiny"> Tiny <input type="radio" id="tiny">
								</label>
							</div>
						</div>

					</div>
				</div>
				<div class="col-lg-9 col-md-7">

					<div class="sk-page-title">
						<h4 style="font-weight: 700px;color: ">
						<c:choose>
						    <c:when test="${cid==0}">
						        ${showLanguage["Product.All"]}
						    </c:when>
						    <c:when test="${cid==1}">
						        ${showLanguage["Product.Noodle"]}
						    </c:when>
						    <c:when test="${cid==2}">
						        ${showLanguage["Product.Chicken"]}
						    </c:when>
						    <c:when test="${cid==3}">
						        ${showLanguage["Product.Rice"]}
						    </c:when>
						</c:choose>
						</h4>
					</div>
					<div class="product-nav-wrap">
						<div class="col-md-6 col-sm-6 sort-wrap no-padding-left"></div>
						<div class="col-md-6 col-sm-6 filter-wrap no-padding-right">
							<div class="filter-inner">
								<div id="sort-by">
									<c:url var="showProduct" value="ShowProductControl"></c:url>

									<form class="form-inline form-viewpro" action="${showProduct}"
										method="get">
										<div class="form-group">
											<input type="hidden" name="cid" value="${cid}"> <input
												type="hidden" name="search" value="${search}"> <select
												class="sort-by-script" name="sort" id="selectFilter"
												onchange="this.form.submit()">
										    <option value="id-asc" <c:if test="${sort==null}">selected</c:if>>
										        ${showLanguage["Product.Sort"]}
										    </option>
										    <option value="price-asc" <c:if test="${sort=='price-asc'}">selected</c:if>>
										        ${showLanguage["Product.Sort1"]}
										    </option>
										    <option value="price-desc" <c:if test="${sort=='price-desc'}">selected</c:if>>
										        ${showLanguage["Product.Sort2"]}
										    </option>
										    <option value="name-asc" <c:if test="${sort=='name-asc'}">selected</c:if>>
										        ${showLanguage["Product.Sort3"]}
										    </option>
										    <option value="name-desc" <c:if test="${sort=='name-desc'}">selected</c:if>>
										        ${showLanguage["Product.Sort4"]}
										    </option>
											</select>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>

					<!-- Featured Section Begin -->
					<section class="featured spad">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="section-title">
										<h2>Danh sách sản phẩm</h2>
									</div>
								</div>
							</div>
							<div class="row featured__filter">
								<c:choose>
									<c:when test="${not empty requestScope.message1}">
										<div class="message" >${requestScope.message1}</div>
									</c:when>

									<c:when test="${not empty requestScope.message}">
										<div class="message">${requestScope.message}</div>
									</c:when>
									<c:otherwise>
										<div class="container">
											<div class="row">
												<c:forEach items="${listProducts}" var="o">
													<c:url var="detail" value="DetailControl"></c:url>
													<div
														class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">

														<div class="list">
															<div class="item">
																<div class="img">
																	<a class="sellingProducts-image"
																		href="${detail}?pid=${o.id}"> <img width="150px" height="60px"
																		src="${o.image}" alt="No image" class="img-responsive">
																	</a>
																</div>
																<div class="content">
																	<div class="featured__item__text">
																		<h6>
																			<a href="${detail}?pid=${o.id}">${o.name}</a>
																		</h6>
																	</div>

																	<div class="price">${o.price}</div>
																	<div class="text-center">
																		<c:url var="addToCart" value="AddToCartControll"></c:url>
																		<form action="${addToCart}?pid=${o.id}" method="post"
																			class="variants" id="product-actions-3915726"
																			enctype="multipart/form-data">
																			<button
																				style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; text-transform: uppercase; font-weight: 700; color: #fff"
																				type="submit" class="button" type="submit">
																				<a href="${addToCart}?pid=${o.id}"></a> <span>Add
																					To Cart</span>
																			</button>
																		</form>

																	</div>
																</div>


															</div>
														</div>
													</div>
												</c:forEach>
											</div>
											<ul class="listPage">
											</ul>
										</div>
									</c:otherwise>

								</c:choose>
							</div>
						</div>

					</section>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer Section End -->

	<!-- Js Plugins -->
	<script>
	    let thisPage = 1;
	    let limit = 8;
	    let list = document.querySelectorAll('.list .item');

	    function loadItem(){
	        let beginGet = limit * (thisPage - 1);
	        let endGet = limit * thisPage - 1;
	        list.forEach((featured__item, key)=>{
	            if(key >= beginGet && key <= endGet){
	            	featured__item.style.display = 'block';
	            }else{
	                featured__item.style.display = 'none';
	            }
	        })
	        listPage();
	    }
	    loadItem();
	    function listPage(){
	        let count = Math.ceil(list.length / limit);
	        document.querySelector('.listPage').innerHTML = '';

	        if(thisPage != 1){
	            let prev = document.createElement('li');
	            prev.innerText = 'PREV';
	            prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
	            document.querySelector('.listPage').appendChild(prev);
	        }

	        for(i = 1; i <= count; i++){
	            let newPage = document.createElement('li');
	            newPage.innerText = i;
	            if(i == thisPage){
	                newPage.classList.add('active');
	            }
	            newPage.setAttribute('onclick', "changePage(" + i + ")");
	            document.querySelector('.listPage').appendChild(newPage);
	        }

	        if(thisPage != count){
	            let next = document.createElement('li');
	            next.innerText = 'NEXT';
	            next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
	            document.querySelector('.listPage').appendChild(next);
	        }
	    }
	    function changePage(i){
	        thisPage = i;
	        loadItem();
	    }
	    </script>

	<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>

</html>
