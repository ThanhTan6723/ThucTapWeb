
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@page isELIgnored="false" %>
    <title>Title</title>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="detail" value="DetailControl"></c:url>
<div class="row" id="content">
    <c:forEach items="${listProducts}" var="o">
        <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
            <div class="featured__item">
                <div class="featured__item__pic set-bg" >
                    <a href="${detail}?pid=${o.id}">
                        <img src="${o.image}" alt="${o.name}">
                    </a>
                </div>
                <div class="featured__item__text">
                    <a class="product-name" href="${detail}?pid=${o.id}" style="color: black">
                            ${o.name}</a>
                    <h5>${o.price}</h5>
                </div>
                <div class="text-center">
                    <c:url var="addToCart" value="/AddToCartControl"></c:url>
                    <form action="${addToCart}?pid=${o.id}" method="post" enctype="multipart/form-data">
                        <button
                                style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; font-weight: 700"
                                type="submit">
                            <a href="${detail}?pid=${o.id}" style="color:#ffffff">
                                MUA NGAY</a>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
