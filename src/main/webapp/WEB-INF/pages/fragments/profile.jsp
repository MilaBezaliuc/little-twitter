<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>User Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>
    </style>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
</head>
<body style="overflow-y: scroll;">

<%@include file="fragments/top.jsp" %>

<div class="container text-center">
    <div class="row">
        <%--<div class="col-sm-3 well">--%>
        <%--</div>--%>

        <div class="row" id="main">
            <div class="col-md-3 well" id="leftPanel">
                <div class="row">
                    <div class="col-md-12" style="margin: 0 auto;">
                        <div>
                            <img src="/resources/pics/useravatar.png"
                                 alt="User's avatar"
                                 class="img-circle img-thumbnail">

                            <h6>@${user.username}</h6>

                            <h4>${user.first_name} ${user.last_name}</h4>

                            Followers: ${ifollow_counter}

                            Following: ${followMe_counter}

                            Tweets: ${usersTweets.size()}

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 well" id="rightPanel">
                <div class="row">
                    <!--TWEET'S OF CURRENT USER-->
                    <div class="panel panel-default text-left">

                        <c:forEach items="${usersTweets}" var="t">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="well" style="text-align:left">
                                        <input type="hidden" id="id" name="id">
                                        <span style="text-align: left; font-size: smaller">@${t.user.username}</span>
                            <span class="text-muted pull-right">
<small class="text-muted">${t.postDateTime.toLocalDate()}
        ${t.postDateTime.toLocalTime().withNano(0)}
</small>
                            </span>
                                        <br><br>
                                        <span><blockquote>${t.text}</blockquote>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>

            <%--<!-- Side bar-->--%>
            <%--<%@include file="fragments/rightsidebar.jsp" %>--%>
        </div>
    </div>
    <%@include file="fragments/footer.jsp" %>
</body>
</html>

