<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="../resources/css/card.css">

<div class="col-sm-3 well abc" style="background-color: steelblue" id="leftPanel">
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
    <br>

    <div class="alert alert-info fade in">
        <a href="#" class="close glyphicon glyphicon-remove" data-dismiss="alert" aria-label="close"></a>
        <br>

        <div>
            <p><strong>Hi ${currentUser.username}!</strong></p>
            These are people you follow.<br><br>

            <c:forEach items="${IFollow}" var="f" end="4">
                <p><a href="/user/profile/${f.username}"><strong>${f.username}</strong></a></p>
            </c:forEach>
        </div>
    </div>
</div>
