$(document).ready(function() {
   $('form').append(
        '<input type="hidden" name="new_release_dates" id="new_release_dates" value="" />'+
        '<input type="hidden" name="new_developers" id="new_developers" value="" />' +
        '<input type="hidden" name="new_credits" id="new_credits" value="" />' +
        '<input type="hidden" name="new_publishers" id="new_publishers" value="" />' +
        '<input type="hidden" name="new_distributors" id="new_distributors" value="" />' +
        '<input type="hidden" name="new_fields" id="new_fields" value="" />'  +
        '<input type="hidden" name="new_series" id="new_series" value="" />'
   );

    $('form').submit(function () {
        var anzdates = $('[id^="year_release_date"]').length;
        var datestring = '';
        for(var i = 1; i<=anzdates; i++){
            if($('#year_release_date'+i).val())
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
        if($('#new_external_links').length > 0 && $('#new_external_links').val().length > 0){
            userdefstring = userdefstring + '{"name":"External Links","content":"'+$('#new_external_links').val()+'"},';
        }
        if($('#new_aggregate_scores').length > 0 && $('#new_aggregate_scores').val().length > 0){
            userdefstring = userdefstring + '{"name":"Aggregate Scores","content":"'+$('#new_aggregate_scores').val()+'"},';
        }
        if($('#new_review_scores').length > 0 && $('#new_review_scores').val().length > 0){
            userdefstring = userdefstring + '{"name":"Review Scores","content":"'+$('#new_review_scores').val()+'"},';
        }
        userdefstring = '[' + userdefstring.substr(0,userdefstring.length-1) + ']';

        $('input[type="hidden"][id^="new_"]').val('');
        $('#new_release_dates').val(datestring);
        $('#new_fields').val(userdefstring);

        $.each(['developer','publisher','distributor','credits', 'series'], function(index, val){
            var input_field_name = 'new_' + val;
            if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
                input_field_name = input_field_name + 's';
            $('.'+val+'_link').each(function(){
                if($(this).val()){
                    $('#'+input_field_name).val(
                        $('#'+input_field_name).val() +
                        ($(this).prev().val()
                            ? $(this).prev().val().replace('additional-info', $(this).next().val())
                            : $(this).val() + ':' + $(this).next().val() + ',' )
                    );
                }
            });
        });

        //escape linebreacks from json inputs
        $('[id^="new_"]').each(function(){
            $(this).val($(this).val().replace(/\n/g, "\\n"));
        });

        event.preventDefault();

        $.post( $('form').attr('action'), $('form').serialize(),
            function( data ) {
                var content = $( data ).find( '#error_explanation' );
                if(content.length > 0){
                    $('#error_explanation').remove();
                    $('form').append( content );
                }else{
                    window.location = $('form').attr('action');
                }
            }
        );
    });

});
