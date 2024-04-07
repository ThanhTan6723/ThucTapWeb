<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<%@page import="java.util.Map" %>
<%@page import="dao.client.I18NDAO" %>

<c:set var="showLanguage" value="<%= new dao.client.I18NDAO().vietnameseLanguage() %>" />
<c:if test="${not empty sessionScope.lang}">
    <c:choose>
        <c:when test="${sessionScope.lang eq 'Vietnamese'}">
            <c:set var="showLanguage" value="<%= new dao.client.I18NDAO().vietnameseLanguage() %>" />
        </c:when>
        <c:when test="${sessionScope.lang eq 'English'}">
            <c:set var="showLanguage" value="<%= new dao.client.I18NDAO().englishLanguage() %>" />
        </c:when>
    </c:choose>
</c:if>
<c:set var="showLanguage" scope="page" value="${showLanguage}" />

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>${detail.name}</title>
<style type="text/css">
	.productdetail{
	height: 60vh;
	padding-top: 10vh;
	}

</style>

<jsp:include page="./link/link.jsp"></jsp:include>

</head>
<body>
	<div class="page">
		<jsp:include page="./header/header.jsp"></jsp:include>
		<!-- Main Content -->
<div class="productdetail">
    <div class="container">
        <div class="row">
            <article class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sk-product-detail-content-col">
                <div class="row sk-sigle-content product-view" itemtype="http://schema.org/Product">
                    <div class="col-md-6 col-sm-12 col-xs-12">
                        <div class="sk-product-slider-wrap">
                            <div class="product-img-box" >
                                <img src="${detail.image}" alt="" width="300px" height="300px">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12">
                        <div class="sk-page-detail-title">
                            <h3 itemprop="name" class="pd-name"><b><c:out value="${detail.name}" /></b></h3><br>
                        </div>
                        <div class="sk-price-box clearfix">
                            <div class="pull-left">
                                <span><h5><c:out value="${showLanguage['Checkout.Price']}" />:</span> <span class="price"><b><c:out value="${detail.price}$" /></b></h5></span><br>
                                <span><c:out value="${showLanguage['Detail.Id']}" />: </span> <span class="pid"><c:out value="${detail.id}" /></span><br>
                            </div>
                        </div>

                        <p><c:out value="${detail.description}" /></p>

                        <div class="pd-form-bottom clearfix">
                            <h5><c:out value="${showLanguage['Checkout.Quantity']}" /></h5>
                            <c:url var="addToCart" value="AddToCartControl"></c:url>
                            
							<form action="${addToCart}?pid=${detail.id}" method="post">
                                <input style="width: 80px; border-radius: 5px; text-align: center;" type="number" class="single-input-selector" value="1"
                                    min="1" max="99" name="quantity" placeholder="">
                                <button style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; text-transform: uppercase; font-weight: 700; color: #fff"
                                    type="submit" class="button" title="Mua">
                                    <span>Mua</span>
                                </button>
                            </form>
                        </div>
                        <br>
                        <div class="sk-hotline-block">
                            <span><c:out value="${showLanguage['Detail.Text']}" /></span>
                            <div class="sk-widget-title pink-bg-widget">
                                <h5>
                                    <c:out value="${showLanguage['Detail.Text1']}" />: <a href="tel:0963647129">0963647129</a>
                                </h5>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </div>
</div>
<!-- End Main Content -->
		<jsp:include page="./footer/footer.jsp"></jsp:include>
	</div>
</body>
</html>