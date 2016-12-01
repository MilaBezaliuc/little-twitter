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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.css">
    <style type="text/css">
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>
        <%@include file="../resources/css/card.css"%>
    </style>
    <style>
        body {
            background-color: #eeeeee;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
</head>
<body style="overflow-y: scroll;">
<jsp:include page="fragments/top.jsp"/>

<%--User's left bar--%>
<div class="container text-center abc">
    <div class="row">
        <div class="col-sm-3 well" style="background-color: steelblue;" id="leftPanel">
            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div>
                        <img src="${user.avatar}"
                             alt="User's avatar" class="img-circle" height="150" width="150">
                        <br>
                        <br>

                        <p>
                            <small>@${user.username.toUpperCase()}</small>
                        </p>
                        <h4 style="color: #2f2f2f">${user.first_name} ${user.last_name}</h4>

                        <p>${user.description}</p>

                        <div class="twPc-divStats">
                            <ul class="twPc-Arrange">
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block">Tweets</span>
                                    <span class="twPc-StatValue">${usersTweets.size()}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block">Following</span>
                                    <span class="twPc-StatValue">${ifollow_counter}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block">Followers</span>
                                    <span class="twPc-StatValue">${followMe_counter}</span>
                                </li>
                            </ul>
                            <br>
                            <c:if test="${isFollowed==0}">
                                <a class="pull-right btn btn-warning btn-sm" href="/user/addfollower/${user.username}">+
                                    Follow</a>
                            </c:if>

                            <c:if test="${isFollowed!=0}">
                                <input type="hidden" id="unflw" value="${user.username}">
                                <span class="pull-right btn btn-danger btn-sm"id="unflw"
                                        onclick="sweetUnf()">-
                                    Unfollow</span>

                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--TWEET'S OF CURRENT USER-->
        <div class="col-sm-6">
            <div>
                <div>
                    <div class="panel panel-default text-left">
                        <c:forEach items="${usersTweets}" var="t">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="well reply-image" style="text-align:left">
                                        <input type="hidden" id="id" name="id">
                                        <span style="text-align: left; font-size: smaller">@${t.user.username}</span>
                                        <span class="text-muted pull-right">
                                            <small class="text-muted">${t.postDateTime.toLocalDate()}
                                                    ${t.postDateTime.toLocalTime().withNano(0)}
                                            </small>
                                        </span>
                                        <br><br>
                                        <span class="reply_text">${t.text}</span><br>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>

<script>
    function sweetUnf() {
        var id = $(document.getElementById("unflw")).val();
        swal({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, unfollow this user!'

        }).then(function () {
            $.ajax({
                url: '/unfollow/' + id,
                data: id,
                dataType: 'text',
                type: 'GET'
            });
            location.reload().fadeIn('fast');
        })
    }
</script>
