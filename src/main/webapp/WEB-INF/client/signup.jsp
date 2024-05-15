<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Đăng ký</title>
    <!-- CSS -->
    <jsp:include page="./link/link-register.jsp"></jsp:include>

    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css'
          rel='stylesheet'>

</head>
<body>

<div class="container forms">
    <c:set var="sign" value="/SignupControll"></c:set>
    <!-- Signup Form -->

    <div class="form signup">
        <div class="form-content">
            <header>Signup</header>
            <form action="${sign}" method="post">
                <div class="field input-field">
                    <input name="name" type="text" placeholder="Tên" value="${name}" class="input">
                    <span class="notify">${error2}</span>
                </div>
                <div class="field input-field">
                    <input id="mail" name="email" type="email" placeholder="Email" value="${email}"
                           onkeyup="validateEmail()" class="input">
                    <span id="noti" class="notify">${error3}</span>
                </div>
                <div class="field input-field">
                    <input name="phone" type="tel" placeholder="Số điện thoại" value="${phone}" class="input" id="tele"
                           onkeyup="validatePhone()">
                    <span id="noti0" class="notify">${error4}</span>
                </div>

                <div class="field input-field">
                    <input name="passw" type="password" placeholder="Mật khẩu" value="${passw}"
                           onkeyup="validatePassword()" class="password"
                           name="password" id="pass">
                    <i class='bx bx-hide eye-icon'
                       onclick="togglePasswordInput('pass'); toggleEyeIcon('eye-icon-pass')" id="eyIconId"></i>
                    <span id="noti1" class="notify">${error5}</span>
                </div>

                <div class="field input-field">
                    <input name="repassw" type="password" onkeyup="validateRePass()" placeholder="Xác nhận mật khẩu"
                           class="password" name="repassword" id="re">
                    <i class='bx bx-hide eye-icon'
                       onclick="togglePasswordInput('re'); toggleEyeIcon('eye-icon-re')"></i>
                    <span id="noti2" class="notify">${error6}</span>
                </div>

                <div class="field button-field">
                    <button>Đăng ký</button>
                </div>
            </form>

            <c:url var="login" value="LoginControll"></c:url>
            <div class="form-link">
                <span>Already have an account? <a href="${pageContext.request.contextPath}/${login}"
                                                  class="link login-link">Login</a></span>
            </div>
        </div>


    </div>
</div>

<!-- JavaScript -->
<script src="../client/assets/js/script.js"></script>
<script type="text/javascript">

    var isDeleting = false;

    function validateEmail() {
        var emailInput = document.getElementById("mail");
        var emailError = document.getElementById("noti");
        var email = emailInput.value;
        var emailRegex = /^\w+@\w+(\.\w+)+(\.\w+)*$/;

        if (email.length === 0) {
            //Xoá cảnh báo khi xóa tất cả
            emailError.innerHTML = "";
            return;
        }

        if (email.length < emailInput.dataset.prevLength) {
            isDeleting = true;
        } else {
            isDeleting = false;
        }

        if (isDeleting) {
            //Xóa cảnh báo trong khi nhập
            emailError.innerHTML = "";
        } else {
            if (!emailRegex.test(email)) {
                emailError.innerHTML = "Email không đúng định dạng";
            } else {
                emailError.innerHTML = "";
            }
        }

        // save length
        emailInput.dataset.prevLength = email.length;
    }

    function validatePhone() {
        var phoneNum = document.getElementById("tele").value;
        var phoneNumPattern = /^0\d{9}$/;
        var phoneError = document.getElementById("noti0");

        // Kiểm tra xem sđt chỉ chứa số và có đúng 10 chữ số hay không
        if (!phoneNumPattern.test(phoneNum)) {
            phoneError.innerHTML = "Số điện thoại sai định dạng";
            return false;
        } else {
            phoneError.innerHTML = "";
            return true;
        }
    }

    function validatePassword() {
        var password = document.getElementById("pass").value;

        // Kiểm tra độ dài của mật khẩu
        if (password.length < 8) {
            document.getElementById("noti1").innerHTML = "Mật khẩu phải chứa 8 kí tự";
            return false;
        }

        // Kiểm tra xem mật khẩu có chứa ít nhất một chữ cái viết hoa, một chữ cái viết thường, một số và một ký tự đặc biệt hay không
        var uppercaseRegex = /[A-Z]/;
        var lowercaseRegex = /[a-z]/;
        var numberRegex = /[0-9]/;
        var specialCharacterRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;

        if (!uppercaseRegex.test(password)) {
            document.getElementById("noti1").innerHTML = "Mật khẩu phải chứa ít nhất 1 kí tự viết hoa";
            return false;
        } else if (!lowercaseRegex.test(password)) {
            document.getElementById("noti1").innerHTML = "Mật khẩu phải chứa ít nhất 1 kí tự viết thường";
            return false;
        } else if (!numberRegex.test(password)) {
            document.getElementById("noti1").innerHTML = "Mật khẩu phải chứa ít nhất 1 số";
            return false;
        } else if (!specialCharacterRegex.test(password)) {
            document.getElementById("noti1").innerHTML = "Mật khẩu phải chứa ít nhất 1 kí tự đặc biệt";
            return false;
        } else {
            document.getElementById("noti1").innerHTML = "";
            return true;
        }
    }

    function validateRePass() {
        var passW = document.getElementById("pass").value;
        var rePass = document.getElementById("re").value;
        if (passW != rePass) {
            document.getElementById("noti2").innerHTML = "Mật khẩu không trùng khớp";
            return false;
        } else {
            document.getElementById("noti2").innerHTML = "";
            return true;
        }
    }

    function togglePasswordInput(inputId) {
        var passwordInput = document.getElementById("pass");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }

    function toggleEyeIcon(eyeIconId) {
        var eyeIcon = document.getElementById("eyeIconId");

        if (eyeIcon.classList.contains("bx-hide")) {
            eyeIcon.classList.remove("bx-hide");
            eyeIcon.classList.add("bx-show");
        } else {
            eyeIcon.classList.remove("bx-show");
            eyeIcon.classList.add("bx-hide");
        }
    }

</script>
</body>
</html>