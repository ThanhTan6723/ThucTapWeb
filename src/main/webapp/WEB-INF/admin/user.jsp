<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>List Of Users</title>
    <!-- plugins:css -->
<%--    <jsp:include page="./link/link.jsp"></jsp:include>--%>
    <!-- Thư viện jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <!-- DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>

    <link href="https://cdn.datatables.net/2.0.6/css/dataTables.dataTables.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.0.6/css/dataTables.dataTables.css" rel="stylesheet">

<%--    <style>--%>

<%--        tr, td {--%>
<%--            color: white;--%>

<%--            .table-hover:hover {--%>

<%--                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */--%>
<%--                transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */--%>

<%--            }--%>
<%--        }--%>
<%--    </style>--%>
</head>
<body>
<div class="container-scroller">
<%--    <jsp:include page="./header/sidebar.jsp"></jsp:include>--%>
    <div class="container-fluid page-body-wrapper">
<%--        <jsp:include page="./header/navbar.jsp"></jsp:include>--%>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <h3 class="card-title">List Users</h3>
                                    <c:url value="DeleteUserControll" var="deleteU"></c:url> <a
                                            href="${pageContext.request.contextPath}/${deleteU}?id=${o.id}">
                                        <button class="btn btn-danger">Thêm người dùng</button>
                                    <br>
                                    </a>
                                    <table id="example" class="display" style="width:100%">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Password</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${accounts}" var="o" varStatus="stt">
                                            <tr>
                                                <td scope="row">${stt.index+1}</td>
                                                <td>${o.name }</td>
                                                <td>${o.email }</td>
                                                <td>${o.telephone }</td>
                                                <td>${o.password}</td>
                                                <td><c:url value="DeleteUserControll" var="deleteU"></c:url> <a
                                                        href="${pageContext.request.contextPath}/${deleteU}?id=${o.id}">
                                                    <button class="btn btn-danger">Sửa</button>
                                                </a>
                                                <c:url value="DeleteUserControll" var="deleteU"></c:url> <a
                                                        href="${pageContext.request.contextPath}/${deleteU}?id=${o.id}">
                                                    <button class="btn btn-danger">Xóa</button>
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


<%--            <jsp:include page="./footer/footer.jsp"></jsp:include>--%>

        </div>
        <!-- main-panel ends -->

    </div>
    <!-- page-body-wrapper ends -->

</div>
<script>
    $(document).ready( function () {
        $('#example').DataTable();
    } );
    $(document).ready( function () {
        $('#example').DataTable({
            "paging": true,         // Hiển thị phân trang
            "ordering": true,       // Cho phép sắp xếp
            "searching": true       // Cho phép tìm kiếm
            // Thêm các tùy chọn khác tại đây
        });
    } );

</script>
<script defer src="https://cdn.datatables.net/2.0.6/js/dataTables.js"></script>
</body>
</html>