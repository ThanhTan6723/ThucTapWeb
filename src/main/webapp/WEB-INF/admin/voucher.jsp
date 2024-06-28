<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Voucher</title>
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
                    <div class="tab active" data-tab="all">All</div>
                    <div class="tab" data-tab="product">Product</div>
                    <div class="tab" data-tab="category">Category</div>
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
                                                <th>ID</th>
                                                <th>Code</th>
                                                <th>Type</th>
                                                <th>Percentage</th>
                                                <th>Quantity</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Action</th>
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

                <div class="table-section" id="product">
                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body" style="background-color: white">
                                    <div class="table-responsive">
                                        <h4 style="color: black">Danh Sách Voucher</h4>
                                        <table id="example2" class="display" style="width:100%;">
                                            <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Code</th>
                                                <th>Type</th>
                                                <th>Product Name</th>
                                                <th>Percentage</th>
                                                <th>Quantity</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Action</th>
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

                <div class="table-section" id="category">
                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body" style="background-color: white">
                                    <div class="table-responsive">
                                        <h4 style="color: black">Danh Sách Voucher</h4>
                                        <table id="example3" class="display" style="width:100%;">
                                            <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Code</th>
                                                <th>Type</th>
                                                <th>Category Name</th>
                                                <th>Percentage</th>
                                                <th>Quantity</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Action</th>
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
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        // Initialize DataTables
        var table1, table2, table3;

        function initDataTable(tab) {
            if ($.fn.DataTable.isDataTable('#example1')) {
                $('#example1').DataTable().destroy();
            }
            if ($.fn.DataTable.isDataTable('#example2')) {
                $('#example2').DataTable().destroy();
            }
            if ($.fn.DataTable.isDataTable('#example3')) {
                $('#example3').DataTable().destroy();
            }

            if (tab === 'all') {
                table1 = $('#example1').DataTable({
                    ajax: {
                        url: 'ManageVoucherControll?type=all',
                        dataSrc: ''
                    },
                    columns: [
                        {data: 'id'},
                        {data: 'code'},
                        {data: 'discountType.type'},
                        {data: 'discountPercentage'},
                        {data: 'quantity'},
                        {data: 'startDate'},
                        {data: 'endDate'},
                        {
                            data: null, render: function (data, type, row) {
                                return `
                                <div class="buttons">
                                    <button class="btn btn-danger refuse-btn" data-id="">Delete</button>
                                </div>
                            `;
                            }
                        },
                    ]
                });
            } else if (tab === 'product') {
                table2 = $('#example2').DataTable({
                    ajax: {
                        url: 'ManageVoucherControll?type=product',
                        dataSrc: ''
                    },
                    columns: [
                        {data: 'id'},
                        {data: 'code'},
                        {data: 'discountType.type'},
                        {data: 'product.name'},
                        {data: 'discountPercentage'},
                        {data: 'quantity'},
                        {data: 'startDate'},
                        {data: 'endDate'},
                        {
                            data: null, render: function (data, type, row) {
                                return `
                                <div class="buttons">
                                    <button class="btn btn-danger refuse-btn" data-id="">Delete</button>
                                </div>
                            `;
                            }
                        },
                    ]
                });
            } else if (tab === 'category') {
                table3 = $('#example3').DataTable({
                    ajax: {
                        url: 'ManageVoucherControll?type=category',
                        dataSrc: ''
                    },
                    columns: [
                        {data: 'id'},
                        {data: 'code'},
                        {data: 'discountType.type'},
                        {data: 'category.name'},
                        {data: 'discountPercentage'},
                        {data: 'quantity'},
                        {data: 'startDate'},
                        {data: 'endDate'},
                        {
                            data: null, render: function (data, type, row) {
                                return `
                                <div class="buttons">
                                    <button class="btn btn-danger refuse-btn" data-id="">Delete</button>
                                </div>
                            `;
                            }
                        },
                    ]
                });
            }
        }

        // Tab navigation logic
        $('.tab').on('click', function () {
            $('.tab').removeClass('active');
            $(this).addClass('active');
            var tab = $(this).data('tab');
            $('.table-section').removeClass('active');
            $('#' + tab).addClass('active');
            initDataTable(tab);
        });

        // Set the initial tab and initialize the DataTable
        var initialTab = 'all';
        $('.tab[data-tab="' + initialTab + '"]').addClass('active');
        $('#' + initialTab).addClass('active');
        initDataTable(initialTab);

    });

</script>
</body>
</html>
