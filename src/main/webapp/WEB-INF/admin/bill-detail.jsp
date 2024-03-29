<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Bill Detail</title>
	<!-- plugins:css -->
	<jsp:include page="./link/link.jsp"></jsp:include>
	<style>	
		tr,td{
		color:white;
		.table-hover:hover {
		    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */
		    transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */
		
		}
	</style>
</head>
<body>
	<div class="container-scroller">
		<jsp:include page="./header/sidebar.jsp"></jsp:include>
		<div class="container-fluid page-body-wrapper">
			<jsp:include page="./header/navbar.jsp"></jsp:include>
			<div class="main-panel">
          <div class="content-wrapper">
				<div class="row ">
					<div class="col-12 grid-margin">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<h4 class="card-title">List Bill Detail</h4>
								
									<table class="table table-hover custom-table">
										<thead>
											<tr>
												<th scope="col" style="color:white;font-weight: bold;">Order ID</th>
												<th scope="col" style="color:white;font-weight: bold;">Product's Name - Amount</th>
												<th scope="col" style="color:white;font-weight: bold;">Total</th>
												<th scope="col" style="color:white;font-weight: bold;">Total Money</th>
												<th scope="col" style="color:white;font-weight: bold;">Status</th>
											</tr>
										</thead>
									<tbody>
										<c:forEach var="b" items="${lists}" varStatus="stt">
									    <tr>
									        <td>${b.id}</td>
									        <c:forEach var="entry" items="${listBillDetails}">
									        	<c:if test="${stt.index == entry.key}">
									            	<td><c:forEach var="p" items="${entry.value}">
									                <p>${p.product.name} - ${p.quantity}</p>
									            	</c:forEach></td>
									            </c:if>
									        </c:forEach>
									                <td>${listQ.get(b.id)}</td>
									        <td>${b.totalMoney}
									        <c:if test="${b.orderStatus=='Order is awaiting confirmation'}">
									        <td>${b.orderStatus}</td>
									        </c:if>
									        <c:if test="${b.orderStatus=='Order has been confirmed'}">
									        <td style="color: #00d25b;">${b.orderStatus}</td>
									        </c:if>
									        <c:if test="${b.orderStatus=='Order is Refused'}">
									        <td style="color: #fc424a;">${b.orderStatus}</td>
									        </c:if>
									    </tr>
									 </c:forEach>
									</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>

		<jsp:include page="./footer/footer.jsp"></jsp:include>
		</div>
		<!-- main-panel ends -->
	</div>
	<!-- page-body-wrapper ends -->
</div>

</body>
</html>