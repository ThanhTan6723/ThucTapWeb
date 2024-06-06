<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Bill Detail</title>
    <!-- plugins:css -->
    <jsp:include page="./link/link.jsp"></jsp:include>
    <!-- Include Bootstrap Icons CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
    <style>
        tr, td {
            color: white;

            .table-hover:hover {
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */
                transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */

            }
        }
        .back-button {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-button i {
            margin-right: 8px;
        }

    </style>
</head>
<body>
<div class="container-scroller">
    <jsp:include page="./header/sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="./header/navbar.jsp"></jsp:include>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <!-- Back Button -->
                                    <div class="back-button">
                                        <a href="#" class="btn btn-light" id="back-button">
                                            <i class="bi bi-arrow-left"></i>
                                            Trở về
                                        </a>

                                    </div>
                                    <h4 class="card-title">Chi tiết đơn hàng</h4>
                                    <p>Mã đơn hàng: <span style="color: springgreen">${listBillDetails[0].order.id}</span></p>
                                    <p>Tổng số lượng: ${sumQ}</p>
                                    <p>Tổng tiền: ${listBillDetails[0].order.totalMoney}</p>
                                    <p>Trạng thái: <span style="color: #00d25b;">${listBillDetails[0].order.orderStatus}</span></p>

                                    <table class="table table-hover custom-table">
                                        <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="b" items="${listBillDetails}" varStatus="stt">
                                            <tr>
                                                <td>${stt.index + 1}</td>
                                                <td>${b.product.name}</td>
                                                <td>${b.product.price}</td>
                                                <td>${b.quantity}</td>
                                                <td>${b.price}</td>

                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="./footer/footer.jsp"></jsp:include>
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<script>
    document.getElementById('back-button').addEventListener('click', function() {
        // Lấy tab hiện tại từ localStorage
        var activeTab = localStorage.getItem('activeTab') || 'all';
        // Điều hướng quay lại trang chính với tham số tab
        window.location.href = './LoadBillControll?tab=' + activeTab;
    });
</script>
</body>
</html>