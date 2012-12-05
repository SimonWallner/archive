$(document).ready(function() {
   $('form').append(
       '<input type="hidden" name="new_release_dates" id="new_release_dates" value="" />'+
       '<input type="hidden" name="new_userdefined_fields" id="new_userdefined_fields" value="" />'
   );

    $('form').submit(function () {
        var anzdates = $('[id^="year_release_date"]').length;
        var datestring = '';
        for(var i = 1; i<=anzdates; i++){
            datestring = datestring + $('#day_release_date'+i).val() +':'+
                                      $('#month_release_date'+i).val() +':'+
                                      $('#year_release_date'+i).val() +':'+
                                      $('#text_release_date'+i).val() +',';
        }
        datestring = datestring.substr(0, datestring.length -1);

        var anzuserdef = $('[id^="name_userdefined"]').length;
        var userdefstring = '';
        for(var i = 1; i<=anzuserdef; i++){
            userdefstring = userdefstring + '{"name":"'+$('#name_userdefined'+i).val() +'",' +
                                            '"content":"'+$('#content_userdefined'+i).val() +'"},';
        }
        userdefstring = '[' + userdefstring.substr(0,userdefstring.length-1) + ']';

        $('#new_release_dates').val(datestring);
        $('#new_userdefined_fields').val(userdefstring);
        return true;
    });

});
