<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Out</title>
    <!-- Css Styles -->
    <jsp:include page="./link/link.jsp"></jsp:include>

    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            padding-bottom: 5vh;
        }

        td {
            padding-top: 10px;
            padding-bottom: 20px;
            text-align: center;
        }
    </style>
    <!-- Include Google Places API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>
</head>
<body>
<jsp:include page="./header/header.jsp"></jsp:include>
<c:url var="pay" value="/OrderControll"></c:url>

<!-- Checkout Section Begin -->
<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <h4>Thanh toán</h4>
            <form action="${pay}" method="get">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Họ và tên<span>*</span></p>
                                    <input type="text" name="name" value="${name}">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Số điện thoại<span>*</span></p>
                                    <input type="tel" name="phone" value="${phone}">
                                </div>
                            </div>
                        </div>
                        <%--                        <div class="checkout__input">--%>
                        <%--                            <p>Email<span>*</span></p>--%>
                        <%--                            <input type="email" name="email" value="${email}" style="width: 70%;">--%>
                        <%--                        </div>--%>
                        <div class="checkout__input">
                            <select class="form-select form-select-sm mb-3" id="city" aria-label=".form-select-sm">
                                <option value="" selected>Chọn tỉnh thành</option>
                            </select>

                            <select class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                                <option value="" selected>Chọn quận/huyện</option>
                            </select>

                            <select class="form-select form-select-sm" id="ward" aria-label=".form-select-sm">
                                <option value="" selected>Chọn phường/xã</option>
                            </select>
                        </div>
                        <div class="checkout__input">
                            <p>Địa chỉ nhà<span>*</span></p>
                            <input type="text" id="address" name="address" placeholder="Địa chỉ nhà" class="checkout__input__add" required>
                        </div>
                        <div id="suggestions"></div>

                        <div class="checkout__input">
                            <p>Ghi chú cho đơn hàng<span></span></p>
                            <input type="text" name="notes" value="" placeholder="Ghi chú">
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order" style="box-shadow: 0px 0px 6px 0px rgba(0, 0, 0, 0.2);">
                            <h4>Danh sách order</h4>
                            <p>${sessionScope.cart.OrderDetail.id}</p>
                            <table>
                                <thead>
                                <tr>
                                    <th class="shoping__product">Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${sessionScope.cart}" var="o">
                                    <tr>
                                        <td class="shoping__cart__item" style="text-align: left;">
                                            <b>${o.value.product.name}</b>
                                        </td>
                                        <td class="shoping__cart__price">${o.value.product.price}₫</td>
                                        <td class="shoping__cart__quantity" style="">${o.value.quantity}</td>
                                        <td class="shoping__cart__total" style="">
                                            <c:set var="sumAll" value="${o.value.quantity*o.value.price}"></c:set>
                                                ${o.value.price}
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="checkout__order__total">Ship: <span></span></div>
                            <div class="checkout__order__total">Tổng tiền hàng: <span></span></div>
                            <div class="checkout__order__total">Tổng: <span>${sum}</span></div>

                            <c:url var="pay" value="OrderControll"></c:url>
                            <input style="padding: 10px 100px 10px;border: none;" type="submit" class="primary-btn"
                                   value="Thanh toán">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- Checkout Section End -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAhltZISk1lb0b0FYP-SBva29rLlmMYL4Y&libraries=places"></script>
<script>
    // Khởi tạo AutocompleteService của Google Places API
    var autocompleteService = new google.maps.places.AutocompleteService();
    var district = document.getElementById("district");
    var ward = document.getElementById("ward");

    // Lắng nghe sự kiện input trên trường địa chỉ nhà
    document.getElementById('address').addEventListener('input', function() {
        // Lấy giá trị nhập vào trường địa chỉ nhà
        var input = this.value;

        // Gợi ý địa chỉ từ dữ liệu đã nhập
        autocompleteService.getPlacePredictions({
            input: input,
            componentRestrictions: { country: 'vn' }, // Giới hạn kết quả ở Việt Nam
            types: ['address'] // Loại kết quả là địa chỉ
        }, function(predictions, status) {
            if (status == google.maps.places.PlacesServiceStatus.OK && predictions) {
                // Xóa các gợi ý địa chỉ cũ
                var suggestionContainer = document.getElementById('suggestions');
                suggestionContainer.innerHTML = '';

                // Hiển thị các gợi ý địa chỉ mới
                predictions.forEach(function(prediction) {
                    var suggestion = document.createElement('div');
                    suggestion.textContent = prediction.description;
                    suggestion.classList.add('suggestion');
                    suggestion.onclick = function() {
                        // Khi người dùng chọn một gợi ý, cập nhật trường địa chỉ nhà với gợi ý này
                        document.getElementById('address').value = prediction.description;
                        suggestionContainer.innerHTML = '';
                    };
                    suggestionContainer.appendChild(suggestion);
                });
            }
        });
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");
    var Parameter = {
        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
        method: "GET",
        responseType: "application/json",
    };
    var promise = axios(Parameter);
    promise.then(function (result) {
        renderCity(result.data);
    });

    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Id);
        }
        citis.onchange = function () {
            district.length = 1;
            ward.length = 1;
            if (this.value != "") {
                const result = data.filter(n => n.Id === this.value);

                for (const k of result[0].Districts) {
                    district.options[district.options.length] = new Option(k.Name, k.Id);
                }
            }
        };
        district.onchange = function () {
            ward.length = 1;
            const dataCity = data.filter((n) => n.Id === citis.value);
            if (this.value != "") {
                const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

                for (const w of dataWards) {
                    wards.options[wards.options.length] = new Option(w.Name, w.Id);
                }
            }
        };
    }
</script>

<!-- Js Plugins -->
<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>
</html>
