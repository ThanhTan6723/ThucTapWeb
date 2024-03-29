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
<title>Cart</title>
<jsp:include page="./link/link.jsp"></jsp:include>

</head>

<body>
	<jsp:include page="./header/header.jsp"></jsp:include>


	<!-- Shoping Cart Section Begin -->

	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<c:if test="${empty sessionScope.cart}">
							<div class="img" style="text-align: center; line-height: 50vh;">
								<img alt="" src="client/assets/img/empty-cart.svg"
									style="vertical-align: middle;">
								<h3>
									<b><c:out value="${showLanguage['CartEmpty.E']}" /></b>
								</h3>
								<p><c:out value="${showLanguage['CartEmpty.Text']}" /></p>
						</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="shoping__cart__btns" style=" display: block;margin: 0 auto;text-align: center;">
										<c:url var="showProduct" value="ShowProductControl"></c:url>
										<a href="${pageContext.request.contextPath}/${showProduct}"
											class="primary-btn cart-btn"><c:out value="${showLanguage['ButtonContinue']}" /></a>
									</div>
								</div>
							</div>
						
						</c:if>
						<c:if test="${not empty sessionScope.cart}">
							<table>
								<thead>
									<tr>
										<th class="shoping__product"><c:out value="${showLanguage['Checkout.Dish']}" /></th>
										<th><c:out value="${showLanguage['Checkout.Price']}" /></th>
										<th><c:out value="${showLanguage['Checkout.Quantity']}" /></th>
										<th><c:out value="${showLanguage['Checkout.IntoMoney']}" /></th>
										<th><c:out value="${showLanguage['AddCart.Detele']}" /></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${sessionScope.cart}" var="o">
										<tr>
											<td class="shoping__cart__item"><a
												href="DetailControl?pid=${o.value.product.id}"> <img
													style="width: 73px; height: auto;"
													src="${o.value.product.image}" width="150px" height="60px"></a>
												<a href="DetailControl?pid=${o.value.product.id}">
													<h5>${o.value.product.name}</h5>
											</a></td>
											<td class="shoping__cart__price">${o.value.product.price}₫</td>
											<td class="shoping__cart__quantity"><c:url var="decrease"
													value="DecreaseQControl"></c:url> <a
												href="${decrease}?key=${o.key}">
													<button style="border-radius: 6px;" name="minus" value="minus" type="button">-</button>
											</a> <input style="width: 40px;text-align: center;border-radius: 8px;" type="text" value="${o.value.quantity}" name="Lines"
												id="updates_6383545" min="1" readonly> <c:url
													var="increase" value="IncreaseQControll"></c:url> <a
												href="${increase}?key=${o.key}">
													<button style="border-radius: 6px;" name="add" value="add" type="button">+</button>
											</a></td>
											<td class="shoping__cart__total"><c:set var="sumAll"
													value="${o.value.quantity*o.value.price}"></c:set>
												${o.value.price}</td>
											<c:url var="delete" value="DeteleOrderControll"></c:url>
											<td class="text-center"><a
												class="fa fa-trash-o item-remove"
												href="${delete}?key=${o.key}"></a></td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<c:url var="showProduct" value="ShowProductControl"></c:url>
						<a href="${pageContext.request.contextPath}/${showProduct}"
							class="primary-btn cart-btn"><c:out value="${showLanguage['ButtonContinue']}" />
</a>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__continue">
						<div class="shoping__discount">
							<h5>Discount Codes</h5>
							<form action="#">
								<input type="text" placeholder="Enter your coupon code">
								<button type="submit" class="site-btn">APPLY COUPON</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__checkout">
						<h5><c:out value="${showLanguage['CartTotal']}" /></h5>
						<ul>
							<li><c:out value="${showLanguage['Total']}" /><span>${total}₫</span></li>
						</ul>
						<c:url var="checkout" value="CheckOutControll"></c:url>
						<a href="${pageContext.request.contextPath}/${checkout}"
							class="primary-btn"><c:out value="${showLanguage['ProccessC']}" /></a>
					</div>
				</div>
				</c:if>
			</div>
		</div>
	</section>
	<!-- Shoping Cart Section End -->

	<!-- Footer Section Begin -->
	<jsp:include page="./footer/footer.jsp"></jsp:include>


	<!-- Js Plugins -->

</body>

</html>