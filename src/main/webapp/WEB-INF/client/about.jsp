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
    <title><c:out value="${showLanguage['Menu.Introduce']}" /></title>

    <jsp:include page="./link/link.jsp" />
    <style>
        .container h3, .container h4 {
            font-family: Courier;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <jsp:include page="./header/header.jsp" />

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <header>
                    <h3><c:out value="${showLanguage['Introduce.h3']}" /></h3>
                    <p></p>
                </header>

                <section>
                    <h4><c:out value="${showLanguage['Introduce.h4_1']}" /></h4>
                    <p><c:out value="${showLanguage['Introduce.p_1']}" /></p> 
                    <h4><c:out value="${showLanguage['Introduce.h4_2']}" /></h4>
                    <p><c:out value="${showLanguage['Introduce.p_2']}" /></p>
                    <h4><c:out value="${showLanguage['Introduce.h4_3']}" /></h4>
                    <p><c:out value="${showLanguage['Introduce.p_3']}" /></p>
                    <h4><c:out value="${showLanguage['Introduce.h4_4']}" /></h4>
                    <p><c:out value="${showLanguage['Introduce.p_4']}" /></p>
                    <h4><c:out value="${showLanguage['Introduce.h4_5']}" /></h4>
                    <p><c:out value="${showLanguage['Introduce.p_5']}" /></p>
                </section>
            </div>

            <div class="col-lg-4">
                <img src="client/assets/img/introduce.png" style="padding-top: 50px;" />
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="./footer/footer.jsp" />
</body>

</html>
