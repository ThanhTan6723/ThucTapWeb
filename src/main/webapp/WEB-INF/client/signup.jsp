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
                    <input name="name" type="text" placeholder="Name" value="${name}" class="input">
                    <span style="color: red; font-weight: bold">${error2}</span>
                </div>
                <div class="field input-field">
                    <input id="mail" name="email" type="email" placeholder="Email" value="${email}"
                           onkeyup="validateEmail()" class="input">
                    <span id="noti" style="color: red; font-weight: bold">${error3}</span>
                </div>
                <div class="field input-field">
                    <input name="phone" type="tel" placeholder="Số điện thoại" value="${phone}" class="input" id="tele"
                           onkeyup="validatePhone()">
                    <span id="noti1" style="color: red; font-weight:bold">${error4}</span>
                </div>

                <div class="field input-field">
                    <input name="passw" type="password" placeholder="Mật khẩu" value="${passw}" class="password"
                           name="password" id="pass">
                    <i class='bx bx-hide eye-icon' onclick="togglePassword('pass', 'eye-icon-pass')"></i>
                    <span style="color: red; font-weight: bold;">${error5}</span>
                </div>

                <div class="field input-field">
                    <input name="repassw" type="password" onkeyup="validateRePass()" placeholder="Xác nhận mật khẩu"
                           class="password" name="repassword" id="re">
                    <i class='bx bx-hide eye-icon' onclick="togglePassword('re', 'eye-icon-re')"></i>
                    <span id="noti2" style="color: red; font-weight:bold;">${error6}</span>
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
            // detele message when deteleAll
            emailError.innerHTML = "";
            return;
        }

        if (email.length < emailInput.dataset.prevLength) {
            isDeleting = true;
        } else {
            isDeleting = false;
        }

        if (isDeleting) {
            //clear notifications while detele
            emailError.innerHTML = "";
        } else {
            if (!emailRegex.test(email)) {
                emailError.innerHTML = "Email invalidate";
            } else {
                emailError.innerHTML = "";
            }
        }

        // save length
        emailInput.dataset.prevLength = email.length;
    }

    function validatePhone() {
        var phoneNum = document.getElementById("tele").value;
        var phoneNumPattern = /^[0-9]{10}$/;
        var phoneError = document.getElementById("noti1");

        // Kiểm tra xem phoneNum chỉ chứa số và có đúng 10 chữ số không
        if (!phoneNumPattern.test(phoneNum)) {
            phoneError.innerHTML = "Phone is in wrong format";
            return false;
        } else {
            phoneError.innerHTML = "";
            return true;
        }
    }

    function validateRePass() {
        var passW = document.getElementById("pass").value;
        var rePass = document.getElementById("re").value;
        if (passW != rePass) {
            document.getElementById("noti2").innerHTML = "Password incorrect";
            return false;
        } else {
            document.getElementById("noti2").innerHTML = "";
            return true;
        }
    }

    function togglePassword(inputId, eyeIconId) {
        var passwordInput = document.getElementById(inputId);
        var eyeIcon = document.getElementById(eyeIconId);

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.classList.remove("bx-hide");
            eyeIcon.classList.add("bx-show");
        } else {
            passwordInput.type = "password";
            eyeIcon.classList.remove("bx-show");
            eyeIcon.classList.add("bx-hide");
        }

        eyeIcon.classList.toggle("bx-hide-eye", passwordInput.type === "text");
        eyeIcon.classList.toggle("bx-show-eye", passwordInput.type === "password");
    }

</script>
</body>
</html>