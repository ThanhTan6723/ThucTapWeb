<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <%@ page isELIgnored="false" %>
    <title>Title</title>
</head>
<body>
<table id="inventoryTable" class="table table-bordered">
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
            <td>${productCurrentQuantities[o.id]}  </td>
            <td>${pStillExpired[o.id]}</td>
            <td>${pAlmostExpired[o.id]}</td>
            <td>${productExpiredCurrentQuantities[o.id]}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
