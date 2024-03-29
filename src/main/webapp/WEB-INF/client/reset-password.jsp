<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Reset password</title>
	<!-- CSS -->
	<jsp:include page="./link/link-register.jsp"></jsp:include>
	
	<!-- Boxicons CSS -->
	<link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css'
		rel='stylesheet'>
	<style type="text/css"> 
	.container{
		padding-bottom: 150px;
	}
	</style>
</head>
<body>

<div class="container forms">
	<c:set var="reset" value="/ResetPassword"></c:set>
            <!-- Signup Form -->

            <div class="form signup">
                <div class="form-content">
                    <header>Reset password</header>
                    <div class="form-link">
                        <span style="font-size: 18px;color: #3472ac;"><b>Enter new password</b></span>
                    </div>
                    <form action="${pageContext.request.contextPath}/${reset}" method="post">
                        <div class="field input-field">
                            <input name="passw" type="password" placeholder="New password" class="password" name="password" id="pass">
                            <i class='bx bx-hide eye-icon' onclick="togglePassword('pass', 'eye-icon-pass')"></i>
							<span style="color: red; font-weight: 400px;">${errorP}</span>
                        </div>
						
                        <div class="field input-field">
                            <input name="repassw" type="password" onkeyup="validateRePass()" placeholder="Confirm new password" class="password" name="repassword" id="re">
                            <i class='bx bx-hide eye-icon' onclick="togglePassword('re', 'eye-icon-re')"></i>
							<span id="noti2" style="color: red; font-weight: 400px;">${errorRP}</span>
                        </div>
                        
                        <div class="field button-field">
                            <button>Submit</button>
                        </div>
                    </form>
				</div>
            </div>
        </div>

        <!-- JavaScript -->
    <script src="../client/assets/js/script.js"></script>
    <script type="text/javascript">
    
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