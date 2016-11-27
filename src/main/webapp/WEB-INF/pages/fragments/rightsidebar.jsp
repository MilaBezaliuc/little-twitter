<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-3 well abc" style="background-color: #D8ECF6;">
    <%--<div class="thumbnail">--%>
    <h3 style="color: #777">Who to follow:</h3>
    <hr class="colorgraph">

    <div class="minibox" align="left" style="text-align: left; background-color: #D8ECF6;">
        <table width="100%">
            <c:forEach items="${followingOffers}" var="o">
                <tr>
                    <td width="20%" style="padding: 10px">
                        <div>
                        <img src="${o.avatar}" class="img-circle photo" style="margin: 0px auto" width="50px"
                             alt="Avatar"></div>
                    </td>
                    <td width="80%">
                        <a href="/user/profile/${o.username}" class="text-muted small">${o.first_name} ${o.last_name} @${o.username.toLowerCase()}</a><br>
                        <a class="pull-left btn btn-primary btn-sm" href="/user/addfollower/${o.username}">+ Follow</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br>
    <a href="/user" class="text-muted pull-left">Show more people</a>
</div>