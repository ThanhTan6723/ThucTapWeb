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
            color: white; /* Header text color */
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
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            margin-top: 20px;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
            width: 100%;
            display: none; /* Initially hide the account details */
        }

        .table-container {
            position: relative;
            margin-top: 150px; /* Adjust as needed */
        }

        /* Đảm bảo rằng nút đóng được hiển thị */
        .close-btn {
            display: block;
            background-color: #fff; /* Chỉ định màu nền nếu cần thiết */
            padding: 5px 10px; /* Các thuộc tính padding tùy chỉnh */
            border: 1px solid #ccc; /* Đường viền nếu cần thiết */
            border-radius: 5px; /* Độ cong của góc nút */
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* Hiệu ứng bóng đổ */
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
                <!-- Account details section -->
                <div class="row" id="boxinf" style="display: none">
                    <div class="col-md-12 table-container" style="background-color: whitesmoke; color:black;">
                        <div id="accountDetails" class="account-details">
                            <span class="close-btn"
                                  style="position: absolute; bottom: 10px; right: 10px; cursor: pointer;">Đóng</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body" style="background-color: white">
                                <div class="table-responsive">
                                    <h4 class="card-title">Danh Sách Đơn Hàng Bị Từ chối</h4>
                                    <table id="example" class="display" style="width:100%;">
                                        <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã đơn hàng</th>
                                            <th style="width: 110px">Ngày đặt</th>
                                            <th>Account thực hiện</th>
                                            <th>Tên người nhận</th>
                                            <th>SĐT người nhận</th>
                                            <th>Địa chỉ giao hàng</th>
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
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        var table = $('#example').DataTable({
            ajax: {
                url: 'PackingProductControll',
                dataSrc: ''
            },
            columns: [
                {
                    data: null, render: function (data, type, row, meta) {
                        return meta.row + 1; // Auto increment index
                    }
                },
                {data: 'id'},
                {data: 'date'},
                {
                    data: 'account.name',
                    render: function (data, type, row) {
                        // Tạo một link có class để xác định khi nhấp vào tên account
                        return '<a href="#" class="account-detail" data-account-id="' + row.account.id + '">' + data + '</a>';
                    }
                },
                {data: 'consigneeName'},
                {data: 'consigneePhone'},
                {data: 'address'},
                {data: 'totalMoney'},
                {data: 'orderNotes'},
                {
                    data: null, render: function (data, type, row) {
                        return `
                        <a href="?id=${row.id}">
                           <button class="btn btn-success">Delete</button>
                        </a>
                        `;
                    }
                },
                {
                    data: null, render: function (data, type, row) {
                        return `
                       <a href="BillDetailControll?id=${row.id}"><i class="fa-solid fa-eye" style="color:black; font-size: 20px; cursor: pointer;"></i></a>
                        `;
                    }
                },
            ]
        });

        // Show account details when clicking on account name
        $(document).on('click', '.account-detail', function (e) {
            e.preventDefault();
            var accountId = $(this).data('account-id');
            $.ajax({
                url: 'AccountDetailControll',
                type: 'GET',
                data: {id: accountId},
                success: function (response) {
                    // Construct HTML for account details
                    var html = '<h4>Thông Tin Tài Khoản</h4>';
                    html += '<p><strong>ID:</strong> ' + response.id + '</p>';
                    html += '<p><strong>Tên Tài Khoản:</strong> ' + response.name + '</p>';
                    html += '<p><strong>Email:</strong> ' + response.email + '</p>';
                    html += '<p><strong>Số Điện Thoại:</strong> ' + response.telephone + '</p>';
                    // Display account details in the accountDetails section
                    $('#accountDetails').html(html).css('display', 'block');
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
        });

        // Hide account details when clicking on close button
        $(document).on('click', '.close-btn', function () {
            $('#accountDetails').css('display', 'none');
        });
    });
</script>
</body>
</html>
