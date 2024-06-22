<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cart</title>
    <jsp:include page="./link/link.jsp"></jsp:include>
    <style>
        .shoping__cart__table {
            background-color: #ffffff;
            /*border-radius: 9px;*/
            padding: 25px;
            margin-top: 25px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 100px auto; /* Cách phía trên 100px và tự động căn giữa ngang */
            padding: 20px;
            border: 1px solid #888;
            width: 40%; /* Độ dài 50% */
            /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);*/
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .voucher-item {
            margin-bottom: 10px;
        }

        body.modal-open {
            overflow: hidden;
        }

        .voucher-search {
            display: flex;
            align-items: center;
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #e0e0e0;
            /*border-radius: 5px;*/
            margin-bottom: 20px;
        }

        .voucher-search label {
            margin-right: 10px;
            font-weight: bold;
        }

        .voucher-search input {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #e0e0e0;
            /*border-radius: 5px;*/
            margin-right: 10px;
        }

        .voucher-search button {
            padding: 10px 20px;
            background-color: #e0e0e0;
            border: none;
            /*borderradius-: 5px;*/
            cursor: not-allowed;
            color: #a0a0a0;
        }

        .voucher-search button.active {
            background-color: #86b23e;
            color: white;
            cursor: pointer;
        }

        .voucher-item {
            margin-bottom: 10px;
        }

        .voucher-input {
            display: flex;
            align-items: center;
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #e0e0e0;
            /*border-radius: 5px;*/
            margin-bottom: 20px;
            width: fit-content;
        }

        .voucher-input label {
            margin-right: 10px;
            font-weight: bold;
        }

        .voucher-input input {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #e0e0e0;
            /*border-radius: 5px;*/
            margin-right: 10px;
        }

        .voucher-input button {
            padding: 10px 20px;
            background-color: #e0e0e0;
            border: none;
            /*border-radius: 5px;*/
            cursor: not-allowed;
            color: #a0a0a0;
        }

        .voucher-input button.apply {
            background-color: #7fad39;
            color: white;
            cursor: pointer;
        }

        /* Add this CSS to your stylesheet */

        .voucher-modal-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .voucher-modal-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .voucher-modal-footer button {
            padding: 10px 20px;
            margin-left: 10px;
            width: 120px;
            border: none;
            background-color: #7fad39;
            color: white;
            cursor: pointer;
            /*border-radius: 4px;*/
            font-size: 14px;
            /*font-weight: bold;*/
            /*box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);*/
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .voucher-modal-footer button:hover {
            background-color: #7ba639;
            /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);*/
        }

        #backButton {
            background-color: #ffffff; /* Red color */
            color: #777777;
            border: 0.5px solid #c0c0c0;
        }

        #okButton {
            background-color: #7fad39; /* Red color */
        }

        /* Voucher List Styles */
        .voucher-list-container {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            /*border-radius: 5px;*/
            padding: 10px;
            background: #f9f9f9;
        }

        .voucher-list {
            display: flex;
            flex-direction: column;
        }

        .voucher-item {
            display: flex;
            padding: 10px;
            margin-bottom: 10px;
            background: #fff;
            border: 1px solid #ddd;
            /*border-radius: 5px;*/
            position: relative;
        }

        .voucher-left {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 10px;
            background: #bde4e2;
            /*border-radius: 5px 0 0 5px;*/
            width: 120px;
            text-align: center;
            border-right: 1px solid #ddd;
        }

        .voucher-left img {
            width: 50px;
            height: 50px;
            margin-bottom: 5px;
        }

        .voucher-left span {
            font-weight: bold;
            color: #3b3b3b;
        }

        .voucher-right {
            display: flex;
            flex-direction: column;
            flex: 1;
            padding: 10px;
            justify-content: space-between;
            position: relative;
        }

        .voucher-right-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .voucher-desc {
            /*font-weight: bold;*/
            margin-bottom: 5px;
        }

        .voucher-expiry {
            font-size: 12px;
            color: #888;
        }

        .voucher-expiry a {
            color: #007bff;
            text-decoration: none;
        }

        .voucher-expiry a:hover {
            text-decoration: underline;
        }

        .voucher-quantity {
            background: #f8d7da;
            color: #721c24;
            border-radius: 50%;
            padding: 5px 10px;
            font-size: 12px;
            margin-left: 10px;
        }

        .voucher-select {
            position: absolute;
            right: 10px;
            bottom: 10px;
        }

        .voucher-select input {
            /*position: absolute;*/
            /*opacity: 5px;*/
            /*cursor: pointer;*/
            /*height: 0;*/
            /*width: 0;*/
        }

        .voucher-select input:checked ~ .checkmark {
            background-color: #007bff;
        }

        .voucher-select input:checked ~ .checkmark:after {
            display: block;
        }

        /* Thêm lớp CSS cho voucher-item khi được chọn */
        .voucher-item.selected {
            background-color: #e0f7fa;
            border: 1px solid #007bff;
        }

        /* Thêm lớp CSS cho thông báo lỗi */
        .error-message {
            color: red;
            font-weight: bold;
            display: none;
        }

    </style>
</head>
<body>
<jsp:include page="header/header.jsp"></jsp:include>
<!-- Shoping Cart Section Begin -->
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="empty-cart-message" style="display: none;">
                    <div class="img" style="text-align: center; line-height: 50vh;">
                        <img alt="" src="assets/img/empty-cart.svg" style="vertical-align: middle;">
                        <h3><b>Giỏ hàng rỗng</b></h3>
                        <p>Hiện tại bạn chưa có sản phẩm nào trong giỏ hàng. Hãy dạo quanh cửa hàng để chọn được sản
                            phẩm ưng ý nhé!</p>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__btn"
                                 style=" display: block; margin: 0 auto; text-align: center;">
                                <c:url var="showProduct" value="ShowProductControl"></c:url>
                                <a href="${pageContext.request.contextPath}/${showProduct}"
                                   class="primary-btn cart-btn">Tiếp tục mua sắm</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="shoping__cart__table">
                    <c:if test="${not empty sessionScope.cart}">
                    <table>
                        <thead>
                        <tr>
                            <th class="shoping__product">Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${sessionScope.cart}" var="o">
                            <tr id="row_${o.key}">
                                <td class="shoping__cart__item">
                                    <a href="DetailControl?pid=${o.value.product.id}">
                                        <img style="width: 73px; height: auto;"
                                             src="${o.value.product.image}" width="150px" height="60px">
                                    </a>
                                    <a href="DetailControl?pid=${o.value.product.id}">
                                        <h5>${o.value.product.name}</h5>
                                    </a>
                                </td>
                                <td class="shoping__cart__price">${o.value.product.price}₫</td>
                                <td class="shoping__cart__quantity">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <span class="dec qtybtn decrease-btn" data-key="${o.key}">-</span>
                                            <input type="text" value="${o.value.quantity}" min="1" id="updates_${o.key}"
                                                   readonly>
                                            <span class="inc qtybtn increase-btn" data-key="${o.key}">+</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="shoping__cart__total total-price_${o.key}">
                                        ${o.value.quantity * o.value.product.price}₫
                                </td>
                                <td class="shoping__cart__item__close">
                                    <span class="icon_close remove-btn" data-key="${o.key}"></span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="shoping__cart__btns">
                    <c:url var="showProduct" value="ShowProductControl"></c:url>
                    <a href="${pageContext.request.contextPath}/${showProduct}"
                       class="primary-btn cart-btn">Tiếp tục mua sắm</a>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="shoping__continue">
                    <div class="shoping__discount">
                        <h5>Voucher</h5>
                        <form>
                            <input type="text" id="couponCode" placeholder="Enter your coupon code">
                            <input type="hidden" id="quantity" value="1" readonly>
                            <input type="hidden" id="discountValue" value="0">
                            <!-- Thêm input ẩn để lưu giá trị giảm giá -->
<%--                            <input type="hidden" id="originalTotalAmount" value="${total}">--%>
                            <!-- Thêm input ẩn để lưu tổng tiền gốc -->
                            <button type="button" class="site-btn" onclick="applyDiscountIfCouponExists()">Áp dụng
                            </button>
                            <div id="discountError" style="color: red; display: none;">Mã giảm giá không tồn tại</div>
                            <!-- Thêm phần tử để hiển thị thông báo lỗi -->
                        </form>

                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="shoping__checkout" style="background-color: #f5f5f5">
                    <h5><b>Thanh Toán</b></h5>
                        <%--                    <input type="hidden" id="originalTotalAmount" value="${total}">--%>
                        <%--                    <input type="hidden" id="discountValue" value="0">--%>
                        <%--                    <input type="hidden" id="temporaryTotal" value="${total}">--%>
                    <ul>
                        <li>Tạm tính<span id="originalTotalAmount" class="total-amount">${total}₫</span></li>
                        <li>Giảm giá<span id="discountAmount">0₫</span></li>
                        <li>Tổng tiền<span id="totalAmount"></span></li>
                    </ul>
                    <ul>
                        <li>Vouncher<span> <i class="bi bi-ticket-perforated-fill" style="font-size: 2rem;"></i><a
                                href="#"
                                class="apply"><p style="color: #6fa6d6">Chọn hoặc nhập mã</p></a></span></li>
                    </ul>
                    <c:url var="checkout" value="CheckOutControll"></c:url>
                    <a href="${pageContext.request.contextPath}/${checkout}" class="primary-btn">Thanh toán</a>
                </div>
            </div>
            </c:if>
        </div>
    </div>
</section>
<!-- Shoping Cart Section End -->
<!-- Voucher Modal Begin -->
<div id="voucherModal" class="modal">
    <div class="modal-content">
        <h5>Chọn Voucher</h5><br>
        <div class="voucher-search">
            <label for="voucherCode">Mã Voucher</label>
            <input type="text" id="voucherCode" placeholder="Nhập mã voucher">
            <button id="applyVoucher" disabled>ÁP DỤNG</button>
        </div>
        <div class="voucher-list-container">
            <div class="voucher-list">
                <!-- Example voucher item, repeat this block for each voucher -->
                <c:forEach var="voucher" items="${savedVouchers}">
                    <c:set var="voucherApplies" value="false"/>
                    <c:choose>
                        <c:when test="${voucher.discountType.type == 'All'}">
                            <c:set var="voucherApplies" value="true"/>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${sessionScope.cart}" var="cart">
                                <c:if test="${voucher.product != null && voucher.product.id == cart.value.product.id}">
                                    <c:set var="voucherApplies" value="true"/>
                                </c:if>
                                <c:if test="${voucher.category != null && voucher.category.id  == cart.value.product.category.id}">
                                    <c:set var="voucherApplies" value="true"/>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <div class="voucher-item" data-voucher="${voucher.id}"
                         <c:if test="${!voucherApplies}">style="opacity: 0.5; pointer-events: none;"</c:if>>
                        <div class="voucher-left">
                            <img src="https://via.placeholder.com/50" alt="Voucher Image">
                            <span>${voucher.code}</span>
                        </div>
                        <div class="voucher-right">
                            <div class="voucher-right-top">
                                <p class="voucher-desc">Giảm tối đa ${voucher.discountPercentage}%<br>${voucher.discountType.type}</p>
                                <span class="voucher-quantity">x1</span>
                            </div>
                            <p class="voucher-expiry">Sắp hết hạn: Còn 12 giờ <a href="#">Điều Kiện</a></p>
                            <label class="voucher-select">
                                <input type="radio" name="voucher" value="${voucher.id}">
                            </label>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- Button container at the bottom -->
        <div class="voucher-modal-footer">
            <button id="backButton">TRỞ LẠI</button>
            <button id="okButton">OK</button>
        </div>
    </div>
</div>
<!-- Voucher Modal End -->
<!-- Footer Section Begin -->
<jsp:include page="./footer/footer.jsp"></jsp:include>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var selectedVoucher = null;

        // Handle OK button click
        var okButton = document.getElementById("okButton");
        okButton.addEventListener("click", function () {
            if (selectedVoucher) {
                console.log("Selected voucherId:", selectedVoucher);
                applyVoucher(selectedVoucher);
            } else {
                alert("Chưa chọn voucher");
            }
        });

        function applyVoucher(voucherId) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "ApplyVoucherControll", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        updateDiscountAndTotal(response.discountAmount, response.totalAmount);
                    } else {
                        console.error("Request failed: " + xhr.status);
                    }
                }
            };
            xhr.send("voucherId=" + encodeURIComponent(voucherId));
        }

        function updateDiscountAndTotal(discountAmount, totalAmount) {
            document.getElementById("discountAmount").textContent = discountAmount + "₫";
            document.getElementById("totalAmount").textContent = totalAmount + "₫";
            $('#voucherModal').css('display', 'none');
            $('body').removeClass('modal-open');
        }

        // Open Modal
        var applyButton = document.querySelector('.apply');
        applyButton.addEventListener("click", function () {
            $('#voucherModal').css('display', 'block');
            $('body').addClass('modal-open');
        });

        // Close Modal
        var modalClose = document.querySelector('.modal .close');
        modalClose.addEventListener("click", function () {
            $('#voucherModal').css('display', 'none');
            $('body').removeClass('modal-open');
        });

        // Handle voucher item click
        $(".voucher-item").on("click", function () {
            $(".voucher-item").removeClass("selected");
            $(this).addClass("selected");
            selectedVoucher = $(this).data("voucher");
        });
    });
</script>

<!-- Add jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // Kiểm tra giỏ hàng trống khi trang vừa tải
        checkEmptyCart();

        // Mở modal khi click vào "Chọn hoặc nhập mã"
        $('.apply').on('click', function (event) {
            event.preventDefault();
            $('#voucherModal').css('display', 'block');
            $('body').addClass('modal-open');
        });

        // Đóng modal khi click vào nút đóng
        $('.close').on('click', function () {
            $('#voucherModal').css('display', 'none');
            $('body').removeClass('modal-open');
        });

        // Đóng modal khi click ra ngoài modal
        $(window).on('click', function (event) {
            if ($(event.target).is('#voucherModal')) {
                $('#voucherModal').css('display', 'none');
                $('body').removeClass('modal-open');
            }
        });

        // Handle voucher item click
        $(".voucher-item").on("click", function () {
            var radioButton = $(this).find("input[type='radio']");

            // Kiểm tra trạng thái của radio button
            if (radioButton.prop("checked")) {
                // Nếu đã được chọn, bỏ chọn lại
                radioButton.prop("checked", false);
                $(this).removeClass("selected");
            } else {
                // Bỏ chọn tất cả các voucher khác trước khi chọn mới
                $(".voucher-item").removeClass("selected");
                $("input[type='radio'][name='voucher']").prop("checked", false);

                // Chọn voucher và đánh dấu màu viền
                radioButton.prop("checked", true);
                $(this).addClass("selected");
            }
        });
        // Handle voucher item click
        $(".voucher-item").on("click", function () {
            $(".voucher-item").removeClass("selected");
            $(this).addClass("selected");
            selectedVoucher = $(this).data("voucher");
        });
        // Handle radio button click
        $("input[type='radio'][name='voucher']").on("change", function () {
            if ($(this).prop("checked")) {
                // Bỏ chọn tất cả các voucher khác trước khi chọn mới
                $(".voucher-item").removeClass("selected");
                $("input[type='radio'][name='voucher']").prop("checked", false);

                // Đánh dấu màu viền cho voucher được chọn
                $(this).closest(".voucher-item").addClass("selected");
            } else {
                // Nếu không được chọn, loại bỏ màu viền
                $(this).closest(".voucher-item").removeClass("selected");
            }
        });

        // Kích hoạt nút "ÁP DỤNG" khi nhập mã voucher
        $('#voucherCode').on('input', function () {
            var code = $(this).val().trim();
            if (code) {
                $('#applyVoucher').prop('disabled', false).addClass('active');
            } else {
                $('#applyVoucher').prop('disabled', true).removeClass('active');
            }
        });

        // Handle voucher code input
        $("#voucherCode").on("input", function () {
            var input = $(this).val().toLowerCase();
            var found = false;

            $(".voucher-item").each(function () {
                var voucherCode = $(this).data("voucher").toLowerCase();
                if (voucherCode.includes(input)) {
                    $(this).show();
                    found = true;
                } else {
                    $(this).hide();
                }
            });

            if (!found) {
                $("#errorMessage").show();
                $("#applyVoucher").prop("disabled", true); // Disable the button if no voucher found
            } else {
                $("#errorMessage").hide();
                $("#applyVoucher").prop("disabled", false); // Enable the button if voucher found
            }
        });
    });

    function updateQuantity(key, action) {
        $.ajax({
            type: "GET",
            url: action + "?key=" + key,
            success: function (response) {
                // Cập nhật số lượng trong UI
                $("#updates_" + key).val(response.quantity);
                // Cập nhật tổng giá tiền cho sản phẩm
                $(".total-price_" + key).text(response.totalPrice + "₫");
                // Cập nhật tổng tiền trong UI
                var totalAmount = response.totalAmount;
                $('.total-amount').text(totalAmount + '₫');
                checkEmptyCart();
            }
        });
    }

    $(document).ready(function () {
        // Function to handle increasing quantity
        $(".increase-btn").click(function (e) {
            e.preventDefault();
            var key = $(this).data("key");
            updateQuantity(key, "IncreaseQControll");
        });

        // Function to handle decreasing quantity
        $(".decrease-btn").click(function (e) {
            e.preventDefault();
            var key = $(this).data("key");
            updateQuantity(key, "DecreaseQControll");
        });

        // Function to handle removing item from the cart
        $(".remove-btn").click(function (e) {
            e.preventDefault();
            var key = $(this).data("key");
            $.ajax({
                type: "GET",
                url: "DeleteOrderControll?key=" + key,
                success: function (response) {
                    // Remove the row from the cart in the UI
                    $("#row_" + key).remove();
                    // Update the total amount in the UI
                    var totalAmount = response.totalAmount;
                    $('.total-amount').text(totalAmount + '₫');
                    // Update cart size in the UI
                    $("#cart-count").text(response.sizeCart);
                    // Cập nhật voucher
                    // updateVouchers(response.vouchers);
                    // Kiểm tra giỏ hàng rỗng
                    checkEmptyCart();
                }
            });
        });
    });

    function toggleCartDisplay(isEmpty) {
        var cartTable = $(".shoping__cart__table");
        var emptyCartMessage = $(".empty-cart-message");
        var checkoutSection = $(".shoping__checkout");
        var continueSection = $(".shoping__continue");
        var cartBtnsSection = $(".shoping__cart__btns");

        if (isEmpty) {
            cartTable.hide();
            emptyCartMessage.show();
            checkoutSection.hide();
            continueSection.hide();
            cartBtnsSection.hide();
        } else {
            cartTable.show();
            emptyCartMessage.hide();
            checkoutSection.show();
            continueSection.show();
            cartBtnsSection.show();
        }
    }

    function checkEmptyCart() {
        var cartTable = $(".shoping__cart__table");
        var isEmpty = $(".shoping__cart__table table tbody tr").length === 0;

        toggleCartDisplay(isEmpty);
    }


</script>

</body>
</html>