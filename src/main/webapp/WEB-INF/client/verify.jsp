<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="./link/link-verify.jsp"></jsp:include>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>OTP Verification Form</title>
	
	<style type="text/css">
	.container{
		width: 60vh;
		height: 80vh;
	}
	</style>

<!-- Boxicons CSS -->
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<title>Verify</title>
</head>
<body>
	<c:url var="verify" value="/VerifyControll"></c:url>

	<div class="containerL">
		<div class="container">
			<header>
				<i class="bx bxs-check-shield"></i>
			</header>
			<h4>Enter OTP Code</h4>
			<form action="${verify}">
				<div class="input-field">
					<input id="n1" name="num1" type="number" /> 
					<input id="n2" name="num2" type="number" disabled /> 
					<input id="n3" name="num3" type="number" disabled />
					<input id="n4" name="num4" type="number" disabled />
				</div>
				<span id="noti2" style="color: red; font-weight: 400px;">${error}</span>
				<button>Verify OTP</button>
			</form>
		</div>
	</div>
	<script>
		const inputs = document.querySelectorAll("input"),
		button = document.querySelector("button");
		
		//iterate over all inputs
		inputs.forEach((input, index1) => {
		input.addEventListener("keyup", (e) => {
		  // This code gets the current input element and stores it in the currentInput variable
		  // This code gets the next sibling element of the current input element and stores it in the nextInput variable
		  // This code gets the previous sibling element of the current input element and stores it in the prevInput variable
		  const currentInput = input,
		    nextInput = input.nextElementSibling,
		    prevInput = input.previousElementSibling;
		
		  // if the value has more than one character then clear it
		  if (currentInput.value.length > 1) {
		    currentInput.value = "";
		    return;
		  }
		  // if the next input is disabled and the current value is not empty
		  //  enable the next input and focus on it
		  if (nextInput && nextInput.hasAttribute("disabled") && currentInput.value !== "") {
		    nextInput.removeAttribute("disabled");
		    nextInput.focus();
		  }
		
		  // if the backspace key is pressed
		  if (e.key === "Backspace") {
		    // iterate over all inputs again
		    inputs.forEach((input, index2) => {
		      // if the index1 of the current input is less than or equal to the index2 of the input in the outer loop
		      // and the previous element exists, set the disabled attribute on the input and focus on the previous element
		      if (index1 <= index2 && prevInput) {
		        input.setAttribute("disabled", true);
		        input.value = "";
		        prevInput.focus();
		      }
		    });
		  }
		  //if the fourth input( which index number is 3) is not empty and has not disable attribute then
		  //add active class if not then remove the active class.
		  if (!inputs[3].disabled && inputs[3].value !== "") {
		    button.classList.add("active");
		    return;
		  }
		  button.classList.remove("active");
		});
		});
		
		//focus the first input which index is 0 on window load
		window.addEventListener("load", () => inputs[0].focus());
</script>
</body>
</html>