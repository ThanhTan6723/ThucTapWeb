<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page isELIgnored="false" %>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Of Products</title>
<!-- plugins:css -->
<jsp:include page="./link/link.jsp"></jsp:include>

</head>
<body>
	<div class="container-scroller">
		<jsp:include page="./header/sidebar.jsp"></jsp:include>
		<div class="container-fluid page-body-wrapper">
			<jsp:include page="./header/navbar.jsp"></jsp:include>
			<div class="main-panel">

				<div class="content-wrapper">
					<div class="container-fluid">

						<div class="row mt-3">
							<div class="col-lg-12">
								<div class="card">
									<div class="row mt-3">
										<div class="col-lg-12">
											<c:url value="AddProductControll" var="addP"></c:url>
											<a href="${pageContext.request.contextPath}/${addP}">
												<button class="add-catalog">Thêm sản phẩm</button>
											</a>
										</div>
										<div class="col-lg-12">
											<div class="card">
												<div class="card-body">
													<h5 class="card-title">Danh sách sản phẩm</h5>
													<div class="table-responsive">
														<table class="table table-striped">
															<thead>
																<tr>
																	<th scope="col">Mã sản phẩm</th>
																	<th scope="col">Tên sản phẩm</th>
																	<th scope="col">Hình ảnh</th>
																	<th scope="col">Mã loại</th>
																	<th scope="col">Giá</th>

																	<th scope="col">Hành động</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach items="${productlist}" var="product">
																	<tr>
																		<th scope="row">${product.id }</th>
																		<td>${product.name }</td>
																		<td><img
																			style="width: 110px; height: 67px; object-fit: cover; border: 1px solid #fff;"
																			src="${product.image}"
																			alt="${product.name}"></td>
																		<td>${product.id}</td>
																		<td>${product.price}</td>

											<td><a
												href="DeleteProductControll?id=${product.id}"><button
																class="btn btn-danger">Xóa</button></a>
														<a
														href="EditProductControll?id=${product.id}">
															<button class="btn btn-success">Sửa</button>
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
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<jsp:include page="./footer/footer.jsp"></jsp:include>

</body>
</html>