<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <%@ page isELIgnored="false" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin-Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Include jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- plugins:css -->
    <jsp:include page="link/link.jsp"></jsp:include>
    <style>
        .page-btn {
            padding: 10px 23px;
            border-radius: 5px;
            border: none;
            background-color: whitesmoke;
            color: black;
            font-weight: 700;
        }

        .page-btn.active {
            background-color: #7fad39;
            color: white;
        }

    </style>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_sidebar.html -->
    <jsp:include page="header/sidebar.jsp"></jsp:include>

    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="header/navbar.jsp"></jsp:include>
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Bordered table</h4>
                    <br><br>
                    <p class="card-description"> <code>Danh sách sản phẩm tồn kho</code> </p>
                    <div class="table-responsive">
                        <table id="inventoryTable" class="table table-bordered">
                            <thead>
                            <tr style="text-align: center">
                                <th>Mã </th>
                                <th>Tên sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Giá tiền</th>
                                <th>Số lượng nhập</th>
                                <th>Còn lại</th>
                                <th>Sản phẩm còn hạn</th>
                                <th>Sản phẩm sắp hết hạn</th>
                                <th>Sản phẩm hết hạn</th>
                            </tr>
                            </thead>
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
                        <div class="paging" style="padding-left: 500px;padding-top: 20px;">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <button class="page-btn ${i == 1 ? 'active' : ''}" onclick="loadPage(${i})">
                                    <span>${i}</span>
                                </button>
                            </c:forEach>
                        </div>


                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="./footer/footer.jsp"></jsp:include>
        <!-- partial -->
    </div>
    <!-- main-panel ends -->
</div>

<script>
    function loadPage(page) {
        $.ajax({
            url: 'InventoryProduct?page=' + page, // Bao gồm tham số page trong URL
            type: 'GET',
            success: function(response) {
                $('#inventoryTable tbody').html(response);
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }

    // Gọi hàm loadPage(1) khi trang được tải xong để mặc định hiển thị trang đầu tiên
    document.addEventListener('DOMContentLoaded', function() {
        loadPage(1);
    });
    document.addEventListener('DOMContentLoaded', function() {
        var buttons = document.querySelectorAll('.page-btn');
        buttons.forEach(function(button) {
            button.addEventListener('click', function() {
                buttons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
            });
        });
    });

</script>


</body>
</html>