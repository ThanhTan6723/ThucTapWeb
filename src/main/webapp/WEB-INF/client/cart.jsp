<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
            background-color: #fff;
            z-index: 900;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.4);
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
                <div class="shoping__cart__table">
                    <c:if test="${empty sessionScope.cart}">
                        <div class="img" style="text-align: center; line-height: 50vh;">
                            <img alt="" src="assets/img/empty-cart.svg"
                                 style="vertical-align: middle;">
                            <h3>
                                <b>Giỏ hàng rỗng</b>
                            </h3>
                            <p>Hiện tại bạn chưa có sản phẩm nào trong giỏ hàng. Hãy dạo quanh cửa hàng để chọn được sản
                                phẩm ưng ý nhé!</p>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="shoping__cart__btns"
                                     style=" display: block; margin: 0 auto; text-align: center;">
                                    <c:url var="showProduct" value="ShowProductControl"></c:url>
                                    <a href="${pageContext.request.contextPath}/${showProduct}"
                                       class="primary-btn cart-btn">Tiếp tục mua sắm</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
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
                        <h5>Mã giảm giá</h5>
                        <form action="#">
                            <input type="text" placeholder="Enter your coupon code">
                            <button type="submit" class="site-btn">Áp dụng</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="shoping__checkout">
                    <h5>Chi tiết thanh toán</h5>
                    <ul>
                        <li>Tổng tiền: <span class="total-amount">${total}₫</span></li>
                    </ul>
                    <c:url var="checkout" value="CheckOutControll"></c:url>
                    <a href="${pageContext.request.contextPath}/${checkout}"
                       class="primary-btn">Thanh toán</a>
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

<!-- Add JavaScript for AJAX functionality -->
<script>
    $(document).ready(function() {
        // Function to handle increasing quantity
        $(".increase-btn").click(function(e) {
            e.preventDefault();
            var key = $(this).data("key");
            $.ajax({
                type: "GET",
                url: "IncreaseQControll?key=" + key,
                success: function(response) {
                    // Update the quantity in the UI
                    $("#updates_" + key).val(response.quantity);
                    // Update the total price for the item
                    $(".total-price_" + key).text(response.totalPrice + "₫");
                    // Update the total amount
                    $(".total-amount").text(response.totalAmount + "₫");
                }
            });
        });

        // Function to handle decreasing quantity
        $(".decrease-btn").click(function(e) {
            e.preventDefault();
            var key = $(this).data("key");
            $.ajax({
                type: "GET",
                url: "DecreaseQControl?key=" + key,
                success: function(response) {
                    // Update the quantity in the UI
                    $("#updates_" + key).val(response.quantity);
                    // Update the total price for the item
                    $(".total-price_" + key).text(response.totalPrice + "₫");
                    // Update the total amount
                    $(".total-amount").text(response.totalAmount + "₫");
                }
            });
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
                }
            });
        });
    });
</script>

</body>
</html>
