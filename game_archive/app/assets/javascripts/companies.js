$(document).ready(function() {
    $('form').append(
        '<input type="hidden" name="defunct" id="defunct" value="" />'+
        '<input type="hidden" name="founded" id="founded" value="" />'+
        '<input type="hidden" name="new_fields" id="new_fields" value="" />'
     );

        $('form').submit(function () {

            if($('[id^="year_defunct"]').length > 0 && $('[id^="year_defunct"]').val().length > 0)   {
                var defunctstring = '{"day":';
                defunctstring = defunctstring + $('#day_defunct').val() +',"month":'+
                    $('#month_defunct').val() +',"year":'+
                    $('#year_defunct').val() +',"additional_info": "'+
                    $('#text_defunct').val() + '"}';
                $('#defunct').val(defunctstring);
            }
            if($('[id^="year_founded"]').length > 0 && $('[id^="year_founded"]').val().length > 0)   {
                var foundedstring = '{"day":';
                foundedstring = foundedstring + $('#day_founded').val() +',"month":'+
                    $('#month_founded').val() +',"year":'+
                    $('#year_founded').val() + '}';
                $('#founded').val(foundedstring);
            }

            var anzuserdef = $('[id^="name_userdefined"]').length;
            var userdefstring = '';
            for(var i = 1; i<=anzuserdef; i++){
                userdefstring = userdefstring + '{"name":"'+$('#name_userdefined'+i).val() +'",' +
                    '"content":"'+$('#content_userdefined'+i).val() +'"},';
            }
            userdefstring = '[' + userdefstring.substr(0,userdefstring.length-1) + ']';

            $('#new_fields').val(userdefstring);
            return true;
        });
});
