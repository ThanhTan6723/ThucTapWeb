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
<title>Sản phẩm</title>

<jsp:include page="./link/link.jsp"></jsp:include>
<style type="text/css">
.empty{
	text-align: center;
	padding-top: 50px;
}
.message {
	font-family: 'Arial', sans-serif;
	font-size: 18px;
	color: white;
	text-align: center;
	padding: 10px;
	box-shadow: 2px 2px 5px 0px rgba(0, 0, 0, 0.5);
	border-radius: 5px;
	background-color: #FF9900;
	margin-bottom: 20px;
}

  /* Style for the div containing the table */
  .shoping__cart {
    margin-top: 20px; /* Adjust the margin as needed */
  }

  /* Style for the table */
  table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px; /* Adjust the margin as needed */
    box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.2);
    margin-top: 10px;
  }

  th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
  }

  th {
    background-color: #ececec;
  }

  .shoping__product {
    /* Add specific styles for the product header if needed */
  }

  /* Style for the table rows */
  .shoping__cart__item img {
    width: 73px;
    height: auto;
    margin-right: 10px; /* Adjust the margin as needed */
  }

  /* Style for the total row */
  .shoping__cart__total {
    font-weight: bold;
    color: red;
  }

  /* Style for the information div */
  .information {
  	width: 600px;
  	height:150px;
    border-radius: 8px;
    background: #ffffff;
    z-index: 9;
    box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.2);
    padding: 25px;
    margin-top: 10px; /* Adjust the margin as needed */
  }
</style>

</head>

<body>
	<jsp:include page="./header/header.jsp"></jsp:include>

	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
					<div class="empty"><c:if test="${empty listProductOrder}">
						<h3><b>You haven't order</b></h3>
					</c:if></div>					
					
					<c:if test="${not empty listProductOrder}">

						<c:forEach items="${listProductOrder}" var="o" varStatus="loop">
							<c:set var="total" value="0" />
							<c:if test="${o.order.id != currentOrderId}">
								<!-- Nếu là đơn hàng mới, tạo bảng mới -->
								<c:set var="currentOrderId" value="${o.order.id}" />
								<br>
								<div class="information">
									 <h5><b><c:out value="${showLanguage['OrderPlaced.Code']}" /> </b>${o.order.id}</h5>
                                     <h5><b><c:out value="${showLanguage['OrderPlaced.Date']}" /> </b>${o.order.date}</h5>
                                     <h5><b><c:out value="${showLanguage['OrderPlaced.Address']}" /> </b>${o.order.address}</h5>
                                     <h5><b><c:out value="${showLanguage['OrderPlaced.Phone']}" /></b> ${o.order.account.telephone}</h5>
                                     <h5><b><c:out value="${showLanguage['OrderPlaced.Status']}" /> </b><span style="color: #7fad39;">${o.order.orderStatus}</span></h5>
								</div>

								<table>
									<thead>
										<tr>
											<th class="shoping__product"><c:out value="${showLanguage['Checkout.Dish']}" /></th>
                                                <th><c:out value="${showLanguage['Checkout.Price']}" /></th>
                                                <th><c:out value="${showLanguage['Checkout.Quantity']}" /></th>
                                                <th><c:out value="${showLanguage['Checkout.IntoMoney']}" /></th>
										</tr>
									</thead>
									<tbody>
										</c:if>

										<!-- Hiển thị thông tin sản phẩm -->
										<tr>
											<td class="shoping__cart__item"><img
												style="width: 73px; height: auto;"
												src="${o.product.image}">
												<h5>${o.product.name}</h5></td>
											<td class="shoping__cart__price">${o.product.price}₫</td>
											<td class="shoping__cart__quantity"><b>${o.quantity}</b></td>
											<td class="shoping__cart__total">${o.price*o.quantity}</td>
										</tr>


										<c:if
											test="${loop.last || o.order.id != listProductOrder[loop.index + 1].order.id}">
											<!-- Nếu là sản phẩm cuối cùng của đơn hàng, đóng bảng và hiển thị tổng giá -->
											<tr>
												<td colspan="2"></td>
												<td colspan="2" style="text-align: center;"><h5><b><c:out value="${showLanguage['OrderPlaced.Total']}" /><span style="color: red;">${o.order.totalMoney}</span></b></h5></td>
											</tr>
											<br><br>
									</tbody>
								</table>
							</c:if>
						</c:forEach>
					</c:if>


					</div>
				</div>
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
		</div>
	</section>

	<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>

</html>