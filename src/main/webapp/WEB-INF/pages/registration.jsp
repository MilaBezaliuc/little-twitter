<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <!-- This file has been downloaded from Bootsnipp.com. Enjoy! -->
    <title>Log in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
    <%@include file="../resources/css/login-registration.css"%>
    <%@include file="../resources/css/bootstrap.css"%>
    </style>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #efefef">

<div class="container" >
    <div class="wrapper">
    <form:form method="POST" action="/registration" modelAttribute="user" class="form-signin">
        <h3 class="form-signin-heading">Create your account</h3>

        <spring:bind path="username">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder="Username"
                            autofocus="true"/>
                <form:errors path="username"/>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="password" class="form-control" placeholder="Password" autofocus="true"/>
                <form:errors path="password"/>
            </div>
        </spring:bind>

        <spring:bind path="confirmPassword">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="confirmPassword" class="form-control"
                            placeholder="Confirm your password" autofocus="true"/>
                <form:errors path="confirmPassword"/>
            </div>
        </spring:bind>

        <spring:bind path="first_name">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="first_name" class="form-control" placeholder="First name"
                            autofocus="true"/>
                <form:errors path="first_name"/>
            </div>
        </spring:bind>

        <spring:bind path="last_name">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="last_name" class="form-control" placeholder="Last name"
                            autofocus="true"/>
                <form:errors path="last_name"/>
            </div>
        </spring:bind>

        <spring:bind path="email">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="email" path="email" class="form-control" placeholder="Email"
                            autofocus="true"/>
                <form:errors path="email"/>
            </div>
        </spring:bind>
        <button class="btn btn-lg btn-warning btn-block" type="submit">Submit</button>
    </form:form>
    </div>
</div>
<!-- /container -->
</body>
</html>