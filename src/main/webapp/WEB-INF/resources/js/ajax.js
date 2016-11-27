$( document ).ready(function() {


    $('#get-data').click(function () {
        var showData = $('#show-data');
        var showEmail=$('#show-email');
        var userTable = $('#user-table');


        $.ajax({
            url: '/allusers/', // указываем URL и
            dataType : 'json' , // тип загружаемых данных


            success: function (data) { // вешаем свой обработчик на функцию success

                console.log("All data fetched ... ") ;
                console.log(data) ;
                var users = '';
                var email='';
                var trHTML = '';

                for(var i = 0 ; i < data.length ; i++) {
                    trHTML += '<tr><td>' + data[i].username + '</td><td>' + data[i].email + '</td><td>' + data[i].first_name + '</td></tr>';
                }
                //
                //$.each(data, function(i, item) {
                //    trHTML += '<tr><td>' + data[i].username + '</td><td>' + data[i].email + '</td><td>' + data[i].first_name + '</td></tr>';
                //}) ;
                userTable.html(trHTML) ;

            }
        });


    });


});