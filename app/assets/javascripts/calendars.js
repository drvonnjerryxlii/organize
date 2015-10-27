// when document ready, check for event divs inside each date
// for any weekday after today, if less than x TAs put an empty battery icon in
// otherwise, put in a full battery icon
$(document).ready(function() {
  var visibleDays = $('.day');
  var tasRequired = 1;

  // looping through the days
  for (var i = 0; i < visibleDays.length; i++) {
    var day = visibleDays[i];
    var taCount = $(day).children().length;

    // we don't care about weekends
    if (!$(day).hasClass('wday-0') && !$(day).hasClass('wday-6')) {
      if (taCount < tasRequired) {
        $(day).addClass('vacancy');
        var icon = $('<div class="icon"><i class="fa fa-battery-quarter"></i></div>');
        $(day).append(icon);
      } else {
        $(day).addClass('full');
        var icon = $('<div class="icon"><i class="fa fa-battery-full"></i></div>');
        $(day).append(icon);
      }
    }
  }
})
