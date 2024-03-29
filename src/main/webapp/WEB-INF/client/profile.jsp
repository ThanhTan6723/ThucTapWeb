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
	
	<title>Profile</title>
	<!-- CSS -->
	<jsp:include page="./link/link-register.jsp"></jsp:include>
	
	<!-- Boxicons CSS -->
	<link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css'
		rel='stylesheet'>
	
</head>
<body>

<div class="container forms">
	<c:set var="profile" value="/UpdateProfileControll"></c:set>

            <div class="form signup">
                <div class="form-content">
                    <header>Your profile</header>
                    <form action="${pageContext.request.contextPath}/${profile}" method="post">
                        <div class="field input-field">
                            <input name="name" type="text" placeholder="Name" value="${name}" class="input">
	                        <span style="color: red; font-weight: 400px;">${error2}</span>
                        </div>
                        <div class="field input-field">
                            <input id="mail" name="email" type="email" placeholder="Email" value="${email}" onkeyup="validateEmail()" class="input">
	                        <span id="noti" style="color: red; font-weight: 400px;">${error3}</span>
                        </div>
                        <div class="field input-field">
                            <input name="phone" type="tel" placeholder="Phone" value="${phone}" class="input" id="tele"  onkeyup="validatePhone()">
	                        <span id="noti1" style="color: red; font-weight: 400px;">${error4}</span>
                        </div>

						
                        <div class="field button-field">
                            <button>Update</button>
                        </div>
                    </form>
					
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

		
	</script>
</body>
</html>