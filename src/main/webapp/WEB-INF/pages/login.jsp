<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Log in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="../resources/css/login-registration.css"%>
    </style>
</head>
<body style="background-color: #eeeeee">

<div class="container">
    <div class="wrapper">
        <form method="POST" action="${contextPath}/login" name="Login_Form" class="form-signin">
            <h3 class="form-signin-heading">Welcome Back! Please Sign In</h3>
            <hr class="colorgraph">
            <br>
            <h4 style="color: red">${errormsg}</h4>
            <input name="username" type="text" class="form-control" placeholder="Username"
                   autofocus="true"/>
            <input name="password" type="password" class="form-control" placeholder="Password"/>

            <div class="input-group input-sm">
                <div class="checkbox">
                    <label><input type="checkbox" id="rememberme" name="remember-me"> Remember Me</label>
                </div>
            </div>
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}" />

            <button class="btn btn-warning btn-block btn-lg" type="submit">Log In</button>
            <h4 class="text-center"><a href="${contextPath}/registration">Create an account</a></h4>
        </form>
    </div>
</div>
</body>
</html>

