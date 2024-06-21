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
        .suggestion {
            padding: 10px;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        .suggestion:hover {
            background-color: #f0f0f0;
        }
        .xBNaac {
            background-image: repeating-linear-gradient(45deg, #6fa6d6, #6fa6d6 33px, transparent 0, transparent 41px, #f18d9b 0, #f18d9b 74px, transparent 0, transparent 82px);
            background-position-x: -30px;
            background-size: 116px 3px;
            height: 3px;
            width: 100%;
            margin-bottom: 25px;
        }
        /* Add this CSS to your stylesheet */
        .checkout__input {
            margin-bottom: 20px;
            position: relative;
        }

        .checkout__input select {
            display: block;
            width: 100%;
            padding: 10px;
            font-size: 14px;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
            /*margin-bottom: 15px;*/
            appearance: none;
        }

        .checkout__input select:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .checkout__input .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f1f1f1;
            min-width: 100%;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .checkout__input .dropdown-content select {
            display: block;
            width: 100%;
            border: none;
            box-shadow: none;
            padding: 10px;
            margin: 0;
            background-color: #f1f1f1;
        }

        .checkout__input .dropdown-content select:hover {
            background-color: #ddd;
        }


    </style>
    <!-- Include Google Places API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>
</head>
<body>
<jsp:include page="./header/header.jsp"></jsp:include>
<c:url var="pay" value="/OrderControll"></c:url>

<!-- Checkout Section Begin -->
<section class="checkout spad" style="background-color: #f8f8f8">
    <div class="container">
        <div class="checkout__form">
            <h4>Thanh toán</h4>
            <div class="xBNaac"></div>
            <form action="${pay}" method="get">
                <div class="row" style="background-color: white; padding: 10px">
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
                        <div class="checkout__input">
                            <div class="dropdown">
                                <select class="form-select form-select-sm mb-3" id="city" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                                <div class="dropdown-content" id="dropdown-city">
                                    <!-- Options will be dynamically inserted here -->
                                </div>
                            </div>

                            <div class="dropdown">
                                <select class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn quận/huyện</option>
                                </select>
                                <div class="dropdown-content" id="dropdown-district">
                                    <!-- Options will be dynamically inserted here -->
                                </div>
                            </div>

                            <div class="dropdown">
                                <select class="form-select form-select-sm" id="ward" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn phường/xã</option>
                                </select>
                                <div class="dropdown-content" id="dropdown-ward">
                                    <!-- Options will be dynamically inserted here -->
                                </div>
                            </div>
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

                </div>
            </form>
        </div>
    </div>
</section>
<!-- Checkout Section End -->

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
    document.addEventListener('DOMContentLoaded', function () {
        var citySelect = document.getElementById('city');
        var districtSelect = document.getElementById('district');
        var wardSelect = document.getElementById('ward');

        citySelect.addEventListener('click', function () {
            var dropdownCity = document.getElementById('dropdown-city');
            dropdownCity.style.display = 'block';
        });

        districtSelect.addEventListener('click', function () {
            var dropdownDistrict = document.getElementById('dropdown-district');
            dropdownDistrict.style.display = 'block';
        });

        wardSelect.addEventListener('click', function () {
            var dropdownWard = document.getElementById('dropdown-ward');
            dropdownWard.style.display = 'block';
        });

        window.onclick = function(event) {
            if (!event.target.matches('.form-select')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.style.display === 'block') {
                        openDropdown.style.display = 'none';
                    }
                }
            }
        };

        // Load options from JSON and populate select elements
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
                var option = document.createElement('option');
                option.value = x.Id;
                option.text = x.Name;
                citySelect.appendChild(option);
            }
            citySelect.onchange = function () {
                districtSelect.length = 1;
                wardSelect.length = 1;
                if (this.value != "") {
                    const result = data.filter(n => n.Id === this.value);
                    for (const k of result[0].Districts) {
                        var option = document.createElement('option');
                        option.value = k.Id;
                        option.text = k.Name;
                        districtSelect.appendChild(option);
                    }
                }
            };
            districtSelect.onchange = function () {
                wardSelect.length = 1;
                const dataCity = data.filter((n) => n.Id === citySelect.value);
                if (this.value != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;
                    for (const w of dataWards) {
                        var option = document.createElement('option');
                        option.value = w.Id;
                        option.text = w.Name;
                        wardSelect.appendChild(option);
                    }
                }
            };
        }
    });

</script>

<!-- Js Plugins -->
<jsp:include page="./footer/footer.jsp"></jsp:include>
</body>
</html>
