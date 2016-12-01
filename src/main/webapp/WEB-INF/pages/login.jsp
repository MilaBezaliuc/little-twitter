<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <form method="POST" action="/login" name="Login_Form" class="form-signin">
            <h3 class="form-signin-heading"><spring:message code="sign_in" /></h3>
            <hr class="colorgraph">
            <br>
            <h4 style="color: red">${errormsg}</h4>

            <input name="username" type="text" class="form-control" placeholder="<spring:message code="username" />"
                   autofocus="true"/>
            <input name="password" type="password" class="form-control" placeholder="<spring:message code="password" />"/>

            <div class="input-group input-sm">
                <div class="checkbox">
                    <label><input type="checkbox" id="rememberme" name="remember-me"><spring:message code="remember_me" /></label>
                </div>
            </div>
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}" />

            <button class="btn btn-warning btn-block btn-lg" type="submit"><spring:message code="login" /></button>
            <h4 class="text-center"><a href="${contextPath}/registration"><spring:message code="register" /></a></h4>
        </form>
    </div>
</div>
</body>
</html>

