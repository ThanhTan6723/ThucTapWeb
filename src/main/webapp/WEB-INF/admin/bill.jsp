<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bill</title>
<!-- plugins:css -->
<jsp:include page="./link/link.jsp"></jsp:include>
<style>
	.order-section {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .order-column {
        flex: 0 0 calc(50% - 20px);
        box-sizing: border-box;
        padding: 15px;
    }

    @media (max-width: 767px) {
        .order-column {
            flex: 0 0 100%;
        }
    }

	tr,td{
	color:white;

	.table-hover:hover {
     
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); 
    transition: box-shadow 0.3s ease; 

}</style>

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
									<h4 class="card-title"> All Orders</h4>
								
									<table class="table table-hover custom-table">
										<thead>
											<tr>
												<th scope="col" style="color:white;font-weight: bold;">Order ID</th>
												<th scope="col" style="color:white;font-weight: bold;">Booking Date</th>
												<th scope="col" style="color:white;font-weight: bold;">Account</th>
												<th scope="col" style="color:white;font-weight: bold;">Total Money</th>
												<th scope="col" style="color:white;font-weight: bold;">Address</th>
												<th scope="col" style="color:white;font-weight: bold;">Notes</th>
												<th scope="col" style="color:white;font-weight: bold;">Action</th>
											</tr>
										</thead>
									<tbody>
									<c:if test="${empty sessionScope.AllOrders}">
										<tr><td colspan="7" style="color: #00d25b;text-align: center;"><span>There are currently no orders</span></td></tr>
									</c:if>
									<c:if test="${not empty sessionScope.AllOrders}">
									<c:forEach items="${sessionScope.AllOrders}" var="od">
												<tr>
													<th scope="row" style="">${od.id}</th>
													<td>${od.date }</td>
													<td>${od.account.name}</td>
													<td  style="color: #00d25b;">${od.totalMoney}</td>
													<td>${od.address}</td>
													<c:if test="${ empty od.orderNotes}">
													<td>NULL</td>
													</c:if>
													<c:if test="${not empty od.orderNotes}">
													<td>${od.orderNotes}</td>
													</c:if>

											<td><c:url var="accept" value="AcceptControll"></c:url> <a
												href="${pageContext.request.contextPath}/${accept}?id=${od.id}">
													<button class="btn btn-success">Accept</button>
											</a><c:url var="refuse" value="RefuseBillControll"></c:url> <a
												href="${pageContext.request.contextPath}/${refuse}?id=${od.id}"><button
																class="btn btn-danger">Refuse</button></a>
														</td>
										</tr>
									</c:forEach>
									</c:if>
								</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>

<div class="content-wrapper order-section">
 <div class="order-column">
				<div class="row ">
					<div class="col-12 grid-margin">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<h4 class="card-title">Order has been confirmed</h4>
								
									<table class="table table-hover custom-table">
										<thead>
											<tr>
												<th scope="col" style="color:white;font-weight: bold;">Order ID</th>
												<th scope="col" style="color:white;font-weight: bold;">Booking Date</th>
												<th scope="col" style="color:white;font-weight: bold;">Account</th>
												<th scope="col" style="color:white;font-weight: bold;">Total Money</th>
												<th scope="col" style="color:white;font-weight: bold;">Address</th>
												<th scope="col" style="color:white;font-weight: bold;">Notes</th>
											</tr>
										</thead>
									<tbody>
												<c:forEach var="entry" items="${sessionScope.OrdersConfirmed}">
												
													<th scope="row">${entry.id}</th>
													<td>${entry.date }</td>
													<td>${entry.account.name}</td>
													<td  style="color: #00d25b;">${entry.totalMoney}</td>
													<td>${entry.address}</td>
													<c:if test="${empty entry.orderNotes}">
													<td>NULL</td>
													</c:if>
													<c:if test="${not empty entry.orderNotes}">
													<td>${entry.orderNotes}</td>
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
 <div class="order-column">
				<div class="row ">
					<div class="col-12 grid-margin">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<h4 class="card-title">Orders is Refused</h4>
								
									<table class="table table-hover custom-table">
										<thead>
											<tr>
												<th scope="col" style="color:white;font-weight: bold;">Order ID</th>
												<th scope="col" style="color:white;font-weight: bold;">Booking Date</th>
												<th scope="col" style="color:white;font-weight: bold;">Account</th>
												<th scope="col" style="color:white;font-weight: bold;">Total Money</th>
												<th scope="col" style="color:white;font-weight: bold;">Address</th>
												<th scope="col" style="color:white;font-weight: bold;">Notes</th>
												<th scope="col" style="color:white;font-weight: bold;">Action</th>
											</tr>
										</thead>
									<tbody>
												<c:forEach var="entry" items="${sessionScope.OrdersRefused}">
												
													<th scope="row" style="">${entry.id}</th>
													<td>${entry.date }</td>
													<td>${entry.account.name}</td>
													<td  style="color: #00d25b;">${entry.totalMoney}</td>
													<td>${entry.address}</td>
													<c:if test="${ empty entry.orderNotes}">
													<td>NULL</td>
													</c:if>
													<c:if test="${not empty entry.orderNotes}">
													<td>${entry.orderNotes}</td>
													</c:if>

											<td><c:url var="detele" value="DeleteBillControll"></c:url> <a
												href="${pageContext.request.contextPath}/${detele}?id=${entry.id}"><button
																class="btn btn-danger">Detele</button></a> <c:url
											var="editPA" value="ProductEditController"></c:url>
														</td>
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
			
		</div>
		<jsp:include page="./footer/footer.jsp"></jsp:include>
		<!-- main-panel ends -->
		
	</div>
	<!-- page-body-wrapper ends -->
	
	</div>
	
</body>
</html>