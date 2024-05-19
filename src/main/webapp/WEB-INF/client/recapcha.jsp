<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19/05/2024
  Time: 1:30 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <script src="https://www.google.com/recaptcha/enterprise.js?render=6LfOe-EpAAAAAFtc_f3GxsOt-u1sjTdsNdXwakxa"></script>
    <!-- Your code -->

</head>
<body>
<input type="text" placeholder="Code">
<button class="g-recaptcha"
        data-sitekey="6LfOe-EpAAAAAFtc_f3GxsOt-u1sjTdsNdXwakxa"
        data-callback='onSubmit'
        data-action='submit'>
    Submit
</button>
<script>
    function onSubmit(token) {
        document.getElementById("demo-form").submit();
    }
</script>
</body>
<!-- Replace the variables below. -->

</html>
