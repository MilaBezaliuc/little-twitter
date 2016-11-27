<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>User Settings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style type="text/css">
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>
        body {
            background-color: #eeeeee;
        }

        <%@include file="../resources/css/card.css"%>
    </style>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
</head>
<body style="overflow-y: scroll;">

<jsp:include page="fragments/top.jsp"/>

<div class="container text-center abc">
    <div class="row" id="main">
        <div class="col-md-3 well" id="leftPanel" style="background-color: steelblue;">
            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div>
                        <br>
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

        <!--EDIT PROFILE-->
        <div class="col-sm-8">
            <h3 class="form-signin-heading" style="color:#777">Edit your profile</h3>
            <hr class="colorgraph">
            <form:form method="POST" action="/user/profile/edit" modelAttribute="user">

                <table width="100%">
                    <tr>
                        <td width="30%" valign="top" style="padding: 10px; background-color: #eeeeee">
                            <div onMouseOver="this.style.color='red'; this.style.cursor='pointer'"
                                 onMouseOut="this.style.color='#777'" class="small text-muted pull-left"
                                 onclick="sweetDel();">&nbsp;&nbsp;x delete profile</div>
                            <br><br>

                            <div>
                                    <form:hidden path="id"/>
                                    <form:hidden path="username"/>
                                    <form:hidden path="email"/>
                                    <form:hidden path="password"/>

                                <section id="editable" contenteditable="true">
                                    <form:textarea placeholder="Describe yourself" path="description"
                                                   style="border: 1px solid #ddd; box-shadow: none; resize: none; overflow: hidden; font-size: larger"
                                                   class="form-control"
                                                   maxlength="20" autofocus="true"></form:textarea>
                                </section>
                                <br>
                                        <spring:bind path="first_name">
                                <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                                    <form:input type="text" path="first_name" class="form-control"
                                                placeholder="First name"
                                                autofocus="true"/>
                                    <form:errors path="first_name"/>
                                </div>
                                </spring:bind>

                                <spring:bind path="last_name">
                                <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                                    <form:input type="text" path="last_name" class="form-control"
                                                placeholder="Last name"
                                                autofocus="true"/>
                                    <form:errors path="last_name"/>
                                </div>
                                </spring:bind>

                                <input class="btn btn-block btn-success btn-lg" type="submit"
                                       value="Save changes"/>
                        </td>
                        <td width="70%" valign="top" style="padding: 10px; background-color: #eeeeee">

                            <form:hidden id="dam" path="avatar"/>
                            <div id="dam_return">
                                <c:forEach items="${avatar}" var="a">
                                    <a href="#" class="thumbnail"><img src="/resources/logos/${a}"
                                                                       height="60px" width="60px"/></a>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>
                </table>
            </form:form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#dam_return a img").click(function () {
            var value = $(this).attr("src");
            var input = $('#dam');
            input.val(value);
        });
    });

</script>

<script>
    function sweetDel() {
        swal({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'

        }).then(function () {

            location.href = '/user/delete/';

        })
    }
</script>
</body>

</html>

