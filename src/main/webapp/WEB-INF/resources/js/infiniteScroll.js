window.count = 1;
var scroll=0;
window.onscroll = function(ev) {
    var maxcount = $(document.getElementById("page-count")).val();
    if (((window.innerHeight + window.scrollY) > document.body.offsetHeight-500)&&window.count*25<maxcount&&window.scrollY>scroll+50){

        getNext(window.count);
        // you're at the bottom of the page
        window.count = window.count+1;
        scroll = window.scrollY;
    }
};


function getMonthFromString(mon){
    return new Date(Date.parse(mon +" 1, 2012")).getMonth()+1
}



function getNext(count){
    var userTable = $('#test-id');
    $.ajax({

        url: '/getnexttweets/'+count, // указываем URL и
        dataType : 'json' , // тип загружаемых данных

        success: function (data) { // вешаем свой обработчик на функцию success

            console.log("All data fetched ... ") ;

            var users = '';
            var email='';
            var trHTML = '';

            for(var i = 0 ; i < data.length ; i++) {
                trHTML += '<div class="row">'+
                    '<div class="col-sm-12">'+
                    '<div class="well reply_wrap" style="text-align:left">'+
                    '<div class="col-sm-2 reply-image">'+
                    '<img src="'+data[i].user.avatar+'" class="reply-img" height="55" width="55" alt="Avatar">'+
                    '</div>'+
                    '<div class="reply_text">'+
                    '<input type="hidden" id="id" name="id">'+
                    '<span style="text-align: left; font-weight: bold">'+
                    '<a href="/user/profile/'+data[i].user.username+'">'+ data[i].user.username+'</a>'+
                    '</span>'+
                    '<span class="reply_footer pull-right"><small>'+data[i].postDateTime.year+'-'+getMonthFromString(data[i].postDateTime.month)+'-'+data[i].postDateTime.dayOfMonth+
                    ' '+data[i].postDateTime.hour+':'+data[i].postDateTime.minute+':'+data[i].postDateTime.second+'</small></span>'+
                    '<br>'+
                    '<span>'+
                    '<p>'+data[i].text+'</p>'+
                    '</span>'+
                    '<span>';
                    if(data[i].image!=null){
                        trHTML +='<img src="<c:url value="/images/" />'+data[i].image+'" style="width:300px;">';
                    }

                trHTML +='<p><a class="btn btn-info btn-sm pull-right glyphicon glyphicon-comment"'+
                    'href="${pageContext.request.contextPath}/tweet/'+data[i].id+'/addComment#myModal"></a></p>'+

                    '</span>'+
                    '</div>'+
                    '</div>'+
                    '</div>'+
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
                //    '<a href="${pageContext.request.contextPath}/tweet/'+data[i].id+'/addComment#myModal">'+data[i].text+'</a>'+
                //    '</p>'+
                //    '</span>'+
                //    '</div>'+
                //    '</div>'+
                //    '</div>'+
                //    '</div>';

            }



            userTable.append(trHTML) ;


        }
    });



}