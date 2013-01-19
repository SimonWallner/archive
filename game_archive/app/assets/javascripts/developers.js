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

        //escape linebreacks from json inputs
        $('[id^="new_"]').each(function(){
            $(this).val($(this).val().replace("\n", "\\n"));
        });

        /*
        event.preventDefault();

        var $form = $( this ),
            term = $form.find( 'input[name="s"]' ).val(),
            url = $form.attr( 'action' );

        $.post( url, { s: term },
            function( data ) {
                var content = $( data ).find( '#content' );
                $( "#result" ).empty().append( content );
            }
        );
        $('#notification').fadeIn(500).delay(3000).fadeOut(500);
        */
        return true;
    });

});
