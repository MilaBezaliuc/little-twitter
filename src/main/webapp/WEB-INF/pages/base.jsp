<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>MAD-Twitter</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js"></script>
  <style>
    <%@include file="../resources/css/bootstrap.css"%>
    <%@include file="../resources/css/style.css"%>
  </style>
</head>
<body>

<%@include file="fragments/top.jsp" %>

<div class="container text-center">
  <div class="row">
    <%@include file="fragments/leftsidebar.jsp" %>

    <!-- MIDDLE PART -->
    <div class="col-sm-7">
      <div class="row">
        <div class="col-sm-12">
          <div class="panel panel-default text-left">

          </div>
        </div>
      </div>
    </div>

    <!-- Side bar-->
    <%@include file="fragments/rightsidebar.jsp" %>
  </div>
</div>
<%@include file="fragments/footer.jsp" %>

</body>
</html>

