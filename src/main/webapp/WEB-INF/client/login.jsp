<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Đăng nhập</title>

    <jsp:include page="./link/link-register.jsp"></jsp:include>
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css'
          rel='stylesheet'>
</head>
<body>
<c:url var="log" value="/LoginControll"></c:url>

<section class="container forms">
    <div class="form login">
        <div class="form-content">
            <header>Đăng nhập</header>
            <form action="${log}" method="post">
                <input type="hidden" name="urlend" value="${returnUrl}">
                <div class="field input-field">
                    <input type="text" name="identifier" value="${identifier}" placeholder="Email hoặc số điện thoại" class="input">
                    <span style="color: red; font-weight: 400;">${errorIdenty}</span>
                </div>
                <div class="field input-field">
                    <input type="password" name="password" value="${password}" placeholder="Mật khẩu" class="input">
                    <i class='bx bx-hide eye-icon'></i>
                    <span style="color: red; font-weight: 400;">${errorP}</span>
                </div>
                <div class="form-link">
                    <c:url var="forgot" value="/WEB-INF/client/forgot-password.jsp"></c:url>
                    <a href="/ForgotControll" class="forgot-pass">Forgot password?</a>
                </div>
                <div class="form-link">
                    <span style="color: red; font-weight: 400;background-color:seashell">${error}</span>
                </div>
                <div class="field button-field">
                    <button>Đăng nhập</button>
                </div>
            </form>
            <div class="form-link">
                <c:url var="sign" value="SignupControll"></c:url>
                <span>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/${sign}"
                                                class="link signup-link">Đăng ký</a></span>
            </div>
        </div>
        <div class="media-options">
            <a href="https://www.facebook.com/v19.0/dialog/oauth?client_id=859487865990246&redirect_uri=https://localhost:8080/login-facebook" class="field facebook">
                <i class='bx bxl-facebook facebook-icon'></i>
                <span>Tiếp tục với Facebook</span>
            </a>
        </div>
        <div class="media-options">
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/login-google&response_type=code&client_id=103711909118-kj61sqe0bv8srccvmk7tire0ih1oi87o.apps.googleusercontent.com" class="field google">
                <img src="assets/img/google.png" alt="" class="google-img">
                <span>Tiếp tục với Google</span>
            </a>
        </div>
    </div>
</section>

<!-- JavaScript -->
<!-- JavaScript -->
<script type="text/javascript">
    const pwShowHide = document.querySelectorAll(".eye-icon");

    pwShowHide.forEach(eyeIcon => {
        eyeIcon.addEventListener("click", () => {
            const passwordField = eyeIcon.previousElementSibling; // Get the previous sibling which is the password input

            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.classList.replace("bx-hide", "bx-show");
            } else {
                passwordField.type = "password";
                eyeIcon.classList.replace("bx-show", "bx-hide");
            }
        });
    });
</script>

<script src="../client/assets/js/script.js"></script>
</body>
</html>