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
	<%@ page isELIgnored="false" %>

<jsp:include page="./link/link.jsp"></jsp:include>
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
}
</style>
</head>

<body>

<span class="header__fixed">
	<jsp:include page="header/header.jsp"></jsp:include>

</span>


<!-- Shoping Cart Section Begin -->
<div style="height: 140px"></div>
<br><br>
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<c:url var="orderplace" value="OrderPlaceControl"></c:url>
					<h3 style="text-align: center;">
						Cảm ơn bạn đã đặt hàng! Nhấn <a
							href="${pageContext.request.contextPath}/${orderplace}" style="color: #7fad39">tại đây</a> để xem chi tiết
					</h3>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>

</html>