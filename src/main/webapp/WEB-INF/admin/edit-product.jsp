<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Edit Product</title>
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
									<div class="card-body">
										<div class="card-title">Sửa sản phẩm</div>
										<hr>
										<c:url var="editP" value="EditProductControll"></c:url>
										<form action="${pageContext.request.contextPath}/${editP}"
											method="post">

											<div class="form-group">
												<label for="input-1">Mã sản phẩm</label> <input type="text"
													class="form-control" style="background-color: black;"
													input-1" readonly="readonly" placeholder="ID"
													value="${product.id}" name="product-id">
											</div>

											<div class="form-group">
												<label for="input-1">Tên sản phẩm</label> <input type="text"
													class="form-control" id="input-1"
													placeholder="Tên sản phẩm" name="product-name"
													value="${product.name}">
											</div>


											<div class="form-group">
												<label for="input-2">Chuyên mục</label>
												 <select	class="form-control" id="product-select"
													name="product-cate">
													<c:forEach items="${catelist}" var="cate">
			                      			<option value="${cate.id}" selected>${cate.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group"></div>
											<div class="form-group">
												<label for="input-1">Giá</label> <input type="text"
													class="form-control" id="input-1" placeholder="Giá"
													name="product-price" value="${product.price}">
											</div>


											<div class="form-group">
												<label for="input-2" class="col-form-label">Mô tả</label>
												<div>
													<textarea class="form-control" rows="4" id="input-17"
														name="product-desc">${product.description}</textarea>
												</div>
											</div>

											<div class="form-footer">
												<c:url var="listproductA" value="ListProductsControll"></c:url>
												<a class="btn btn-danger"
													href="${pageContext.request.contextPath}/${listproductA}">Hủy</a>
												<button type="submit" class="btn btn-success">Cập
													nhật</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="overlay toggle-menu"></div>
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