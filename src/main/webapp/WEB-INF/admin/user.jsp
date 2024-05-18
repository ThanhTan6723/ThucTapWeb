<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Người Dùng</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <style>

        table.dataTable thead th {
            background-color: #343a40; /* Màu nền của tiêu đề cột */
            color: white; /* Màu chữ của tiêu đề cột */
        }

        table.dataTable tbody td {
            color: black; /* Màu chữ của dữ liệu */
        }

        tr:hover {
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng khi rê chuột vào */
            transition: box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi mượt mà */
        }
    </style>
    <jsp:include page="./link/link.jsp"></jsp:include>

</head>
<body >
<div class="container-scroller">
    <jsp:include page="./header/sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="./header/navbar.jsp"></jsp:include>
        <div class="main-panel" >
            <div class="content-wrapper" >
                <div class="row" >
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body" style="background-color: white">
                                <div class="table-responsive" >
                                    <h4 class="card-title">Danh Sách Người Dùng</h4>
                                    <table id="example" class="display" style="width:100%;">
                                        <thead>
                                        <tr>
                                            <th >STT</th>
                                            <th >Tên</th>
                                            <th>Mật khẩu</th>
                                            <th >Email</th>
                                            <th >Số điện thoại</th>
                                            <th>Hành động</th>
                                        </tr>
                                        </thead>
                                        <tbody id="user-table-body">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                        return meta.row + 1; // Tự động tăng số thứ tự
                    }},
                { data: 'name' },
                { data: 'password' },
                { data: 'email' },
                { data: 'telephone' },
                { data: null, render: function(data, type, row) {
                        return `<button class="delete-button btn btn-danger" data-id="${row.id}" style="height:30px;">Xóa</button>
                                <a href="EditUser?id=${row.id}"><button class="btn btn-danger" style="height:30px;">Sửa</button></a>`;
                    }}
            ]
        });

        $('#example').on('click', '.delete-button', function() {
            var id = $(this).data('id');
            $.ajax({
                url: 'DeleteUserControll',
                type: 'post',
                data: { id: id },
                success: function(response) {
                    table.ajax.reload(); // Tải lại dữ liệu bảng
                }
            });
        });
    });

</script>
</body>
</html>
