<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Out</title>
    <!-- Css Styles -->
    <jsp:include page="./link/link.jsp"></jsp:include>

    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            padding-bottom: 5vh;
        }

        td {
            padding-top: 10px;
            padding-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="./header/header.jsp"></jsp:include>
<c:url var="pay" value="/OrderControll"></c:url>

<!-- Checkout Section Begin -->
<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <h4>Thanh toán</h4>
            <form action="${pay}" method="get">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Họ và tên<span>*</span></p>
                                    <input type="text" name="name" value="${name}">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Số điện thoại<span>*</span></p>
                                    <input type="tel" name="phone" value="${phone}">
                                </div>
                            </div>
                        </div>
                        <div class="checkout__input">
                            <p>Email<span>*</span></p>
                            <input type="email" name="email" value="${email}" style="width: 70%;">
                        </div>
                        <div class="checkout__input">
                            <p>Điạ chỉ<span>*</span></p>
                            <input type="text" name="address" placeholder="Địa chỉ" class="checkout__input__add"
                                   required="required">
                        </div>
                        <div class="checkout__input">
                            <p>Ghi chú<span></span></p>
                            <input type="text" name="notes" value=""
                                   placeholder="Ghi chú">
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order" style="box-shadow: 0px 0px 6px 0px rgba(0, 0, 0, 0.2);">
                            <h4>Danh sách order</h4>
                            <p>${sessionScope.cart.OrderDetail.id}</p>
                            <table>
                                <thead>
                                <tr>
                                    <th class="shoping__product">Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Tạm tính</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${sessionScope.cart}" var="o">
                                    <tr>
                                        <td class="shoping__cart__item" style="text-align: left;">
                                            <b>${o.value.product.name}</b>
                                        </td>
                                        <td class="shoping__cart__price">${o.value.product.price}₫</td>
                                        <td class="shoping__cart__quantity" style="">${o.value.quantity}</td>
                                        <td class="shoping__cart__total" style="">
                                            <c:set var="sumAll" value="${o.value.quantity*o.value.price}"></c:set>
                                                ${o.value.price}
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <%--                                <div class="checkout__order__subtotal">${showLanguage['Checkout.Sub']} <span>${total}</span></div>--%>
                            <%--                                <div class="checkout__order__total">${showLanguage['Checkout.Ship']}<span>${ship}</span></div>--%>
                            <div class="checkout__order__total">Tổng: <span>${sum}</span></div>
                            <p>Ship</p>
                            <c:url var="pay" value="OrderControll"></c:url>
                            <input style="padding: 10px 100px 10px;border: none;" type="submit" class="primary-btn"
                                   value="Thanh toán">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- Checkout Section End -->

<!-- Js Plugins -->
<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>
</html>