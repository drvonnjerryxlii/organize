// when document ready, check for event divs inside each date
// for any weekday after today, if less than x TAs put an empty battery icon in
// otherwise, put in a full battery icon
$(document).ready(function() {
  var visibleDays = $('.day');

  // looping through the days
  for (var i = 0; i < visibleDays.length; i++) {
    var day = visibleDays[i];
    var tasRequired = 3 || $(day).attr('data-tas-required');
    var taCount = $(day).children('.event').length;

    // we don't care about weekends
    if (!$(day).hasClass('wday-0') && !$(day).hasClass('wday-6')) {
      addBattery(day, taCount, tasRequired);
    }
  }

  var legend = $('#legend');
  addLegend(legend);
})

function addBattery(day, taCount, tasRequired) {
  var icon = $('<div class="icon"></div>');

  if (taCount +1 == tasRequired) {
    $(day).addClass('one-short');
    icon.append('<i class="fa fa-battery-three-quarters"></i>');
  } else if (taCount < tasRequired) {
    $(day).addClass('two-plus-short');
    icon.append('<i class="fa fa-battery-quarter"></i>');
    icon.append("-", tasRequired - taCount);
    $(day).append(icon);
  } else {
    $(day).addClass('full');
    icon.append('<i class="fa fa-battery-full"></i>');
    if (taCount > tasRequired) {
      icon.append("+", taCount - tasRequired);
    }
  }

  $(day).append(icon);
}

function addLegend(legendDiv) {
  var empty = $('<div class="two-plus-short left col-xs-4"></div>');
  empty.text(" = Not enough TAs.");
  empty.prepend('<i class="icon fa fa-battery-three-quarters"></i>');

  var medium = $('<div class="one-short col-xs-4"></div>');
  medium.text(" = Almost there.");
  medium.prepend('<i class="icon fa fa-battery-quarter"></i>');

  var full = $('<div class="full right col-xs-4"></div>');
  full.text(" = Full!");
  full.prepend('<i class="icon fa fa-battery-full"></i>');

  legendDiv.append(empty);
  legendDiv.append(medium);
  legendDiv.append(full);
}
