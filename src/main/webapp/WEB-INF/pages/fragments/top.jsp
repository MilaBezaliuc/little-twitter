<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--<link rel="stylesheet" href="/resources/css/bootstrap.css">--%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<%--<script src="http://code.jquery.com/jquery-1.9.1.js"></script>--%>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
    var search = function () {
        var availableTags = [];
        $.ajax({
            url: '/searchUser',
            data: ({username: $('#username').val()}),
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    availableTags[i] = data[i];
                }
                $('#username').autocomplete({
                    source: availableTags,
                    minLength: 3,
                    autoFocus: true,
                    select: function () {
                        for (var i = 0; i < data.length; i++) {
                            window.location = "/user/profile/" + data[i];
                        }
                    }
                });
            }
        });
    };
</script>



<div class="navbar navbar-fixed-top" style="background-color: steelblue;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button style="background-color: whitesmoke" type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a style="color: whitesmoke" class="navbar-brand" href="/tweet"><img height="23px"
                                                                                 src="/resources/pics/logo.png"/> </a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a style="color: whitesmoke" href="/tweet"><span class="glyphicon glyphicon-home"></span> <spring:message code="home" /></a>
                </li>
                <li><a style="color: whitesmoke" href="/user/profile/"><span class="glyphicon glyphicon-user"></span> <spring:message code="my_account" /></a></li>
                <li></li>
                <li><a style="color: whitesmoke" href="<c:url value="/logout" />"><span
                        class="glyphicon glyphicon-off"></span> <spring:message code="logout" /></a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li><a  style="color:whitesmoke;" href="?lang=en">en</a></li>
                <li><a style="color:whitesmoke;" href="?lang=ru">ru</a></li>
            </ul>
            <%--<jsp:include page="fragments/lang.jsp"/>--%>

            <form class="navbar-form navbar-right" role="search" style="z-index:-1;">
                <div class="form-group input-group">
                    <input type="text" class="form-control ui-widget"  id="username"
                           onkeyup="search()" style="z-index: 100;display:block;" placeholder='<spring:message code="search" />'/>
          <span class="input-group-btn">
            <button class="btn btn-default" type="button">
                <span class="glyphicon glyphicon-search"></span>
            </button>
          </span>
                </div>
            </form>

        </div>
    </div>
</div>



