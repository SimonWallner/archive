$(document).ready(function() {
    $('form').append(
        '<input type="hidden" name="new_fields" id="new_fields" value="" />'
    );

    $('form').submit(function () {

        var anzuserdef = $('[id^="name_userdefined"]').length;
        var userdefstring = '';
        for(var i = 1; i<=anzuserdef; i++){
            userdefstring = userdefstring + '{"name":"'+$('#name_userdefined'+i).val() +'",' +
                '"content":"'+$('#content_userdefined'+i).val() +'"},';
        }
        if($('#new_external_links').length > 0 && $('#new_external_links').val().length > 0){
            userdefstring = userdefstring + '{"name":"External Links","content":"'+$('#new_external_links').val()+'"},';
        }
        userdefstring = '[' + userdefstring.substr(0,userdefstring.length-1) + ']';

        $('#new_fields').val(userdefstring);
        return true;
    });

});
