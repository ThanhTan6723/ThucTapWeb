<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zxx">
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
            <header>Login</header>
            <form action="${log}" method="post">
                <input type="hidden" name="urlend" value="${returnUrl }">
                <div class="field input-field">
                    <input type="text" name="username" value="${username}" placeholder="Name" class="input">
                    <span style="color: red; font-weight: 400;">${errorN}</span>
                </div>
                <div class="field input-field">
                    <input type="password" name="password" value="${password}" placeholder="Password" class="password">
                    <i class='bx bx-hide eye-icon'></i>
                    <span style="color: red; font-weight: 400;">${errorP}</span>
                </div>

                <div class="form-link">
                    <c:url var="forgot" value="/WEB-INF/client/forgot-password.jsp"></c:url>
                    <a href="${pageContext.request.contextPath}/${forgot}" class="forgot-pass">Forgot password?</a>
                </div>
                <div class="form-link">
                    <span style="color: red; font-weight: 400;background-color:seashell">${error}</span>
                </div>
                <div class="field button-field">
                    <button>Login</button>
                </div>
            </form>
            <div class="form-link">
                <c:url var="sign" value="SignupControll"></c:url>
                <span>Don't have an account? <a href="/SignupControll"
                                                class="link signup-link">Signup</a></span>
            </div>
        </div>


        <div class="media-options">
            <a href="#" class="field facebook">
                <i class='bx bxl-facebook facebook-icon'></i>
                <span>Continue with Facebook</span>
            </a>
        </div>

        <div class="media-options">
            <a href="#" class="field google">
                <%--                    <c:url var="gg" value="assets"></c:url>--%>
                <img src="assets/img/google.png" alt="" class="google-img">
                <span>Continue with Google</span>
            </a>
        </div>
    </div>
</section>

<!-- JavaScript -->
<script type="text/javascript">
    const pwShowHide = document.querySelectorAll(".eye-icon");

    pwShowHide.forEach(eyeIcon => {
        eyeIcon.addEventListener("click", () => {
            let pwFields = eyeIcon.parentElement.parentElement.querySelectorAll(".password");

            pwFields.forEach(password => {
                if (password.type === "password") {
                    password.type = "text";
                    eyeIcon.classList.replace("bx-hide", "bx-show");
                    return;
                }
                password.type = "password";
                eyeIcon.classList.replace("bx-show", "bx-hide");
            })

        })
    })

</script>
<script src="../client/assets/js/script.js"></script>


</body>
</html>