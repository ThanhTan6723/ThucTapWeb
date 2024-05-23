<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HP-5C
  Date: 23/05/2024
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%@page isELIgnored="false" %>
    <title>Title</title>
</head>
<body>
<tbody>
<c:forEach var="o" items="${listInventory}">
    <tr style="text-align: center">
        <td>${o.id}</td>
        <td>${o.name}</td>
        <td>
            <img src="${o.image}" alt="${o.name}" style="width: 80px;height: 70px;border-radius: 5%">
        </td>
        <td>${o.price}</td>
        <td>${productTotalQuantities[o.id]}</td>
        <td>${productCurrentQuantities[o.id]}</td>
        <td>${pStillExpired[o.id]}</td>
        <td>${pAlmostExpired[o.id]}</td>
        <td>${productExpiredCurrentQuantities[o.id]}</td>
    </tr>
</c:forEach>
</tbody>
</body>
</html>
