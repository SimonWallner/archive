function loadfields(jsonurl){
    var gamefields = ["Developer","Publisher","Distributor","Credits","Platform",
                      "Release Dates","Mode","Media","External Links","Aggregate Scores",
                      "Review Scores","Genres","Tags","Series","Userdefined"];
    var companyfields = ["Official Name","Location","Founded","Defunct","External Links","Userdefined"];
    var developersfields = ["External Links","Userdefined"];
    var usedfields;

    if(jsonurl.indexOf('games')>0)
        usedfields = gamefields;
    else if(jsonurl.indexOf('companies'))
        usedfields = companyfields;
    else
        usedfields = developersfields;


    $.getJSON(jsonurl, function(data){
        jQuery.each(data, function(i, val) {
            if($.inArray(i,['platform','mode','media', 'genres', 'tags']))
               ; //todo load fields
        });
    });
}

function addField(button_element, types){
    var html = '<div class="addedField"><select class="newField">';
    $.each(types, function(index, value) {
        if(value)
            html = html + '<option value="'+value.toLowerCase()+'">' + value + '</option>';
    });
    html = html + '<option value="remove">Remove</option><option selected="" value="">Select Type</option></select></div>';
  $(button_element).parent().find('.newFieldsDiv').append(html);
  $.each($('.newField'),function(){
      $(this).unbind("change");
      $(this).change([this],function(){addConcreteField(this, true);});
  });
}
var anzDateInputs=0;
var anzUserDefined=0;
function addConcreteField(select_element, deletecurrent){
    if(deletecurrent)
        $(select_element).parent().find('> :not(select:first)').remove();
    var field_name = $(select_element).val();
    var input_field_name = 'new_' + field_name.replace(' ','_');
    if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
        input_field_name = input_field_name + 's';
    if(field_name == 'remove'){                                                                      // remove field
        $(select_element).parent().remove();

    }else if($.inArray(field_name,['series']) >= 0){                                                 // game references + add info
        $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');
        $('#'+input_field_name).autocomplete({source: '/ajax.json?type=game'});

    }else if($.inArray(field_name,['official name']) >= 0){                                                 // game references + add info
        $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');

    }else if($.inArray(field_name,['release dates']) >= 0){                                           // dates
        anzDateInputs++;
        var html = '<div class="release_dates_div" id="release_dates_div">';
        html = html + addDateInput('release_date'+anzDateInputs);
        html = html + '<input id="text_release_date'+anzDateInputs+'" name="input_field_name'+anzDateInputs+'" type="text">';
        html = html + '<button type="button" onclick="addConcreteField(this,false);" value="release dates"> + </button></div>'
        $(select_element).parent().append(html);

    }else if($.inArray(field_name,['platform','mode','media', 'genres', 'tags']) >= 0){              // tokenlists
        $.getJSON('/ajax.json?type=all&field='+field_name, function(data){
            var availableTags = data;
            $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');
            $('#'+input_field_name).tagit({caseSensitive: false, availableTags: availableTags, allowSpaces: true});

            $('#'+input_field_name+'_input').focus(function() {
                var div = $('#all_'+field_name+'_div').show();
                $('textarea, input:not(#'+input_field_name+'_input)').bind('focusin.allavailable click.allavailable',function(e) {
                    if ($(e.target).closest('#'+input_field_name+'_input').length) return;
                    div.fadeOut('medium');
                    $('input, textarea').unbind('.allavailable');
                });
            });
            $('#'+input_field_name+'_input').focus();
        });

    }else if($.inArray(field_name,['userdefined']) >= 0){                                            // markup input
        anzUserDefined++;
        $(select_element).parent().append('<input id="name_'+field_name.replace(' ','_')+anzUserDefined+'" name="name_'+field_name.replace(' ','_')+anzUserDefined+'" value="Title">' +
                                          '<textarea cols="40" rows="3" id="content_'+field_name+anzUserDefined+'" name="content_'+field_name+anzUserDefined+'"></textarea>');
        at_autocomp(field_name+'_dummy', $('#'+input_field_name), '/ajax.json');

    }else if($.inArray(field_name,['official name']) >= 0){                                          // normal input
        $(select_element).parent().append('<input id="'+field_name.replace(' ','_')+'" name="'+field_name.replace(' ','_')+'">');

    }else if($.inArray(field_name,['location']) >= 0){                                               // textarea
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+field_name+'" name="'+field_name+'"></textarea>');

    }else if($.inArray(field_name,['defunct','founded']) >= 0){                                      // date + string
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+field_name+'" name="'+field_name+'"></textarea>');

    }else if($.inArray(field_name,['external links', 'aggregate scores', 'review scores']) >= 0){    // external links only
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+input_field_name+'" name="'+input_field_name+'"></textarea>');

    }else if($.inArray(field_name,['developer','publisher','distributor','credits']) >= 0){          // dev/comp references + add info
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+input_field_name+'" name="'+input_field_name+'"></textarea>');
        $('#'+input_field_name).autocomplete({source: '/ajax.json?type=developer'});
    }
}

function addDateInput(field_name){
    var html = '<select id="day_'+field_name+'" name="day_'+field_name+'">';
    for (var i=1; i<32; i++){
        html = html + '<option value="'+i+'">' + i + '</option>';
    }
    html = html + '<option selected="" value="0">-</option></select><select id="month_'+field_name+'" name="month_'+field_name+'">';
    for (var i=1; i<13; i++){
        html = html + '<option value="'+i+'">' + i + '</option>';
    }
    html = html + '<option selected="" value="0">-</option></select><input type="text" maxlength="4" class="year" id="year_'+field_name+'" name="year_'+field_name+'" class="newField">';
    return html
}