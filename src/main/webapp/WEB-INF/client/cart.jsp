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
        .header__fixed {
            position: fixed;
            top: 0;
            width: 100%;
            height: 140px;
            background-color: #f5f5f5;
            z-index: 900;
            /*box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.4);*/
        }
    </style>
</head>

<body>

<span class="header__fixed">
    <jsp:include page="header/header.jsp"></jsp:include>
</span>

<!-- Shoping Cart Section Begin -->
<div style="height: 140px"></div>
<br>
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="empty-cart-message" style="display: none;">
                    <div class="img" style="text-align: center; line-height: 50vh;">
                        <img alt="" src="assets/img/empty-cart.svg" style="vertical-align: middle;">
                        <h3><b>Giỏ hàng rỗng</b></h3>
                        <p>Hiện tại bạn chưa có sản phẩm nào trong giỏ hàng. Hãy dạo quanh cửa hàng để chọn được sản phẩm ưng ý nhé!</p>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__btn" style=" display: block; margin: 0 auto; text-align: center;">
                                <c:url var="showProduct" value="ShowProductControl"></c:url>
                                <a href="${pageContext.request.contextPath}/${showProduct}" class="primary-btn cart-btn">Tiếp tục mua sắm</a>
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
                                            <input type="text" value="${o.value.quantity}" min="1" id="updates_${o.key}" readonly>
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
                            <input type="hidden" id="discountValue" value="0"> <!-- Thêm input ẩn để lưu giá trị giảm giá -->
                            <input type="hidden" id="originalTotalAmount" value="${total}"> <!-- Thêm input ẩn để lưu tổng tiền gốc -->
                            <button type="button" class="site-btn" onclick="applyDiscountIfCouponExists()">Áp dụng</button>
                            <div id="discountError" style="color: red; display: none;">Mã giảm giá không tồn tại</div> <!-- Thêm phần tử để hiển thị thông báo lỗi -->
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="shoping__checkout">
                    <h5>Thanh Toán</h5>
                    <ul>
                        <li>Tạm tính <span></span></li>
                        <li>Ship <span></span></li>
                        <li>Tổng <span id="totalAmount" class="total-amount">${total}₫</span></li>
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

<!-- Footer Section Begin -->
<jsp:include page="./footer/footer.jsp"></jsp:include>

<!-- Add jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Kiểm tra giỏ hàng trống khi trang vừa tải
        checkEmptyCart();
        $("#couponCode").on("input", function() {
            var couponCode = $(this).val().trim();
            if (couponCode === "") {
                $('#discountError').hide(); // Ẩn thông báo lỗi khi không có mã giảm giá
            }
        });
    });

    function applyDiscountIfCouponExists() {
        var couponCode = $("#couponCode").val().trim();
        if (couponCode !== "") {
            applyDiscount();
            $('#discountError').show(); // Hiển thị thông báo lỗi

        } else {
            // Ẩn thông báo lỗi khi không có mã giảm giá
            applyDiscount();
            $('#discountError').hide();

        }
    }
    function applyDiscount() {
        var couponCode = document.getElementById('couponCode').value;
        var quantity = document.getElementById('quantity').value; // Lấy số lượng sản phẩm
        var totalAmount = parseFloat($('#originalTotalAmount').val()); // Lấy giá trị tổng tiền gốc (chưa giảm giá)

        $.ajax({
            type: "POST",
            url: "CheckDiscountServlet",
            data: { couponCode: couponCode, quantity: quantity, totalAmount: totalAmount },
            success: function(response) {
                if (response.valid) {
                    var discountedPrice = response.discountedPrice;
                    $('.total-amount').text(discountedPrice + '₫');
                    $('#discountValue').val(response.discountValue); // Lưu giá trị giảm giá vào input ẩn
                    $('#discountError').hide();

                } else {
                    $('#discountValue').val(0); // Đặt giá trị giảm giá về 0 nếu mã không hợp lệ
                    $('.total-amount').text(totalAmount + '₫'); // Hiển thị lại tổng tiền gốc nếu mã không hợp lệ
                    $('#discountError').text(response.error); // Hiển thị thông báo lỗi
                }
            },
            error: function(xhr, status, error) {
                console.error("Lỗi khi gửi yêu cầu kiểm tra mã giảm giá: " + error);
            }
        });
    }


    function cancelDiscount() {
        var totalAmount = parseFloat($('#originalTotalAmount').val()); // Lấy giá trị tổng tiền gốc (chưa giảm giá)
        $('#discountValue').val(0); // Đặt giá trị giảm giá về 0
        $('.total-amount').text(totalAmount + '₫'); // Hiển thị lại tổng tiền gốc
        $('#couponCode').val(''); // Xóa mã giảm giá
        $('#discountError').hide(); // Ẩn thông báo lỗi
    }

    function updateQuantity(key, action) {
        $.ajax({
            type: "GET",
            url: action + "?key=" + key,
            success: function(response) {
                // Cập nhật số lượng trong UI
                $("#updates_" + key).val(response.quantity);
                // Cập nhật tổng giá tiền cho sản phẩm
                $(".total-price_" + key).text(response.totalPrice + "₫");
                // Cập nhật tổng số tiền
                var totalAmount = response.totalAmount;
                // Lưu lại tổng số tiền gốc vào input ẩn để sử dụng cho việc tính toán giảm giá
                $('#originalTotalAmount').val(totalAmount);
                // Cập nhật tổng tiền trong UI
                $('.total-amount').text(totalAmount + '₫');
                // Áp dụng lại mã giảm giá nếu có
                applyDiscountIfCouponExists();

                checkEmptyCart();
            }
        });
    }

    $(document).ready(function() {
        // Function to handle increasing quantity
        $(".increase-btn").click(function(e) {
            e.preventDefault();
            var key = $(this).data("key");
            updateQuantity(key, "IncreaseQControll");
        });

        // Function to handle decreasing quantity
        $(".decrease-btn").click(function(e) {
            e.preventDefault();
            var key = $(this).data("key");
            updateQuantity(key, "DecreaseQControll");
        });

        // Function to handle removing item from the cart
        $(".remove-btn").click(function(e) {
            e.preventDefault();
            var key = $(this).data("key");
            $.ajax({
                type: "GET",
                url: "DeleteOrderControl?key=" + key,
                success: function(response) {
                    // Remove the row from the cart in the UI
                    $("#row_" + key).remove();
                    // Update the total amount in the UI
                    $(".total-amount").text(response.totalAmount + "₫");
                    // Update cart size in the UI
                    $("#cart-count").text(response.sizeCart);
                    // Save the original total amount to a hidden input for discount calculations
                    $('#originalTotalAmount').val(response.totalAmount);

                    // Apply discount if there is any coupon
                    applyDiscountIfCouponExists();

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