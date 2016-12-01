<%@ page import="java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <title>MAD-Twitter</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" href="resources/pics/favicon.png">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <link rel="stylesheet" href="/resources/css/profile.css">
    <link rel="stylesheet" href="/resources/css/style.css">
    <link rel="stylesheet" href="/resources/css/card.css">
    <%--<link rel="stylesheet" href="/webjars/bootstrap/3.3.7-1/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="http://malsup.github.com/jquery.form.js"></script>
    <%--<script src="http://code.jquery.com/jquery-1.9.1.js"></script>--%>
    <%--<link rel="stylesheet" href="/resources/css/bootstrap.css">--%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <%--<script src="http://code.jquery.com/jquery-1.9.1.js"></script>--%>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="../resources/js/autosizeTextarea.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
            $('.liking').on('click', function () { //bind click handler
                var data_id = $(this).data('like');
                var data_usr = $(this).data('like2');
                var thisButt = $(this);
                $.ajax({
                    type: 'POST',
                    url: '/addLike',
                    data: {tweet_id: data_id, user_id: data_usr},
                    success: function (data) {
                        if(data===true) {
                            alert(data);
                           return;
                        }
//                        thisButt.attr("disabled", true);
                        var current = parseInt(thisButt.siblings(".likeCount").text()) + 1;
                        thisButt.siblings(".likeCount").html(current);
                    }
                });

            })
        });

    </script>
    <script>
        function insertAtCaret(areaId, text) {
            var txtarea = document.getElementById(areaId);
            if (!txtarea) {
                return;
            }

            var scrollPos = txtarea.scrollTop;
            var strPos = 0;
            var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
                    "ff" : (document.selection ? "ie" : false ) );
            if (br == "ie") {
                txtarea.focus();
                var range = document.selection.createRange();
                range.moveStart('character', -txtarea.value.length);
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
                ieRange.moveStart('character', -txtarea.value.length);
                ieRange.moveStart('character', strPos);
                ieRange.moveEnd('character', 0);
                ieRange.select();
            } else if (br == "ff") {
                txtarea.selectionStart = strPos;
                txtarea.selectionEnd = strPos;
                txtarea.focus();
            }

            txtarea.scrollTop = scrollPos;
        }
    </script>
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