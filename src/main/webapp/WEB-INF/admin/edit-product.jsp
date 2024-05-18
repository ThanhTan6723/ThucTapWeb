<%--suppress ALL --%>
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
												<label >Mã sản phẩm</label> <input type="text"
													class="form-control" style="background-color: black;"
													id ="productId" readonly="readonly" placeholder="ID"
													value="${product.id}" name="product-id">
											</div>

											<div class="form-group">
												<label >Tên sản phẩm</label> <input type="text"
													class="form-control" id="productName"
													placeholder="Tên sản phẩm" name="product-name"
													value="${product.name}">
											</div>
											<span class="error" id="error_productName" style="color: red; font-size: 14px;"></span>

											<div class="form-group">
												<label >Giá</label> <input type="text"
																						class="form-control" id="productPrice" placeholder="Giá"
																						name="product-price" value="${product.price}">
											</div>
											<span class="error" id="error_productPrice" style="color: red; font-size: 14px;"></span>
											<div class="form-group">
												<label>Hình ảnh</label>
												<input type="file" class="form-control" id="productImage" name="product-image">
											</div>

											<div class="form-group">
												<label class="col-form-label">Mô tả</label>
												<div>
													<textarea class="form-control" rows="4" id="productDescription"
															  name="product-desc">${product.description}</textarea>
												</div>
											</div>
											<span class="error" id="error_productDescription" style="color: red; font-size: 14px;"></span>

											<div class="form-group">
												<label >Phân loại</label>
												 <select class="form-control" id="product-select"
													name="product-cate">
													<c:forEach items="${catelist}" var="cate">
			                      			<option value="${cate.id}" selected>${cate.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group"></div>
											<div class="form-group">
												<label >Số lượng</label> <input type="text"
																						class="form-control" id="productQuantity" placeholder="Giá"
																						name="product-quantity" value="${product.quantity}">
											</div>
											<span class="error" id="error_productQuantity" style="color: red; font-size: 14px;"></span>
											<div class="form-group">
												<label >Giá nhập</label> <input type="text"
																						class="form-control" id="productPriceImport" placeholder="Giá"
																						name="product-priceImport" value="${product.priceImport}">
											</div>
											<span class="error" id="error_productPriceImport" style="color: red; font-size: 14px;"></span>
											<div class="form-group">
												<label for="input-4">Trọng lượng</label> <input type="text"
																						class="form-control" id="productWeight" placeholder="Giá"
																						name="product-weight" value="${product.weight}">
											</div>
											<span class="error" id="error_productWeight" style="color: red; font-size: 14px;"></span>
											<div class="form-group">
												<label >Nhà cung cấp</label>
												<select	class="form-control" id="productProvider"
														   name="product-provider">
													<c:forEach items="${providerList}" var="cate">
														<option value="${cate.id}" selected>${cate.name}</option>
													</c:forEach>
												</select>
											</div>

											<div class="form-group">
												<label >Ngày sản xuất</label> <input type="date"
																						class="form-control" id="productNSX" placeholder="Giá"
																						name="product-NSX" value="${product.dateOfImporting}">
											</div>
											<span class="error" id="error_productNSX" style="color: red; font-size: 14px;"></span>

											<div class="form-group">
												<label  class="col-form-label">Hạn sử dụng</label>
												<input type="date"
													   class="form-control" id="productHSD" placeholder="Giá"
													   name="product-HSD" value="${product.expriredDay}">
											</div>
											<span class="error" id="error_productHSD" style="color: red; font-size: 14px;"></span>

											<div class="form-footer">
												<a class="btn btn-danger"
													href="./LoadProductsPage">Hủy</a>
												<button type="submit" class="btn btn-success" id="submit-btn">Cập
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
  <script>
	  var productName = document.getElementById("productName");
	  var productNSX = document.getElementById("productNSX");
	  var productHSD = document.getElementById("productHSD");
	  var productPrice = document.getElementById("productPrice");
	  var productDescription = document.getElementById("productDescription");
	  var productQuantity = document.getElementById("productQuantity");
	  var productPriceImport = document.getElementById("productPriceImport");
	  var productWeight = document.getElementById("productWeight");
	  function  validateName(){
		  var ten = productName.value;
		  var kyTuHopLe = /^[\p{L}\s']+$/u;
		  var error = document.getElementById("error_productName");
		  if (ten.length == 0 || ten == null) {
			  error.textContent = "Vui lòng nhập vào tên sản phầm";
			  error.style.display = "block";
			  return false;
		  } else if (!kyTuHopLe.test(ten)) {
			  error.textContent = "Tên trái cây chỉ chứa ký tự chữ cái, khoảng trắng.";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validateNgayNhapHang() {
		  var ngayNhapHang = new Date(productNSX.value);
		  var now = new Date();
		  var error = document.getElementById("error_productNSX");
		  // Kiểm tra xem ngày nhập hàng đã chọn hay chưa
		  if (isNaN(ngayNhapHang.getTime())) {
			  error.textContent = "Vui lòng chọn ngày nhập hàng.";
			  error.style.display = "block";
			  return false;
		  }
		  if (ngayNhapHang > now) {
			  error.textContent = "Ngày nhập hàng phải trước ngày hiện tại.";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validateNgayHetHan() {
		  var ngayNhapHang = new Date(productNSX.value);
		  var ngayHetHan = new Date(productHSD.value);
		  var now = new Date();

		  var error = document.getElementById("error_productHSD");

		  // Kiểm tra xem ngày hết hạn đã chọn hay chưa
		  if (isNaN(ngayHetHan.getTime())) {
			  error.textContent = "Vui lòng chọn ngày hết hạn.";
			  error.style.display = "block";
			  return false;
		  }

		  // Kiểm tra xem ngày hết hạn có sau ngày nhập hàng
		  if (ngayHetHan <= ngayNhapHang) {
			  error.textContent = "Ngày hết hạn phải sau ngày nhập hàng.";
			  error.style.display = "block";
			  return false;
		  } else
				  // Kiểm tra xem ngày hết hạn có sau ngày hiện tại không
		  if (ngayHetHan <= now) {
			  error.textContent = "Ngày hết hạn phải sau ngày hiện tai.";
			  error.style.display = "block";
			  return false;
		  } else{
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validateDescription() {
		  var text = productDescription.value;
		  var error = document.getElementById("error_productDescription");
		  if (text.length == 0 || text == null) {
			  error.textContent = "Vui lòng nhập mô tả sản phẩm";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validatePrice() {
		  var text = productPrice.value;
		  var error = document.getElementById("error_productPrice");
		  if (text.length == 0 || text == null) {
			  error.textContent = "Vui lòng nhập vào giá tiền sản phầm.";
			  error.style.display = "block";
			  return false;
		  } else if (isNaN(text) || text <= 0) {
			  error.textContent = "Giá tiền sản phẩm chỉ chứa chữ số, không âm.";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validatePriceImport() {
		  var text = productPriceImport.value;
		  var error = document.getElementById("error_productPriceImport");
		  if (text.length == 0 || text == null) {
			  error.textContent = "Vui lòng nhập vào giá tiền sản phầm.";
			  error.style.display = "block";
			  return false;
		  } else if (isNaN(text) || text <= 0) {
			  error.textContent = "Giá tiền sản phẩm chỉ chứa chữ số, không âm.";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  function validateQuantity() {
		  var text = productQuantity.value;
		  var error = document.getElementById("error_productQuantity");
		  if (text.length == 0 || text == null) {
			  error.textContent = "Vui lòng nhập vào số lượng sản phẩm.";
			  error.style.display = "block";
			  return false;
		  } else if (isNaN(text) || text <= 0) {
			  error.textContent = "Số lượng sản phẩm chỉ chứa chữ số, không âm.";
			  error.style.display = "block";
			  return false;
		  } else {
			  error.style.display = "none";
			  return true;
		  }
	  }
	  productName.addEventListener("blur",validateName);
      productNSX.addEventListener("blur",validateNgayNhapHang);
	  productHSD.addEventListener("blur",validateNgayHetHan);
	  productDescription.addEventListener("blur",validateDescription);
	  productPrice.addEventListener("blur",validatePrice);
	  productPriceImport.addEventListener("blur",validatePriceImport);
	  productQuantity.addEventListener("blur",validateQuantity);
	  var buttonSubmit = document.getElementById("submit-btn");
	  buttonSubmit.addEventListener("click",function (event){

		  var isName = validateName();
		  var isNgayNhapHangValid = validateNgayNhapHang();
		  var isNgayHetHanValid = validateNgayHetHan();
		  var isDescription = validateDescription();
		  var isPrice = validatePrice();
		  var isPriceImport = validatePriceImport();
		  var isQuantity = validateQuantity();
		  if(!isNgayHetHanValid || !isNgayNhapHangValid || !isName || !isDescription ||!isPrice ||!isPriceImport ||!isQuantity){
			  event.preventDefault();
		  }
	  })
  </script>
</body>
</html>