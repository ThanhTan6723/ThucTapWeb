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

    <title>Forgot password</title>

    <!-- CSS -->
    <jsp:include page="./link/link-register.jsp"></jsp:include>

    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css'
          rel='stylesheet'>
    <style type="text/css">
        .container {
            padding-bottom: 150px;
        }
    </style>
</head>
<body>
<c:url var="forgot" value="/ForgotControll"></c:url>
<c:set var="email" value="Email"></c:set>

<div class="container forms">
    <div class="form login">
        <div class="form-content">
            <header>Forgot password</header>
            <div class="form-link">
					<span style="font-size: 18px; color: #3472ac;"><b>Please
							enter your email to reset a new password</b></span>
            </div>
            <form action="${forgot}" method="get">
                <div class="field input-field">
                    <input type="email" id="mail" name="email" placeholder="${email}"
                           onkeyup="validateEmail()" class="input" required="required"> <span id="notify"
                                                                                              style="color: red; ">${error}</span>
                </div>
                <div class="form-link"></div>
                <div class="field button-field">
                    <button>Gửi</button>
                </div>
            </form>

        </div>
    </div>
</div>
<script type="text/javascript">
    var isDeleting = false;

    function validateEmail() {
        var emailInput = document.getElementById("mail");
        var emailError = document.getElementById("notify");
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
                emailError.innerHTML = "Email structure is incorrect";
            } else {
                emailError.innerHTML = "";
            }
        }

        // save length
        emailInput.dataset.prevLength = email.length;
    }
</script>

<!-- JavaScript -->
<script src="../client/assets/js/script.js"></script>
</body>
</html>