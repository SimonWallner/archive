$(document).ready(function() {
   $('form').append(
       '<input type="hidden" name="new_release_dates" id="new_release_dates" value="" />'+
       '<input type="hidden" name="new_fields" id="new_fields" value="" />'
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

        $('#new_release_dates').val(datestring);
        $('#new_fields').val(userdefstring);
        return true;
    });

});
