<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
</style>
</head>

<body>
	
	<jsp:include page="./header/header.jsp"></jsp:include>

	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<c:url var="orderplace" value="OrderPlaceControl"></c:url>
					<h3 style="text-align: center;">
						Thank you for your order! Click <a
							href="${pageContext.request.contextPath}/${orderplace}">here</a> to see details
					</h3>
				</div>
			</div>

		</div>
	</section>

	<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>

</html>