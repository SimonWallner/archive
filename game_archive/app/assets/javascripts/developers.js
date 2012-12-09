$(document).ready(function() {
    $('form').append(
        '<input type="hidden" name="new_userdefined_fields" id="new_userdefined_fields" value="" />'
    );

    $('form').submit(function () {

        var anzuserdef = $('[id^="name_userdefined"]').length;
        var userdefstring = '';
        for(var i = 1; i<=anzuserdef; i++){
            userdefstring = userdefstring + '{"name":"'+$('#name_userdefined'+i).val() +'",' +
                '"content":"'+$('#content_userdefined'+i).val() +'"},';
        }
        userdefstring = '[' + userdefstring.substr(0,userdefstring.length-1) + ']';

        $('#new_userdefined_fields').val(userdefstring);
        return true;
    });

});
