<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Đơn Hàng</title>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Custom styles for DataTables */
        table.dataTable thead th {
            background-color: #343a40; /* Header background color */
            color: #ffffff; /* Header text color */
        }

        table.dataTable tbody td {
            color: black; /* Data text color */
        }

        tr:hover {
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Shadow effect on hover */
            transition: box-shadow 0.3s ease; /* Smooth transition */
        }

        /* Style for account details section */
        .account-details {
            background-color: #e1e1e1;
            border: 1px solid #c4c4c4;
            color: black;
            padding: 50px;
            margin-top: 20px;
            position: fixed;
            border-radius: 8px;
            top: 50%; /* Center vertically */
            left: 50%; /* Center horizontally */
            transform: translate(-50%, -50%);
            z-index: 9999; /* Ensure it's on top */
            display: none; /* Initially hide the account details */
        }

        /* Style for the close button */
        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }


        .table-container {
            position: relative;
            margin-top: 150px; /* Adjust as needed */
        }

        /* Flex container for buttons */
        .action-buttons {
            display: flex;
            gap: 10px; /* Space between buttons */
        }

        /* Style for the tabs */
        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: none;
            background-color: #111111;
        }

        .tab.active {
            background-color: #232323;
            border-bottom: 2px solid #37e737;
            color: #37e737;
        }

        .table-section {
            display: none; /* Hide all sections by default */
        }

        .table-section.active {
            display: block; /* Show the active section */
        }
    </style>
    <!-- Include common links -->
    <jsp:include page="./link/link.jsp"></jsp:include>
</head>
<body>
<div class="container-scroller">
    <!-- Include sidebar -->
    <jsp:include page="./header/sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <!-- Include navbar -->
        <jsp:include page="./header/navbar.jsp"></jsp:include>
        <div class="main-panel">
            <div class="content-wrapper">
                <!-- Tabs -->
                <div class="tabs">
                    <div class="tab active" data-tab="all">Chờ xác nhận</div>
                    <div class="tab" data-tab="pending">Chờ đóng gói</div>
                    <div class="tab" data-tab="shipping">Vận chuyển</div>
                    <div class="tab" data-tab="delivering">Chờ giao hàng</div>
                    <div class="tab" data-tab="completed">Hoàn thành</div>
                    <div class="tab" data-tab="cancelled">Đã hủy</div>
                    <div class="tab" data-tab="return-refund">Trả hàng/Hoàn tiền</div>
                </div>

                <!-- Table Sections -->
                <div class="table-section active" id="all">
                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body" style="background-color: white">
                                    <div class="table-responsive">
                                        <h4 style="color: black">Danh Sách Voucher</h4>
                                        <table id="example1" class="display" style="width:100%;">
                                            <thead>
                                            <tr>
                                                <th>Mã đơn hàng</th>
                                                <th style="width: 110px">Ngày đặt</th>
                                                <th>Account thực hiện</th>
                                                <th>Tên người nhận</th>
                                                <th>SĐT người nhận</th>
                                                <th>Địa chỉ giao hàng</th>
                                                <th>Tổng tiền hàng</th>
                                                <th>Ship</th>
                                                <th>Tổng tiền</th>
                                                <th>Ghi chú đơn hàng</th>
                                                <th>Hành động</th>
                                                <th>Xem chi tiết</th>
                                            </tr>
                                            </thead>
                                            <tbody id="order-table-body">
                                            <!-- Data will be populated by DataTables -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Account Details Section -->
                <div class="account-details" id="account-details">
                    <div class="close-btn" onclick="closeAccountDetails()">X</div>
                    <h2>Thông Tin Tài Khoản</h2>
                    <div class="account-details-content"></div>
                </div>


                <div class="table-section" id="pending">
                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body" style="background-color: white">
                                    <div class="table-responsive">
                                        <h4 style="color: black">Danh Sách Đơn Chờ Đóng Gói</h4>
                                        <table id="example2" class="display" style="width:100%;">
                                            <thead>
                                            <tr>
                                                <th>Mã đơn hàng</th>
                                                <th style="width: 110px">Ngày đặt</th>
                                                <th>Account thực hiện</th>
                                                <th>Tên người nhận</th>
                                                <th>SĐT người nhận</th>
                                                <th>Địa chỉ giao hàng</th>
                                                <th>Tổng tiền hàng</th>
                                                <th>Ship</th>
                                                <th>Tổng tiền</th>
                                                <th>Ghi chú đơn hàng</th>
                                                <th>Hành động</th>
                                                <th>Xem chi tiết</th>
                                            </tr>
                                            </thead>
                                            <tbody id="order-table-body">
                                            <!-- Data will be populated by DataTables -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add more table sections for other tabs here -->

            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
</body>
</html>