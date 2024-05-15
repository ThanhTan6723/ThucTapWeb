<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<%@ page isELIgnored="false" %>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Of Users</title>
<!-- plugins:css -->
<jsp:include page="./link/link.jsp"></jsp:include>
<style>

    tr,td {
        color: white;

        .table-hover:hover {

            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */
            transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */

        }
    }
</style>
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
                                    <h4 class="card-title">List Users</h4>

                                    <table class="table table-hover custom-table">
                                        <thead>
                                        <tr>
                                            <th scope="col" style="color:white;font-weight: bold;">STT</th>
                                            <th scope="col" style="color:white;font-weight: bold;">Tên</th>
                                            <th scope="col" style="color:white;font-weight: bold;">Mật khẩu</th>
                                            <th scope="col" style="color:white;font-weight: bold;">Email</th>
                                            <th scope="col" style="color:white;font-weight: bold;">Số điện thoại</th>
                                            <th scope="col" style="color:white;font-weight: bold;">Hành động</th>
                                        </tr>
                                        </thead>
                                        <tbody id="user-table-body">
                                        <c:forEach items="${accounts}" var="o" varStatus="stt">
                                            <tr id="row_${o.id}">
                                                <td scope="row">${stt.index+1}</td>
                                                <td>${o.name }</td>
                                                <td>${o.password }</td>
                                                <td>${o.email }</td>
                                                <td>${o.telephone }</td>
                                                <td>
                                                    <button class="delete-button btn btn-danger" data-id="${o.id}" >Xóa</button>

                                                    <a
                                                            href="EditUser?id=${o.id}">
                                                        <button class="btn btn-danger">Sửa</button>
                                                    </a></td>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function (){
        $('.delete-button').on('click', function (){
            var id = $(this).data('id');
            $.ajax({
                url: 'DeleteUserControll',
                type: 'get',
                data: {id: id},
                success: function (response) {
                    $('#row_' + id).remove();
                    updateSTT();
                }
            });
        });

        function updateSTT() {
            $('#user-table-body tr').each(function (index) {
                $(this).find('td:first').text(index + 1);
                // Cập nhật ID của hàng theo thứ tự mới
                var newId = index + 1;
                $(this).attr('id', 'row_' + newId);
                // Cập nhật data-id của nút Xóa để phản ánh ID mới của hàng
                $(this).find('.delete-button').attr('data-id', newId);
            });
        }
    });
</script>




</body>
</html>