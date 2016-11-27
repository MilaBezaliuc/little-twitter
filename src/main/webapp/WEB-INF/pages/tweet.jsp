<%@ page import="java.io.File" %>
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

    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <link rel="stylesheet" href="/resources/css/profile.css">
    <link rel="stylesheet" href="/resources/css/style.css">
    <link rel="stylesheet" href="/resources/css/card.css">
    <%--<link rel="stylesheet" href="/webjars/bootstrap/3.3.7-1/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="../resources/js/autosizeTextarea.js"></script>

    <script>
        function getCount(a) {
            $.ajax({
                type: 'GET',
                url: '/likesCount',
                data: {tweet_id: a},
                success: function (data) {
//                    $('#result22').attr('value',В data);
//                    $('p').data('lik').html(data);
//                    alert(data);
//                           return data;
//                        $('#').html(data);
                }

            });
        }

        $(document).ready(function () {
            //var uid = $('#uid').val();
            //var tid = $(this);
            $('.liking').on('click', function () { //bind click handler
                var data_id = $(this).data('like');
                var data_usr = $(this).data('like2');
                var thisButt = $(this);
                //console.log("ID:" +data_id+"and"+data_usr);     //things to do on click
                $.ajax({
                    type: 'POST',
                    url: '/addLike',
                    data: {tweet_id: data_id, user_id: data_usr},
                    success: function (data) {
                        thisButt.attr("disabled", true);
                        var current = parseInt(thisButt.siblings(".likeCount").text()) + 1;
                        var now = current + 1;
                        thisButt.siblings(".likeCount").html(current);
//                        alert()
                        getCount(data_id);
                        //console.log(data_id);
                        //console.log(getCount(data_id));
                    }
                });

            })
        });

    </script>
    <script>
        function insertAtCaret(areaId, text) {
            var txtarea = document.getElementById(areaId);
            if (!txtarea) { return; }

            var scrollPos = txtarea.scrollTop;
            var strPos = 0;
            var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
                    "ff" : (document.selection ? "ie" : false ) );
            if (br == "ie") {
                txtarea.focus();
                var range = document.selection.createRange();
                range.moveStart ('character', -txtarea.value.length);
                strPos = range.text.length;
            } else if (br == "ff") {
                strPos = txtarea.selectionStart;
            }

            var front = (txtarea.value).substring(0, strPos);
            var back = (txtarea.value).substring(strPos, txtarea.value.length);
            txtarea.value = front + text + back;
            strPos = strPos + text.length;
            if (br == "ie") {
                txtarea.focus();
                var ieRange = document.selection.createRange();
                ieRange.moveStart ('character', -txtarea.value.length);
                ieRange.moveStart ('character', strPos);
                ieRange.moveEnd ('character', 0);
                ieRange.select();
            } else if (br == "ff") {
                txtarea.selectionStart = strPos;
                txtarea.selectionEnd = strPos;
                txtarea.focus();
            }

            txtarea.scrollTop = scrollPos;
        }
    </script>

    <style>
        .image-upload > input {
            display: none;
        }

    </style>
    <style>
        body {
            background-color: #eeeeee;
        }
    </style>

</head>
<body style="overflow-y: scroll;">

<jsp:include page="fragments/top.jsp"/>
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
                                        <textarea required id="tweet" placeholder="How are you?" maxlength=140;
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
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😁');return false;"> 😁</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😉');return false;"> 😉</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😃');return false;"> 😃</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😆');return false;"> 😆</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😍');return false;"> 😍</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😝');return false;"> 😝</span></td>

                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😞');return false;"> 😞</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😠');return false;"> 😠</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😫');return false;"> 😫</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😢');return false;"> 😢</span></td>
                                                <td><span style="cursor:pointer" onclick="insertAtCaret('tweet', ' 😘');return false;"> 😘</span></td>
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
                                        <span class="likeCount">${t.likes}</span>
                                        <a class="glyphicon glyphicon-comment pull-right"
                                           style="font-size: large; color: steelblue; text-decoration: none"
                                           href="${pageContext.request.contextPath}/tweet/${t.id}/addComment#myModal"></a>
                                    </article>


                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%--<ul class="pager">--%>
        <%--<c:if test="${currentPage>0}">--%>
        <%--<li><a href="/tweet/page=${currentPage-1}">Previous</a></li>--%>
        <%--</c:if>--%>
        <%--<c:if test="${currentPage*5+5<maxPage}">--%>
        <%--<li><a href="/tweet/page=${currentPage+1}" id="next">Next</a></li>--%>
        <%--</c:if>--%>
        <%--</ul>--%>

        <jsp:include page="modal.jsp"/>

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

