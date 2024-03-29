<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<html lang="UTF-8">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lien he</title>

     <jsp:include page="./link/link.jsp"></jsp:include>

</head>

<body>
    <jsp:include page="./header/header.jsp"></jsp:include>

    <!-- Contact Section Begin -->
<section class="contact spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                <div class="contact__widget">
                    <span class="icon_phone"></span>
                    <h4><c:out value="${showLanguage['Contact.Phone']}" /></h4>
                    <p>+01-3-8888-6868</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                <div class="contact__widget">
                    <span class="icon_pin_alt"></span>
                    <h4><c:out value="${showLanguage['Contact.Address']}" /></h4>
                    <p>60-49 Road 11378 New York</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                <div class="contact__widget">
                    <span class="icon_clock_alt"></span>
                    <h4><c:out value="${showLanguage['Contact.Open']}" /></h4>
                    <p>10:00 am to 23:00 pm</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                <div class="contact__widget">
                    <span class="icon_mail_alt"></span>
                    <h4><c:out value="${showLanguage['Contact.Email']}" /></h4>
                    <p>hello@colorlib.com</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Contact Section End -->

<!-- Map Begin -->
<div class="map">
    <iframe
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d49116.39176087041!2d-86.41867791216099!3d39.69977417971648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x886ca48c841038a1%3A0x70cfba96bf847f0!2sPlainfield%2C%20IN%2C%20USA!5e0!3m2!1sen!2sbd!4v1586106673811!5m2!1sen!2sbd"
        height="500" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
    <div class="map-inside">
        <i class="icon_pin"></i>
        <div class="inside-widget">
            <h4>Hoang Dieu</h4>
            <ul>
                <li><c:out value="${showLanguage['Contact.Phone']}" />: +12-345-6789</li>
                <li>Add: 16 Creek Ave. Farmingdale, NY</li>
            </ul>
        </div>
    </div>
</div>
<!-- Map End -->

<!-- Contact Form Begin -->
<div class="contact-form spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="contact__form__title">
                    <h2><c:out value="${showLanguage['Contact.M']}" /></h2>
                </div>
            </div>
        </div>
        <form action="#">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <input type="text" placeholder="<c:out value="${showLanguage['Contact.YName']}" />">
                </div>
                <div class="col-lg-6 col-md-6">
                    <input type="text" placeholder="<c:out value="${showLanguage['Contact.YEmail']}" />">
                </div>
                <div class="col-lg-12 text-center">
                    <textarea placeholder="<c:out value="${showLanguage['Contact.YMessage']}" />"></textarea>
                    <button type="submit" class="site-btn"><c:out value="${showLanguage['Contact.Submit']}" /></button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- Contact Form End -->

    <jsp:include page="./footer/footer.jsp"></jsp:include>
</body>

</html>