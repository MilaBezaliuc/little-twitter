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

            <div class="row">
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
                                    <span class="twPc-StatValue">${usersTweets.size()}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block">Following</span>
                                    <span class="twPc-StatValue">${ifollow.size()}</span>
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
        </div>

        <ul class="nav nav-tabs  col-sm-6">
            <li class="active"><a href="#home">Tweets</a></li>
            <li><a href="#menu1">Following</a></li>
            <li><a href="#menu2">Followers</a></li>
        </ul>

        <div class="tab-content">
            <div id="home" class="tab-pane fade in active">

                <!-- MIDDLE PART -->
                <div class="col-sm-6" style="text-align: center;">
                    <div>
                        <br>

                        <div>
                            <div class="panel panel-default text-left">

                                <c:forEach items="${usersTweets}" var="t">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel-body" style="text-align:left">
                                                <form action="/tweet/edittweet/${t.id}" method="post">
                                                    <input type="hidden"
                                                           name="${_csrf.parameterName}"
                                                           value="${_csrf.token}"/>
                                                    <input type="hidden" id="id" name="id"/>
                                                    <span class="reply_text"
                                                          style="text-align: left; font-size: smaller">@${t.user.username}</span>
                                        <span class="reply_footer pull-right">
                                            <small>${t.postDateTime.toLocalDate()}
                                                    ${t.postDateTime.toLocalTime().withNano(0)}
                                            </small>
                                        </span>
                                                    <br><br>
                                                    <section id="editable" contenteditable="true">
                                                <textarea id="tweet" maxlength=140; rows="auto"
                                                          onClick="style='border-color: steelblue; resize: none; overflow: hidden'; this.rows = '5';"
                                                          onblur="this.rows='3'; type='submit'; style='border: none; overflow: hidden; height: auto; box-shadow: none; resize: none;'"
                                                          style="border: none; overflow: hidden; height: auto; box-shadow: none; resize: none; "
                                                          name="text" aria-multiline="true" class="form-control"
                                                          required>${t.text}</textarea>
                                                    </section>
                                                    <br>
                                                    <input type="hidden" id="tweet-id" value="${t.id}">
                                                    <button type="submit" value="Edit"
                                                            class="btn btn-warning btn-xs glyphicon glyphicon-pencil"></button>
                                            <span onclick="sweetDelTwit();"
                                                  class="pull-right btn btn-default btn-xs glyphicon glyphicon-trash"></span>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="menu1" class="tab-pane fade">
                <%--<h3>Following</h3>--%>
                <div class="col-sm-9" style="text-align: center;">
                    <div>
                        <br>

                        <div>
                            <div class="panel panel-default text-left"
                                 style=" background-color: #eeeeee; border-color: #eeeeee; -webkit-box-shadow: 0 0px 0px rgba(0,0,0,0);">
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${ifollow}" var="v" begin="0" step="3">
                                                    <div class="twPc-div" id="one">
                                                        <a class="twPc-bg twPc-block"></a>

                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->
                                                                <input type="hidden" id="unflw" value="${v.username}">
                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf();">- Unfollow</span>

                                                                <p></p>

                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
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
                                                <c:forEach items="${ifollow}" var="v" begin="1" step="3">
                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"></a>

                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->
                                                                <input type="hidden" id="unflw" value="${v.username}">
                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf();">- Unfollow</span>

                                                                <p></p>
                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
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
                                                <c:forEach items="${ifollow}" var="v" begin="2" step="3">
                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"></a>

                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->
                                                                <input type="hidden" id="unflw" value="${v.username}">
                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf();">- Unfollow</span>

                                                                <p></p>
                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
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
                    </div>
                </div>
            </div>
            <div id="menu2" class="tab-pane fade">
                <%--<h3>Followers</h3>--%>
                <div class="col-sm-9" style="text-align: center;">
                    <div>
                        <br>

                        <div>
                            <div class="panel panel-default text-left"
                                 style=" background-color: #eeeeee; border-color: #eeeeee; -webkit-box-shadow: 0 0px 0px rgba(0,0,0,0);">
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${followMe}" var="v" begin="0" step="3">

                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"> </a>

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
                                                <c:forEach items="${followMe}" var="v" begin="1" step="3">
                                                <div class="twPc-div"
                                                     onclick="location.href='/user/profile/${v.username}';"
                                                     style="cursor:pointer;">
                                                    <a class="twPc-bg twPc-block"></a>

                                                    <div>

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
                                                <c:forEach items="${followMe}" var="v" begin="2" step="3">
                                                <div class="twPc-div"
                                                     onclick="location.href='/user/profile/${v.username}'; "
                                                     style="cursor:pointer;">
                                                    <a class="twPc-bg twPc-block"></a>

                                                    <div>

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
                    </div>
                </div>
            </div>
        </div>


    </div>
    <%--<jsp:include page="js-modal.jsp"/>--%>


    <script>

        <%--REMEMBER CURRENT TAB--%>
        $(document).ready(function() {
            if(location.hash) {
                $('a[href=' + location.hash + ']').tab('show');
            }
            $(document.body).on("click", "a[data-toggle]", function(event) {
                location.hash = this.getAttribute("href");
            });
        });
        $(window).on('popstate', function() {
            var anchor = location.hash || $("a[data-toggle=tab]").first().attr("href");
            $('a[href=' + anchor + ']').tab('show');
        });

        function sweetDelTwit() {
            var id = $(document.getElementById("tweet-id")).val();
            swal({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'

            }).then(function () {

                location.href = '/tweet/deleteTweet/' + id;

            })
        }
    </script>
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
//                $( "#menu1" ).load( "/unfollow/" + id);
                $.ajax({
                    url: '/unfollow/' + id,
                    data: id,
                    dataType: 'text',
                    type: 'GET',
                    });
////                document.getElementById("one").hide().html(data).fadeIn('fast');
//                location.href = '/unfollow/' + id;
                location.reload().fadeIn('fast');
////                $("#menu1").hide();
//
            })
        }
    </script>
</body>
</html>

