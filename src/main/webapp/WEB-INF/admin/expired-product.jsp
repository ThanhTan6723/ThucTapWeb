<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <%@ page isELIgnored="false" %>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin-Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- plugins:css -->
    <jsp:include page="link/link.jsp"></jsp:include>
    <style>
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

                    <p class="card-description">  <code>Danh sách sản phẩm hết hạn</code>
                    </p>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr style="text-align: center">
                                <th>Mã </th>
                                <th>Tên sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Giá tiền</th>
                                <th>Ngày nhập</th>
                                <th>Hạn sử dụng</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="o" items="${listExpiredProduct}">
                                <tr style="text-align: center">
                                    <td>${o.id}</td>
                                    <td> ${o.name} </td>
                                    <td>
                                          <img src="${o.image}" alt=" ${o.name}" style="width: 80px;height: 70px;border-radius: 5%">
                                    </td>
                                    <td>  ${o.price} </td>
                                    <td> ${o.dateOfImporting}  </td>
                                    <td>  ${o.expriredDay}  </td>
                                    <td class="function-product" style="text-align: center">
                                        <a href="#" class="delete-product" data-id="${o.id}">
                                            <i class="fa-solid fa-trash" style="color: #efe63a;font-size: 20px;"></i>
                                        </a>
                                        <a href="DetailProductControll?id=${o.id}"><i class="fa-solid fa-eye" style="color:white; font-size: 20px; margin-left: 20px;"></i></a> </td>
                                </tr>
                            </c:forEach>
                           </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
            <jsp:include page="./footer/footer.jsp"></jsp:include>

            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>

<script>
    $(document).ready(function() {
        $('.delete-product').click(function(event) {
            event.preventDefault();

            var id = $(this).data('id');

            $.ajax({
                url: 'DeleteExpiredProduct?id=' + id,
                type: 'GET',
                success: function(response) {
                    $(event.target).closest('tr').remove();
                }
            });
        });
    });
</script>

</body>


</html>