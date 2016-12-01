<%@ page import="java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="fragments/headTag.jsp"/>
<script type="text/javascript">
    // Using jQuery.

    $(function () {
        $('form').each(function () {
            $(this).find('input').keypress(function (e) {
                // Enter pressed?
                if (e.which == 10 || e.which == 13) {
                    this.form.submit();
                }
            });
            $(this).find('textarea').keypress(function (e) {
                // Enter pressed?
                if (e.which == 10 || e.which == 13) {
                    this.form.submit();
                }
            });

            $(this).find('input[type=submit]').hide();
        });
    });
</script>
<body style="overflow-y: scroll;">

<%@include file="fragments/top.jsp" %>
<div class="container text-center">
    <div class="row">
        <jsp:include page="fragments/leftsidebar.jsp"/>

        <!-- MIDDLE PART -->
        <div class="col-sm-6 abc">
            <div>
                <div>
                    <div class="panel panel-default text-left">
                        <div class="panel-body" style="border: 0px">
                            <form action="/tweet/addtweet" method="post">
                                <input type="hidden"
                                       name="${_csrf.parameterName}"
                                       value="${_csrf.token}"/>
                                <section id="editable" contenteditable="true">
                                        <textarea required id="tweet" placeholder="<spring:message code='tweet_msg' />"
                                                  maxlength=140;
                                                  style="border: none; box-shadow: none; resize: none; overflow: hidden; font-size: large"
                                                  name="text" aria-multiline="true" class="form-control"></textarea>
                                </section>
                                <%--IMAGE UPLOAD--%>
                                <input type="hidden" name="image" id="result2">

                                <div id="file-image-container" width="80%" class="pull-right"></div>

                                <button hidden id="file-button" value="Submit" onclick="uploadFormData()">Upload
                                </button>
                                <br>

                                <div class="image-upload" style="">

                                    <input name="file2" id="file2" type="file"/>
                                </div>

                                <div class="container">

                                    <div id="demo" class="collapse">
                                        <table style="font-size: xx-large">
                                            <tr>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😁');return false;"> 😁</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😉');return false;"> 😉</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😃');return false;"> 😃</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😆');return false;"> 😆</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😍');return false;"> 😍</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😝');return false;"> 😝</span>
                                                </td>

                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😞');return false;"> 😞</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😠');return false;"> 😠</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😫');return false;"> 😫</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😢');return false;"> 😢</span>
                                                </td>
                                                <td><span style="cursor:pointer"
                                                          onclick="insertAtCaret('tweet', ' 😘');return false;"> 😘</span>
                                                </td>
                                            </tr>
                                            <tr>

                                        </table>
                                    </div>
                                </div>
                                <label class="glyphicon glyphicon-camera"
                                       style="cursor: pointer; color: maroon; font-size: x-large"
                                       for="file2">
                                </label>

                                <label data-toggle="collapse"
                                       data-target="#demo"
                                       style="cursor: pointer; color: maroon; font-size: x-large"
                                       for="demo"> 😃
                                </label>
                                <input type="submit" class="btn btn-warning btn-sm pull-right" value="Tweet!"
                                       id="addTweet"/>
                                <small class="text-info popover-content pull-right" id="counter"></small>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <%--Twitts--%>
            <div id="test-id">
                <c:forEach items="${allTweets}" var="t" varStatus="status">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="well reply_wrap" style="text-align:left">
                                <div class="col-sm-2 reply-image">
                                    <img src="${t.user.avatar}" class="reply-img" height="55" width="55" alt="Avatar">
                                </div>
                                <div class="reply_text">
                                    <input type="hidden" id="id" name="id">
                            <span style="text-align: left; font-weight: bold">
                                <a href="/user/profile/${t.user.username}"> ${t.user.username} </a>
                            </span>
                                    <span class="reply_footer pull-right"><small>${t.postDateTime.toLocalDate()} ${t.postDateTime.toLocalTime().withNano(0)}</small></span>
                                    <br>
                                    <span>
                                    <p style="font-size: larger">${t.text}</p>
                                    </span>

                                    <c:if test="${t.image!=null}">
                                        <c:if test="${!t.image.equals('')}">
                                            <span width="80%" class="pull-right">
                                            <img width="100%" src="<c:url value="/images/" />${t.image}"></c:if></span>
                                    </c:if>

                                    <article>
                                        <br>
                                        <span style='color:maroon;font-size: large; '
                                              class="glyphicon glyphicon-heart liking"
                                              data-like="${t.id}"
                                              data-like2="${currentUser.id}"
                                              style="font-size: large; color: steelblue; text-decoration: none"></span>
                                        <span class="likeCount">0</span>

                                            <%--<a href="${pageContext.request.contextPath}/tweet/${t.id}/addComment">--%>
                                        <span
                                              class="glyphicon glyphicon-comment pull-right"
                                              style="font-size: large; color: steelblue; text-decoration: none"
                                                ></span>
                                            <%--</a>--%>

                                            <%--MODAL CSS--%>
                                        <div>
                                            <div>
                                                <hr>
                                                <form action="/tweet/addComment" method="post">
                                                    <input type="hidden"
                                                           name="${_csrf.parameterName}"
                                                           value="${_csrf.token}"/>
                                                    <input name="id" type="hidden" value="${t.id}">
            <textarea id="autotxt" name="text" class="form-control animated" placeholder="Enter here to comment..."
                      rows="1" style="resize:none; overflow: hidden;"></textarea>
                                                    <%--<br>--%>
                                                        <input type="submit"/>
                                                </form>
                                                <hr/>
                                                <ul class="media-list">
                                                    <c:forEach items="${allComments}" var="comment">
                                                        <li class="small">
                                                            <a href="/user/profile/${comment.user.username}"
                                                               class="pull-left">
                                                                <img src="${comment.user.avatar}"
                                                                     class="img-circle photo"
                                                                     height="25" width="25" alt="Avatar">
                                                            </a>

                                                            <div class="media-body">
<span class="text-muted pull-right">
<small class="text-muted">${comment.postDateTime.toLocalDate()}</small>
</span>
                                                                <a href="/user/profile/${comment.user.username}"><strong
                                                                        class="text-success">@ ${comment.user.username}</strong></a>

                                                                <div>${comment.text}</div>
                                                            </div>
                                                        </li>
                                                        <hr>
                                                    </c:forEach>
                                                </ul>

                                            </div>
                                        </div>
                                            <%--END OF MODAL--%>
                                    </article>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%--<jsp:include page="modal.jsp"/>--%>

        <!-- Side bar-->
        <jsp:include page="fragments/rightsidebar.jsp"/>

    </div>
</div>

<script>
    $('#tweet').keyup(function () {

        if (this.value.length > 140) {
            return false;
        }
        $("#counter").html((140 - this.value.length));
    });
</script>
<script>

    $('#file2').change(function () {

        $('#file-button').click();


    });

    function uploadFormData() {
        $('#result').html('');

        var oMyForm = new FormData();
        oMyForm.append("file", file2.files[0]);

        $.ajax({
            url: '/uploadFile',
            data: oMyForm,
            dataType: 'text',
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
//                $('#result').html(data);
                $('#result2').attr('value', data);
                $('#file-image-container').html("<img src=" + "/images/" + data + " style=\"width:100%;\"/>");
            }
        });
    }

</script>

<script>

    window.count = 1;
    var scroll = 0;
    window.onscroll = function (ev) {
        var maxcount = $(document.getElementById("page-count")).val();
        if (((window.innerHeight + window.scrollY) > document.body.offsetHeight - 500) && window.count * 25 < maxcount && window.scrollY > scroll + 200) {

            getNext(window.count);
            // you're at the bottom of the page
            window.count = window.count + 1;
            scroll = window.scrollY;
        }
    };


    function getMonthFromString(mon) {
        return new Date(Date.parse(mon + " 1, 2012")).getMonth() + 1
    }


    function getNext(count) {
        var userTable = $('#test-id');
        $.ajax({

            url: '/getnexttweets/' + count,
            dataType: 'json',

            success: function (data) {

                console.log("All data fetched ... ");

                var users = '';
                var email = '';
                var trHTML = '';

                for (var i = 0; i < data.length; i++) {
                    trHTML += '<div class="row">' +
                            '<div class="col-sm-12">' +
                            '<div class="well reply_wrap" style="text-align:left">' +
                            '<div class="col-sm-2 reply-image">' +
                            '<img src="' + data[i].user.avatar + '" class="reply-img" height="55" width="55" alt="Avatar">' +
                            '</div>' +
                            '<div class="reply_text">' +
                            '<input type="hidden" id="id" name="id">' +
                            '<span style="text-align: left; font-weight: bold">' +
                            '<a href="/user/profile/' + data[i].user.username + '">' + data[i].user.username + '</a>' +
                            '</span>' +
                            '<span class="reply_footer pull-right"><small>' + data[i].postDateTime.year + '-' + getMonthFromString(data[i].postDateTime.month) + '-' + data[i].postDateTime.dayOfMonth +
                            ' ' + data[i].postDateTime.hour + ':' + data[i].postDateTime.minute + ':' + data[i].postDateTime.second + '</small></span>' +
                            '<br>' +
                            '<span>' +
                            '<p>' + data[i].text + '</p>' +
                            '</span>' +
                            '<span>' +
                            '<c:if test="${'
                            +data[i].image+
                            '!=null}">' +
                            '<img src="<c:url value="/images/" />' + data[i].image + '" style="width:300px;"></c:if>' +
                            '<p><a class="btn btn-info btn-sm pull-right glyphicon glyphicon-comment"' +
                            'href="${pageContext.request.contextPath}/tweet/' + data[i].id + '/addComment#myModal"></a></p>' +
//                            +'<input value='+getCount(data[i].id)+'>'+
                            '</span>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                    // '<div class="row">'+
                    //    '<div class="col-sm-12">'+
                    //    '<div class="well"'+' style="text-align:left">'+
                    //    '<div class="col-sm-2">'+
                    //    '<img src="'+data[i].user.avatar+'" class="img-circle photo" style="margin: 0px auto" height="55" width="55" alt="Avatar">'+
                    //    '</div>'+
                    //    '<div style="margin: 0px auto">'+
                    //    '<input type="hidden" id="id" name="id">'+
                    //    '<span style="text-align: left; font-weight: bold">'+
                    //    '<a href="/user/profile/'+data[i].user.username+'">'+ data[i].user.username+'</a>'+
                    //    '</span>'+
                    //    '<span class="text-muted pull-right">'+
                    //    ' <small class="text-muted">'+
                    //     data[i].postDateTime.year+'-'+getMonthFromString(data[i].postDateTime.month)+'-'+data[i].postDateTime.dayOfMonth+
                    //     ' '+data[i].postDateTime.hour+':'+data[i].postDateTime.minute+':'+data[i].postDateTime.second+
                    //    '</small>'+
                    //
                    //    '</span>'+
                    //    '<br>'+
                    //    '<span>'+
                    //    '<p>'+
                    <%--//    '<a href="${pageContext.request.contextPath}/tweet/'+data[i].id+'/addComment#myModal">'+data[i].text+'</a>'+--%>
                    //    '</p>'+
                    //    '</span>'+
                    //    '</div>'+
                    //    '</div>'+
                    //    '</div>'+
                    //    '</div>';

                }


                userTable.append(trHTML);


            }
        });
    }

</script>

<input hidden id="page-count" value="${maxPage}">
</body>
</html>

