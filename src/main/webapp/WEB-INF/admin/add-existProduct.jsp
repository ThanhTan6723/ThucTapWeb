<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page isELIgnored="false" %>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Product</title>
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
                                    <div class="card-title">Nhập kho</div>
                                    <hr>
                                    <c:url var="addP" value="AddBatchControll"></c:url>
                                    <div id="formContainer">
                                        <form id="productForm" action="AddBatchControll" method="post">
                                            <div id="productFields">
                                                <!-- Các trường sản phẩm sẽ được thêm vào đây -->
                                            </div>
                                            <button type="button" class="btn btn-success" onclick="addProductFields()">Thêm lô hàng</button>
                                            <button type="submit" class="btn btn-success">Nhập kho</button>
                                        </form>


                                        <script>
                                            let productCounter = 0;

                                            function addProductFields() {
                                                productCounter++;

                                                const productFields = document.getElementById('productFields');
                                                const newProductFields = document.createElement('div');
                                                newProductFields.className = 'product-fields';
                                                newProductFields.innerHTML = `
            <div class="form-group">
                <label>Mã sản phẩm</label>
                <input type="text" class="form-control" name="product-ID[]" onblur="validateID(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>

            <div class="form-group">
                <label for="productBatchName">Tên lô hàng</label>
                <input type="text" class="form-control" name="product-Batch-name[]" onblur="validateNameBatch(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="manufacturingDate">Ngày sản xuất</label>
                <input type="date" class="form-control" name="manufacturingDate[]" onblur="validateNgaySX(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="expiryDate">Hạn sử dụng</label>
                <input type="date" class="form-control" name="expiryDate[]" onblur="validateNgayHetHan(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="dateOfImporting">Ngày nhập hàng</label>
                <input type="date" class="form-control" name="dateOfImporting[]" onblur="validateNgayNhapHang(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="productBatchQuantity">Số lượng nhập kho</label>
                <input type="text" class="form-control" name="product-Batch-quantity[]" onblur="validateQuantity(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="productPriceImport">Giá nhập</label>
                <input type="text" class="form-control" name="product-priceImport[]" onblur="validatePriceImport(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="providerName">Nhà cung cấp</label>
                <input type="text" class="form-control" name="providerName[]" onblur="validateProviderName(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
            <div class="form-group">
                <label for="providerAddress">Địa chỉ nhà cung cấp</label>
                <input type="text" class="form-control" name="providerAddress[]" onblur="validateProviderAddress(this)">
                <span class="error" style="color: red; font-size: 14px;"></span>
            </div>
        `;
                                                productFields.appendChild(newProductFields);
                                            }

                                            function validateID(input) {
                                                var ten = input.value;
                                                var error = input.nextElementSibling;
                                                if (ten.length == 0 || ten == null) {
                                                    error.textContent = "Vui lòng nhập vào mã sản phẩm";
                                                    error.style.display = "block";
                                                    return false;

                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }
                                            function validateNameBatch(input) {
                                                var ten = input.value;
                                                var error = input.nextElementSibling;
                                                if (ten.length == 0 || ten == null) {
                                                    error.textContent = "Vui lòng nhập vào tên lô hàng.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validateNgaySX(input) {
                                                var ngayNhapHang = new Date(input.value);
                                                var now = new Date();
                                                var error = input.nextElementSibling;
                                                if (isNaN(ngayNhapHang.getTime())) {
                                                    error.textContent = "Vui lòng chọn ngày sản xuất.";
                                                    error.style.display = "block";
                                                    return false;
                                                }
                                                if (ngayNhapHang > now) {
                                                    error.textContent = "Ngày sản xuất phải trước ngày hiện tại.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validateNgayHetHan(input) {
                                                var ngayHetHan = new Date(input.value);
                                                var now = new Date();
                                                var error = input.nextElementSibling;
                                                if (isNaN(ngayHetHan.getTime())) {
                                                    error.textContent = "Vui lòng chọn hạn sử dụng.";
                                                    error.style.display = "block";
                                                    return false;
                                                }
                                                if (ngayHetHan <= now) {
                                                    error.textContent = "Hạn sử dụng phải sau ngày hiện tại.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validateNgayNhapHang(input) {
                                                var ngayNhapHang = new Date(input.value);
                                                var now = new Date();
                                                var error = input.nextElementSibling;

                                                // Lấy ngày hiện tại và đặt giờ, phút, giây, milliseconds về 0 để so sánh chỉ theo ngày
                                                var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

                                                // Đặt giờ, phút, giây, milliseconds của ngayNhapHang về 0
                                                ngayNhapHang.setHours(0, 0, 0, 0);

                                                if (isNaN(ngayNhapHang.getTime())) {
                                                    error.textContent = "Vui lòng chọn ngày nhập hàng.";
                                                    error.style.display = "block";
                                                    return false;
                                                }
                                                if (ngayNhapHang.getTime() !== today.getTime()) {
                                                    error.textContent = "Ngày nhập hàng phải là ngày hiện tại.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }


                                            function validateQuantity(input) {
                                                var soLuongNhap = input.value;
                                                var error = input.nextElementSibling;
                                                if (soLuongNhap.length == 0 || soLuongNhap == null) {
                                                    error.textContent = "Vui lòng nhập vào số lượng nhập.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else if (isNaN(soLuongNhap) || soLuongNhap <= 0) {
                                                    error.textContent = "Số lượng nhập chỉ chứa chữ số, không âm.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validatePriceImport(input) {
                                                var giaNhap = input.value;
                                                var error = input.nextElementSibling;
                                                if (giaNhap.length == 0 || giaNhap == null) {
                                                    error.textContent = "Vui lòng nhập vào giá nhập.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else if (isNaN(giaNhap) || giaNhap <= 0) {
                                                    error.textContent = "Giá nhập chỉ chứa chữ số, không âm.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validateProviderName(input) {
                                                var tenNCC = input.value;
                                                var error = input.nextElementSibling;
                                                if (tenNCC.length == 0 || tenNCC == null) {
                                                    error.textContent = "Vui lòng nhập vào tên nhà cung cấp.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }

                                            function validateProviderAddress(input) {
                                                var diaChiNCC = input.value;
                                                var error = input.nextElementSibling;
                                                if (diaChiNCC.length == 0 || diaChiNCC == null) {
                                                    error.textContent = "Vui lòng nhập vào địa chỉ nhà cung cấp.";
                                                    error.style.display = "block";
                                                    return false;
                                                } else {
                                                    error.style.display = "none";
                                                    return true;
                                                }
                                            }
                                            function validateForm() {
                                                var isValid = true;
                                                var productFields = document.querySelectorAll('.product-fields');
                                                productFields.forEach(function(product) {
                                                    var inputs = product.querySelectorAll('input, textarea');
                                                    inputs.forEach(function(input) {
                                                        var valid = true;
                                                        if (input.type === 'text') {
                                                            if (input.name === 'product-ID[]') valid = validateID(input);
                                                            else if (input.name === 'product-Batch-name[]') valid = validateNameBatch(input);
                                                            else if (input.name === 'product-Batch-quantity[]') valid = validateQuantity(input);
                                                            else if (input.name === 'product-priceImport[]') valid = validatePriceImport(input);
                                                            else if (input.name === 'providerName[]') valid = validateProviderName(input);
                                                            else if (input.name === 'providerAddress[]') valid = validateProviderAddress(input);
                                                        } else if (input.type === 'date') {
                                                            if (input.name === 'manufacturingDate[]') valid = validateNgaySX(input);
                                                            else if (input.name === 'expiryDate[]') valid = validateNgayHetHan(input);
                                                            else if (input.name === 'dateOfImporting[]') valid = validateNgayNhapHang(input);

                                                        }
                                                        if (!valid) isValid = false;
                                                    });
                                                });
                                                return isValid;
                                            }

                                            document.getElementById('productForm').addEventListener('submit', function(event) {
                                                if (!validateForm()) {
                                                    event.preventDefault();
                                                }
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

