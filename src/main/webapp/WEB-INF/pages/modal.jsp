<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.js"></script>--%>
<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js"></script>--%>
<%--MODAL CSS--%>
<div data-toggle="collapse"
     data-target="#demo2">
    <div>
        <h3>${currentTweet.user.username}</h3>
        <span style="text-align: left;">
        <p>${currentTweet.text}</p>
        <hr>
        <a href="${pageContext.request.contextPath}/tweet" title="Close" class="cclose">x</a>

        <form action="/tweet/${id}/addComment" method="post">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
            <input name="id" type="hidden">
            <textarea id="autotxt" name="text" class="form-control animated" placeholder="Enter here to comment..."
                      rows="2" style="resize:none; overflow: hidden;"></textarea>
            <br>

            <div>
                <input type="submit" value="Comment" class=""/>
            </div>
        </form>
        <hr/>
        <ul class="media-list">
            <c:forEach items="${comments}" var="comment">
                <li class="">
                    <a href="/user/profile/${comment.user.username}" class="pull-left">
                        <img src="${comment.user.avatar}"
                             class="img-circle photo"
                             height="45" width="45" alt="Avatar">
                    </a>

                    <div class="media-body">
<span class="text-muted pull-right">
<small class="text-muted">${comment.postDateTime.toLocalDate()}</small>
</span>
                        <a href="/user/profile/${comment.user.username}"><strong class="text-success">@ ${comment.user.username}</strong></a>

                        <div>${comment.text}</div>
                    </div>
                </li>
                <hr>
            </c:forEach>
        </ul>
            </span>
    </div>
</div>
<%--END OF MODAL--%>