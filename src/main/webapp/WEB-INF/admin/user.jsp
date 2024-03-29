<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Of Users</title>
<!-- plugins:css -->
<jsp:include page="./link/link.jsp"></jsp:include>
<style>

tr,td{
color:white;

.table-hover:hover {
     
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */
    transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */

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
									<h4 class="card-title">List Users</h4>
								
									<table class="table table-hover custom-table">
										<thead>
											<tr>
												<th scope="col" style="color:white;font-weight: bold;">STT</th>
												<th scope="col" style="color:white;font-weight: bold;">Tên</th>
												<th scope="col" style="color:white;font-weight: bold;">Email</th>
												<th scope="col" style="color:white;font-weight: bold;">Số điện thoại</th>
												<th scope="col" style="color:white;font-weight: bold;">Hành động</th>
											</tr>
										</thead>
									<tbody>
									<c:forEach items="${accounts}" var="o" varStatus="stt">
										<tr>
											<td scope="row">${stt.index+1}</td>										
											<td>${o.name }</td>
											<td>${o.email }</td>
											<td>${o.telephone }</td>
											<td><c:url value="DeleteUserControll" var="deleteU"></c:url> <a
												href="${pageContext.request.contextPath}/${deleteU}?id=${o.id}">
													<button class="btn btn-danger">Xóa</button>
											</a></td>
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