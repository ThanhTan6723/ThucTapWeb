<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Người Dùng</title>
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

        .lock-toggle {
            cursor: pointer;
            font-size: 20px;
            margin-right: 10px;
        }

        .delete-icon {
            cursor: pointer;
            font-size: 20px;
            margin-right: 10px;
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
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body" style="background-color: white">
                                <div class="table-responsive">
                                    <h4 class="card-title">Danh Sách Người Dùng</h4>
                                    <table id="example" class="display" style="width:100%;">
                                        <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Hành động</th>
                                            <th>Khóa/Mở tài khoản</th>
                                            <th>Nâng cấp/Hạ cấp tài khoản</th>
                                        </tr>
                                        </thead>
                                        <tbody id="user-table-body">
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
    $(document).ready(function() {
        var table = $('#example').DataTable({
            ajax: {
                url: 'ListUsersControll',
                dataSrc: ''
            },
            columns: [
                { data: null, render: function (data, type, row, meta) {
                        return meta.row + 1; // Auto increment index
                    }},
                { data: 'name' },
                { data: 'email' },
                {
                    data: 'telephone',
                    defaultContent: '' // Set default content for 'telephone' column if data is null
                },
                { data: null, render: function(data, type, row) {
                        return `
                <i class="fa-solid fa-trash delete-icon" data-id="${row.id}" style="color: red;"></i>
                <a href="EditUser?id=${row.id}">
                    <i class="fa-solid fa-pen-to-square" style="color:#efe63a;"></i>
                </a>`;
                    }},
                { data: null, render: function(data, type, row) {
                        var iconClass = row.isLocked ? 'fa-lock-open' : 'fa-lock';
                        var iconColor = row.isLocked ? 'color: green;' : 'color: red;';
                        return `<i class="fa ${iconClass} lock-toggle" data-id="${row.id}" data-status="${row.isLocked ? 'unlock' : 'lock'}" style="${iconColor}"></i>`;
                    }},
                { data: null, render: function(data, type, row) {
                        var roles = ['Quản lý tài khoản', 'Quản lý đơn hàng', 'Quản lý kho', 'Khách hàng']; // Example list of roles
                        var options = roles.map(function(role) {
                            return `<option value="${role}">${role}</option>`;
                        }).join('');
                        return `
                        <select class="role-select">
                            ${options}
                        </select>
                        <button class="save-role" data-id="${row.id}">Lưu</button>
                        <button class="cancel-role">Hủy</button>
                    `;
                    }}
            ]
        });

        // Add event listener for lock/unlock action
        $('#example').on('click', '.lock-toggle', function() {
            var icon = $(this);
            var id = icon.data('id');
            var status = icon.data('status');
            var action = status === 'lock' ? 'lock' : 'unlock'; // Set the action corresponding to servlet

            if (confirm(`Bạn có chắc chắn muốn ${action == 'lock' ? 'khóa' : 'mở khóa'} tài khoản này không?`)) {
                $.ajax({
                    url: 'LockAccountControll', // Path to servlet
                    type: 'POST',
                    data: { userId: id, action: action }, // Information to send to servlet
                    dataType: 'json', // Define the data type received as JSON
                    success: function(response) {
                        if (response.success) { // Check the status returned from the servlet
                            // Toggle the icon class and data-status attribute
                            if (action === 'lock') {
                                icon.removeClass('fa-lock').addClass('fa-lock-open');
                                icon.css('color', 'green');
                                icon.data('status', 'unlock');
                            } else {
                                icon.removeClass('fa-lock-open').addClass('fa-lock');
                                icon.css('color', 'red');
                                icon.data('status', 'lock');
                            }
                        } else {
                            alert(response.message); // Show error message from servlet
                        }
                    },
                });
            }
        });

        // Add event listener for upgrade/downgrade action
        $('#example').on('click', '.save-role', function() {
            var button = $(this);
            var id = button.data('id');
            var selectedRole = button.closest('tr').find('.role-select').val();
            $.ajax({
                url: 'UpdateUserRoleControll',
                type: 'POST',
                data: { id: id, role: selectedRole },
                success: function(response) {
                    // Update the user role in the table
                }
            });
        });

        $('#example').on('click', '.cancel-role', function() {
            // Reset the dropdown to the previous value if needed
        });
    });
</script>


</body>
</html>
