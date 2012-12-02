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
    if($(select_element).val() == 'remove'){
        $(select_element).parent().remove();
        return;
    }else if($(select_element).val() == 'genres'){

    }else if($(select_element).val() == 'developer'){
        $(select_element).parent().append('<input id="new_developers" name="new_developers" type="text">');
        $('#new_developers').autocomplete({source: '/tags.json?type=developer'});
    }
}