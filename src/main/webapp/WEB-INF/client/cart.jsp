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
        .header__fixed{
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
                                <b>Cart is Empty></b>
                            </h3>
                            <p>Hiện tại bạn chưa có sản phẩm nào trong giỏ hàng. Hãy dạo quanh cửa hàng để chọn được sản
                                phẩm ưng ý nhé!</p>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="shoping__cart__btns"
                                     style=" display: block;margin: 0 auto;text-align: center;">
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
                            <tr>
                                <td class="shoping__cart__item"><a
                                        href="DetailControl?pid=${o.value.product.id}"> <img
                                        style="width: 73px; height: auto;"
                                        src="${o.value.product.image}" width="150px" height="60px"></a>
                                    <a href="DetailControl?pid=${o.value.product.id}">
                                        <h5>${o.value.product.name}</h5>
                                    </a></td>
                                <td class="shoping__cart__price">${o.value.product.price}₫</td>
                                <td class="shoping__cart__quantity"><c:url var="decrease"
                                                                           value="DecreaseQControl"></c:url> <a
                                        href="${decrease}?key=${o.key}">
                                    <button style="border-radius: 6px;" name="minus" value="minus" type="button">-
                                    </button>
                                </a> <input style="width: 40px;text-align: center;border-radius: 8px;" type="text"
                                            value="${o.value.quantity}" name="Lines"
                                            id="updates_6383545" min="1" readonly> <c:url
                                        var="increase" value="IncreaseQControll"></c:url> <a
                                        href="${increase}?key=${o.key}">
                                    <button style="border-radius: 6px;" name="add" value="add" type="button">+</button>
                                </a></td>
                                <td class="shoping__cart__total"><c:set var="sumAll"
                                                                        value="${o.value.quantity*o.value.price}"></c:set>
                                        ${o.value.price}</td>
                                <c:url var="delete" value="DeteleOrderControll"></c:url>
                                <td class="text-center"><a
                                        class="fa fa-trash-o item-remove"
                                        href="${delete}?key=${o.key}"></a></td>

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
                        <h5>Discount Codes</h5>
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
                        <li>Tổng tiền: <span>${total}₫</span></li>
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


<!-- Js Plugins -->

</body>

</html>