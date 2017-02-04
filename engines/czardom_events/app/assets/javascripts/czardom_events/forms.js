//= require moment
//= require daterangepicker

/* global $ */
/* global moment */
$.fn.serializeObject = function() {
  var o = {};
  var a = this.serializeArray();
  $.each(a, function() {
    if (o[this.name]) {
      if (!o[this.name].push) {
        o[this.name] = [o[this.name]];
      }
      o[this.name].push(this.value || '');
    } else {
      o[this.name] = this.value || '';
    }
  });
  return o;
};

$(document).ready(function() {
  $('.daterangeselect').daterangepicker({
    timePicker: true,
    format: 'YYYY-MM-DD h:mma',
    timePickerIncrement: 15,
    timePicker12Hour: true,
    timePickerSeconds: false,
    opens: 'right',
    separator: ' to ',
    hideAfterRange: false,
    ranges: {
      'Tomorrow': [moment().add(1, 'day'), moment().add(1, 'day')],
      'This Friday': [moment().day(5), moment().day(5)],
      'Next Week': [moment().week(moment().week() + 1).day(1), moment().week(moment().week() + 1).day(5)]
    }
  });

  if( $('#group_id').length ) {
    $('#group_id')
      .select2('destroy')
      .select2({
        theme: 'bootstrap',
        minimumResultsForSearch: Infinity,
        templateResult: function(group) {
          if( !group.id ) { return group.text; }
          var el = $(group.element);
          var $group = $(
            '<span><img class="group-select-image" src="' + el.data('image-url') + '"> ' + group.text + '</span>'
          );
          return $group;
        }
      });
  }
  
  $('#submitBtn').click(function(e) {
    var form_data = $(e.target).closest("form").serializeObject();
    $(".modal #title").text(form_data["event[title]"]);
    $(".modal #description").text($(form_data["event[description]"]).text());
    $(".modal #group").text($("#new_event #group_id option:selected").text());
    $(".modal #timeframe").text(form_data["event[timeframe]"]);
    $(".modal #street1").text(form_data["event[address_attributes][street]"]);
    $(".modal #street2").text(form_data["event[address_attributes][street2]"]);
    $(".modal #city").text(form_data["event[address_attributes][city]"]);
    $(".modal #state").text(form_data["event[address_attributes][state]"]);
    $(".modal #zipcode").text(form_data["event[address_attributes][zip_code]"]);
    $(".modal #country").text(form_data["event[address_attributes][country]"]);
  });

  $('#modal-submit').click(function(e){
    var $form = $("#confirm-submit").siblings("form").first();
    setTimeout(function(){
      $form.submit();
    }, 100);
  });
});
