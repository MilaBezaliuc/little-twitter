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
        <%@include file="../resources/css/card.css"%>
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>

    </style>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.js"></script>
    <script src="../resources/js/autosizeTextarea.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
        });
    </script>
</head>


<body style="overflow-y: scroll;background-color: #eeeeee;">
<jsp:include page="fragments/top.jsp"/>

<%--User's left bar--%>
<div class="container text-center abc">
    <div class="row">
        <div class="col-sm-3 well" style="background-color: steelblue;" id="leftPanel">
            <a style="color: whitesmoke" href="/user/profile/settings"><span
                    class="pull-right btn btn-warning btn-xs glyphicon glyphicon-cog"></span></a>

            <div class="col-md-12" style="margin: 0 auto;">
                <div>
                    <img src="${currentUser.avatar}"
                         alt="User's avatar" class="img-circle" height="150" width="150">
                    <br>
                    <br>

                    <p>
                        <small>@${currentUser.username.toUpperCase()}</small>
                    </p>
                    <h4 style="color: #2f2f2f">${currentUser.first_name} ${currentUser.last_name}</h4>

                    <p>${currentUser.description}</p>

                    <div class="twPc-divStats">
                        <ul class="twPc-Arrange">
                            <li class="twPc-ArrangeSizeFit">
                                <span class="twPc-StatLabel twPc-block">Tweets</span>
                                <span class="twPc-StatValue">${myTweets.size()}</span>
                            </li>
                            <li class="twPc-ArrangeSizeFit">
                                <span class="twPc-StatLabel twPc-block">Following</span>
                                <span class="twPc-StatValue">${IFollow.size()}</span>
                            </li>
                            <li class="twPc-ArrangeSizeFit">
                                <span class="twPc-StatLabel twPc-block">Followers</span>
                                <span class="twPc-StatValue">${followMe.size()}</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <%--<h3>Followers</h3>--%>
        <div class="col-sm-9" style="text-align: center;">
                    <table width="100%">
                        <tr>
                            <td width="33%" valign="top"
                                style="padding: 10px; background-color: #eeeeee">
                                <c:forEach items="${listUsers}" var="v" begin="0" step="3">
                                    <div class="twPc-div"
                                         onclick="location.href='/user/profile/${v.username}';"
                                         style="cursor:pointer;">
                                        <a class="twPc-bg twPc-block"></a>

                                        <div>
                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                               class="twPc-avatarLink">
                                                <img alt="${v.username}"
                                                     src="${v.avatar}"
                                                     class="twPc-avatarImg">
                                            </a>

                                            <div class="twPc-divUser">
                                                <div class="twPc-divName">
                                                    <small style="color: #d58512; font-size: x-small">
                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                    </small>
                                                    <br>
                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                    <br>
                                                    <br>

                                                    <p class="text-primary small"
                                                       style="text-align: center; ">${v.description}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                </c:forEach>
                            </td>

                            <td width="33%" valign="top"
                                style="padding: 10px; background-color: #eeeeee">
                                <c:forEach items="${listUsers}" var="v" begin="1" step="3">
                                    <div class="twPc-div"
                                         onclick="location.href='/user/profile/${v.username}';"
                                         style="cursor:pointer;">
                                        <a class="twPc-bg twPc-block"></a>

                                        <div>

                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                               class="twPc-avatarLink">
                                                <img alt="${v.username}"
                                                     src="${v.avatar}"
                                                     class="twPc-avatarImg">
                                            </a>

                                            <div class="twPc-divUser">
                                                <div class="twPc-divName">
                                                    <small style="color: #d58512; font-size: x-small">
                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                    </small>
                                                    <br>
                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                    <br>
                                                    <br>

                                                    <p class="text-primary small"
                                                       style="text-align: center; ">${v.description}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                </c:forEach>
                            </td>

                            <td width="33%" valign="top"
                                style="padding: 10px; background-color: #eeeeee">
                                <c:forEach items="${listUsers}" var="v" begin="2" step="3">
                                    <div class="twPc-div"
                                         onclick="location.href='/user/profile/${v.username}'; "
                                         style="cursor:pointer;">
                                        <a class="twPc-bg twPc-block"></a>

                                        <div>

                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                               class="twPc-avatarLink">
                                                <img alt="${v.username}"
                                                     src="${v.avatar}"
                                                     class="twPc-avatarImg">
                                            </a>

                                            <div class="twPc-divUser">
                                                <div class="twPc-divName">
                                                    <small style="color: #d58512; font-size: x-small">
                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                    </small>
                                                    <br>
                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                    <br>
                                                    <br>

                                                    <p class="text-primary small"
                                                       style="text-align: center; ">${v.description}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
        </div>
    </div>
</div>

</body>
</html>

