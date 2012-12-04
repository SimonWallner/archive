function addField(button_element, types){
    var html = '<div class="field"><select class="newField">';
    $.each(types, function(index, value) {
        if(value)
            html = html + '<option value="'+value.toLowerCase()+'">' + value + '</option>';
    });
    html = html + '<option value="remove">Remove</option><option selected="" value="">Select Type</option></select></div>';
  $(button_element).parent().prepend(html);
  $.each($('.newField'),function(){
      $(this).change([this],function(){addConcreteField(this);});
  });
}

function addConcreteField(select_element){
    $(select_element).parent().find('input').remove();
    var field_name = $(select_element).val();
    var input_field_name = 'new_' + field_name.replace(' ','_');
    if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
        input_field_name = input_field_name + 's';
    if(field_name == 'remove'){                                                                 // remove field
        $(select_element).parent().remove();
    }else if($.inArray(field_name,['series']) >= 0){                                                 // game references + add info
        $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');
        $('#'+input_field_name).autocomplete({source: '/tags.json?type=game'});
    }else if($.inArray(field_name,['release date']) >= 0){                                           // dates
        var html = '<div class="field"><select id="release_day1" name="release_day1" class="newField">';
        for (var i=1; i<32; i++){
            html = html + '<option value="'+i+'">' + i + '</option>';
        }
        html = html + '<option selected="" value="-1">Not Known</option></select><select id="release_month1" name="release_month1" class="newField">';
        for (var i=1; i<13; i++){
            html = html + '<option value="'+i+'">' + i + '</option>';
        }
        html = html + '<option selected="" value="-1">Not Known</option></select><input type="text" maxlength="4" id="release_year1" name="release_year1" class="newField">';
        $(select_element).parent().append(html);
    }else if($.inArray(field_name,['platform','mode','media', 'genres', 'tags']) >= 0){              // tokenlists
        $.getJSON('/tags.json?type=all&field='+field_name, function(data){
            var availableTags = data;
            $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');
            $('#'+input_field_name).tagit({caseSensitive: false, availableTags: availableTags, allowSpaces: true});
        });
    }else if($.inArray(field_name,['userdefined']) >= 0){                                            // markup input
        $(select_element).parent().append('<textarea cols="40" rows="5" id="'+input_field_name+'" name="'+input_field_name+'"></textarea>');
        at_autocomp(field_name+'_dummy', $('#'+input_field_name), '/tags.json');
    }else if($.inArray(field_name,['external links', 'aggregate scores', 'review scores']) >= 0){    // external links only
        $(select_element).parent().append('<textarea cols="40" rows="5" id="'+input_field_name+'" name="'+input_field_name+'"></textarea>');
    }else if($.inArray(field_name,['developer','publisher','distributor','credits']) >= 0){          // dev/comp references + add info
        $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text">');
        $('#'+input_field_name).autocomplete({source: '/tags.json?type=developer'});
    }
}