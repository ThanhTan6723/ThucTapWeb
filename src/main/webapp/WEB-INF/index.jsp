<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.Map" %>
<%@ page import="dao.client.I18NDAO" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    Map<String, String> showLanguage = new dao.client.I18NDAO().vietnameseLanguage();
    String lang = (String) session.getAttribute("lang");
    if (lang != null) {
        if (lang.equals("Vietnamese")) {
            showLanguage = new dao.client.I18NDAO().vietnameseLanguage();
        } else if (lang.equals("English")) {
            showLanguage = new dao.client.I18NDAO().englishLanguage();
        }
    }
    pageContext.setAttribute("showLanguage", showLanguage);
%>

<c:set var="showLanguage" scope="page" value="${showLanguage}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <jsp:include page="client/link/link.jsp"></jsp:include>
</head>
<body>
<!-- Header Section Begin -->
<jsp:include page="client/header/header.jsp"></jsp:include>
<!-- Categories Section Begin -->
<div class="hero__item set-bg">
    <img src="assets/img/hero/banner.jpg" style="padding-left: 100px;padding-right: 200px;width:900px">
    <div class="hero__text">
        <span style="font-size: 50px"><%=showLanguage.get("Index.Text")%></span>
        <h2><br/><%=showLanguage.get("Index.Text1")%>
        </h2>
        <p><%=showLanguage.get("Index.Text2")%>
        </p>
    </div>
</div>
<section class="categories">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <div class="col-lg-3">
                    <div class="categories__item set-bg"
                         data-setbg="client/assets/img/categories/cat-1.jpg">
                        <h5>
                            <a href="#">Fresh Fruit</a>
                        </h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg"
                         data-setbg="client/assets/img/categories/cat-2.jpg">
                        <h5>
                            <a href="#">Dried Fruit</a>
                        </h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg"
                         data-setbg="client/assets/img/categories/cat-3.jpg">
                        <h5>
                            <a href="#">Vegetables</a>
                        </h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg"
                         data-setbg="client/assets/img/categories/cat-4.jpg">
                        <h5>
                            <a href="#">drink fruits</a>
                        </h5>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="categories__item set-bg"
                         data-setbg="client/assets/img/categories/cat-5.jpg">
                        <h5>
                            <a href="#">drink fruits</a>
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Categories Section End -->

<!-- Blog Section End -->

<!-- Footer Section Begin -->
<jsp:include page="client/footer/footer.jsp"></jsp:include>
<!-- Footer Section End -->

<!-- Js Plugins -->


</body>

</html>