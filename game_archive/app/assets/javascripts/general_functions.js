// jsonurl = url zum json renderer der  anzuzeigenden seite
// geht das json durch und fügt alle felder entsprechend hinzu
function loadfields(jsonurl){
    // bestimmen der möglichen fields und in welcher seite man sich befindet
    var gamefields = ["Developer","Publisher","Distributor","Credits","Platform",
                      "Release Dates","Mode","Media","External Links","Aggregate Scores",
                      "Review Scores","Genres","Tags","Series","Userdefined"];
    var companyfields = ["Official Name","Location","Founded","Defunct","External Links","Userdefined"];
    var developersfields = ["External Links","Userdefined"];
    var usedfields;
    var page = '';

    if(jsonurl.indexOf('games') > 0) {
        usedfields = gamefields;
        page = 'game';
    }else if(jsonurl.indexOf('companies') > 0){
        usedfields = companyfields;
        page = 'company';
    }else {
        usedfields = developersfields;
        page = 'developer';
    }

    // json laden und durchgehen
    $.getJSON(jsonurl, function(data){
        jQuery.each(data, function(i, val) {
            if($.inArray(i,['platforms','modes','media', 'genres', 'tags']) >= 0){
                if($.inArray(i,['platforms','modes']) >= 0)
                    i = i.substr(0, i.length -1);
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="'+i+'"]').attr('selected', true);

                var str = '';
                for (var x = 0; x < val.length; x++)
                    str = str + val[x].name + ',';
                str = str.substr(0, str.length -1);

                addConcreteField(select_elem, false, str);

            }else if($.inArray(i,['release_dates']) >= 0 ){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="release dates"]').attr('selected', true);

                for (var x = 0; x < val.length; x++){
                    addConcreteField(select_elem, false);
                    $('#year_release_date'+(x+1)).val(val[x].year);
                    $('#month_release_date'+(x+1)).val(val[x].month);
                    $('#day_release_date'+(x+1)).val(val[x].day);
                    $('#text_release_date'+(x+1)).val(val[x].additional_info);
                }
                addConcreteField(select_elem, false);

            }else if($.inArray(i,['fields']) >= 0){
                for (var x = 0; x < val.length; x++){
                    if($.inArray(val[x].name,['External Links','Aggregate Scores','Review Scores']) >= 0) {
                        var fname = 'new_' + val[x].name.toLowerCase().replace(' ','_');
                        if($('#'+fname).length < 1){
                            addField($('#addFieldButton'), usedfields);
                            var select_elem = $('div.newFieldsDiv').find('select:last');
                            select_elem.find('option[value="'+val[x].name.toLowerCase()+'"]').attr('selected', true);
                            addConcreteField(select_elem, false);
                        }
                        var input = $('#'+fname);
                        if(input.val()){
                            input.val(input.val()+', '+val[x].content);
                        }else{
                            input.val(val[x].content);
                        }
                    } else {
                        addField($('#addFieldButton'), usedfields);
                        var select_elem = $('div.newFieldsDiv').find('select:last');
                        select_elem.find('option[value="userdefined"]').attr('selected', true);
                        addConcreteField(select_elem, false);

                        $('#name_userdefined'+(x+1)).val(val[x].name);
                        $('#content_userdefined'+(x+1)).val(val[x].content);
                    }
                }
            } else if($.inArray(i,['mixed_fields']) >= 0){
                if(val.length < 1 && page == "game"){
                    $.each(["developer","publisher","distributor","credits","external links","series"],
                    function(index,value){
                        addField($('#addFieldButton'), usedfields);
                        var select_elem = $('div.newFieldsDiv').find('select:last');
                        select_elem.find('option[value="'+value+'"]').attr('selected', true);
                        addConcreteField(select_elem, false);
                    });
                }
                for (var x = 0; x < val.length; x++){
                    var type = val[x]['mixed_field_type'].name.toLowerCase();
                    var input_field_name = 'new_' + type.replace(' ','_');
                    if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
                        input_field_name = input_field_name + 's';

                    if($('#'+input_field_name).length == 0){
                        addField($('#addFieldButton'), usedfields);
                        var select_elem = $('div.newFieldsDiv').find('select:last');
                        select_elem.find('option[value="'+type+'"]').attr('selected', true);
                        addConcreteField(select_elem, false);
                        $('#'+input_field_name).val('');
                    }
                    var valstr = ''
                    if(val[x].company_id)
                        valstr = valstr + '@comp:' + val[x].company_id;
                    else if(val[x].developer_id)
                        valstr = valstr + '@dev:' + val[x].developer_id;
                    else if(val[x].series_game_id)
                        valstr = valstr + '@game:' + val[x].series_game_id;
                    if(val[x].not_found)
                        valstr = valstr + val[x].not_found
                    else
                        valstr = valstr + ':' + (val[x].additional_info ? val[x].additional_info : '') + ',';

                    $('#'+input_field_name).val($('#'+input_field_name).val()+valstr);
                }
            }  else if($.inArray(i,['official_name']) >= 0){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="official name"]').attr('selected', true);
                addConcreteField(select_elem, false, val);

            }  else if($.inArray(i,['locations']) >= 0){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="location"]').attr('selected', true);
                var locationstring = '';
                $.each(val, function(i,dat){
                   locationstring = locationstring + dat.name;
                   if(dat.additional_info)
                      locationstring = locationstring + ':'+dat.additional_info;
                   locationstring = locationstring + ',';
                });
                addConcreteField(select_elem, false, locationstring);

            }  else if($.inArray(i,['founded','defunct']) >= 0 ){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="'+i+'"]').attr('selected', true);

                addConcreteField(select_elem, false);
                $('#year_'+i).val(val.year);
                $('#month_'+i).val(val.month);
                $('#day_'+i).val(val.day);
                $('#text_'+i).val(val.additional_info);
            }
        });
        // bei neuanlage die felder hinzufügen die nicht im json sind
        if(page == 'developer' && (!data.mixed_fields || data.mixed_fields.length == 0)){
            $.each(["external links"],
                function(index,value){
                    addField($('#addFieldButton'), usedfields);
                    var select_elem = $('div.newFieldsDiv').find('select:last');
                    select_elem.find('option[value="'+value+'"]').attr('selected', true);
                    addConcreteField(select_elem, false);
                });
        }else if(page == 'company'){
            if(!data.mixed_fields || data.mixed_fields.length == 0){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="external links"]').attr('selected', true);
                addConcreteField(select_elem, false);
            }
            if(!data.founded){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="founded"]').attr('selected', true);
                addConcreteField(select_elem, false);
            }
            if(!data.locations){
                addField($('#addFieldButton'), usedfields);
                var select_elem = $('div.newFieldsDiv').find('select:last');
                select_elem.find('option[value="location"]').attr('selected', true);
                addConcreteField(select_elem, false);
            }
        }
    });
}

// ein select zur feldauswahl hinzufügen
function addField(button_element, types){
    $('#newFieldId').removeAttr('id');
    var html = '<div class="addedField"><select class="newField" id="newFieldId">';
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
// ein feld im select ausgewählt => das konkrete feld hinzufügen
function addConcreteField(select_element, deletecurrent){addConcreteField(select_element, deletecurrent, false)}
function addConcreteField(select_element, deletecurrent, value){
    if(deletecurrent)
        $(select_element).parent().find('> :not(select:first)').remove();
    var field_name = $(select_element).val();
    var input_field_name = 'new_' + field_name.replace(' ','_');
    if(input_field_name.lastIndexOf('s') !== (input_field_name.length - 1))
        input_field_name = input_field_name + 's';
    if(field_name == 'remove'){                                                                      // remove field
        $(select_element).parent().remove();

    }else if($.inArray(field_name,['series']) >= 0){                                                 // game references + add info
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+input_field_name+'" name="'+input_field_name+'">' +
            (value ? value : '') +
            '</textarea>');
        at_autocomp(input_field_name+'_dummy', $('#'+input_field_name), '/ajax.json?type=game');

    }else if($.inArray(field_name,['release dates']) >= 0){                                           // dates
        anzDateInputs++;
        var html = '<div class="release_dates_div" id="release_dates_div">';
        html = html + addDateInput('release_date'+anzDateInputs);
        html = html + '<input id="text_release_date'+anzDateInputs+'" name="input_field_name'+anzDateInputs+'" type="text">';
        html = html + '<button type="button" onclick="addConcreteField(this,false);" value="release dates"> + </button></div>';
        $(select_element).parent().append(html);

    }else if($.inArray(field_name,['platform','mode','media', 'genres', 'tags']) >= 0){              // tokenlists
        $.getJSON('/ajax.json?type=all&field='+field_name, function(data){
            var availableTags = data;
            $(select_element).parent().append('<input id="'+input_field_name+'" name="'+input_field_name+'" type="text" value="' +
                (value ? value : '') + '">');
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
        $(select_element).parent().append('<input id="'+field_name.replace(' ','_')+'" name="company['+field_name.replace(' ','_')+ ']" value="' +
            (value ? value : '') + '">');

    }else if($.inArray(field_name,['defunct','founded']) >= 0){                                      // date + string
        $(select_element).parent().append(addDateInput(field_name));
        if(field_name == 'defunct')
            $(select_element).parent().append('<input id="text_'+field_name+'" name="text_'+field_name+'" type="text">');

    }else if($.inArray(field_name,['external links', 'aggregate scores', 'review scores', 'location']) >= 0){    // external links only
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+input_field_name+'" name="'+input_field_name+'">' +
            (value ? value : '') +
            '</textarea>');

    }else if($.inArray(field_name,['developer','publisher','distributor','credits']) >= 0){          // dev/comp references + add info
        $(select_element).parent().append('<textarea cols="40" rows="3" id="'+input_field_name+'" name="'+input_field_name+'">' +
            (value ? value : '') +
            '</textarea>');
        at_autocomp(input_field_name+'_dummy', $('#'+input_field_name), '/ajax.json?type=developer');
    }
}

// helper um datumsinputs hinzuzufügen
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