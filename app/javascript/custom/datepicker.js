// -----------------------------------------------------------------------------
// DATETIMEPICKER
// 
// See more examples on https://flatpickr.js.org/examples
// -----------------------------------------------------------------------------

import flatpickr from "flatpickr";
// import { Croatian } from "flatpickr/dist/l10n/hr.js"

// require("flatpickr/dist/flatpickr.css");

window.initDatepicker = function(){
  flatpickr('.js-input-datepicker', {
    //    locale: I18n.locale,
    enableTime: false,
    dateFormat: "d.m.Y."
  });

}

window.initDateTimepicker = function(){
  flatpickr('.js-input-datetimepicker', {
    //locale: I18n.locale,
    enableTime: true,
    dateFormat: "d.m.Y. H:i",
    time_24hr: true
  });

}

window.initTimepicker = function(){
  flatpickr('.js-input-timepicker', {
    //locale: I18n.locale,
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true
  });

}

window.initFtDatepicker = function(){
  flatpickr('.js-input-futurepicker', {
    //locale: I18n.locale,
    enableTime: false,
    dateFormat: "d.m.Y.",
    minDate: new Date().fp_incr(1)
  });

}

window.initRangeDatepicker = function(){
  var pickers_from = [];
  document.querySelectorAll('.js-input-datepicker-from').forEach(function(element, index){
    pickers_from.push(
      flatpickr(element, {
        //   locale: I18n.locale,
        enableTime: false,
        dateFormat: "d.m.Y.",
        time_24hr: true,
        onChange: function(selectedDates, dateStr, instance) {
          pickers_to[index].set('minDate', selectedDates[0].fp_incr(1));
        }
      })
    )
  });

  var pickers_to = [];
  document.querySelectorAll('.js-input-datepicker-to').forEach(function(element, index){
    pickers_to.push(
      flatpickr(element, {
        //locale: I18n.locale,
        enableTime: false,
        dateFormat: "d.m.Y.",
        time_24hr: true,
        onChange: function(selectedDates, dateStr, instance) {
          pickers_from[index].set('maxDate', selectedDates[0].fp_incr(-1));
        }
      })
    )
  });

}
