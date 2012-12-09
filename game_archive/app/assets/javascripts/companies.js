$(document).ready(function() {
    $('form').append(
        '<input type="hidden" name="defunct" id="defunct" value="" />'+
        '<input type="hidden" name="founded" id="founded" value="" />'+
        '<input type="hidden" name="new_fields" id="new_fields" value="" />'
     );

        $('form').submit(function () {

            if($('[id^="year_defunct"]').length > 0)   {
                var defunctstring = '';
                defunctstring = defunctstring + $('#day_defunct').val() +':'+
                    $('#month_defunct').val() +':'+
                    $('#year_defunct').val() +':'+
                    $('#text_defunct').val();
                defunctstring = '[' + defunctstring + ']';
                $('#defunct').val(defunctstring);
            }
            if($('[id^="year_founded"]').length > 0)   {
                var foundedstring = '';
                foundedstring = foundedstring + $('#day_founded').val() +':'+
                    $('#month_founded').val() +':'+
                    $('#year_founded').val();
                foundedstring = '[' + foundedstring + ']';
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
