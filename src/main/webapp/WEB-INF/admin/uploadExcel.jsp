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
                    <form action="UploadExcel" method="post" enctype="multipart/form-data">
                        <input type="file" name="excelFile" accept=".xlsx, .xls">
                        <button type="submit">Tải lên</button>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="./footer/footer.jsp"></jsp:include>
        <!-- partial -->
    </div>
    <!-- main-panel ends -->
</div>


</body>
</html>