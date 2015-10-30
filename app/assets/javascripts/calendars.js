$(document).ready(function() {
  addIconsToCalendar();
  setupDateTimePickers();
})

function setupDateTimePickers() {
  // ----- setup for bootstrap datetime pickers --------------------------------
  // 1. moment.js formats info: http://momentjs.com/docs/#/displaying/format/
  //    datetimepicker will use the format to adjust what pickers are displayed.
  // 2. weekends are disabled by default:
  //    - daysOfWeekDisabled: [0, 6]
  // 3. hours outside 1-8pm are disabled by default:
  //    - enabledHours: [13, 14, 15, 16, 17, 18, 19, 20]
  // NOTE: locales are not yet supported by these form elements. ;_;
  $('.datetimepicker').datetimepicker({ daysOfWeekDisabled: [0, 6] });
  $('.datepicker').datetimepicker({ format: 'll', daysOfWeekDisabled: [0, 6] });
  $('.timepicker-start').datetimepicker({
    format: 'LT',
    enabledHours: [13, 14, 15, 16, 17],
  });

  $('.timepicker-end').datetimepicker({
    format: 'LT',
    enabledHours: [16, 17, 18, 19, 20],
  });
}

// 1. when document is ready, check for event divs inside each date.
// 2. for any weekday:
//    - if less than x TAs*, display an empty battery icon.
//      NOTE: x TAs is currently hard-coded to 3. see second line in for loop.
//    - otherwise, display a full battery icon.
//    - if pending events on that day, display a bolt icon.
function addIconsToCalendar() {
  var visibleDays = $('.day');

  // looping through the days
  for (var i = 0; i < visibleDays.length; i++) {
    var day = visibleDays[i];
    var tasRequired = 3 || $(day).attr('data-tas-required');
    var taCount = $(day).children('.event').length;
    var pendingCount = $(day).children('.pending').length;

    // we don't care about weekends
    if (!$(day).hasClass('wday-0') && !$(day).hasClass('wday-6')) {
      addBattery(day, taCount, tasRequired);
      addPending(day, pendingCount);
    }
  }

  var legend = $('#legend');
  addLegend(legend);
}

function addBattery(day, taCount, tasRequired) {
  var icon = $('<div class="icon"></div>');

  if (taCount < tasRequired) {
    $(day).addClass('low');
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

function addPending(day, pendingCount) {
  if (pendingCount > 0) {
    var bolt = ('<i class="fa fa-bolt"></i>');
    $(day).append(bolt);
  } else {
    $(day).append('<br />');
  }
}

function addLegend(legendDiv) {
  var empty = $('<div class="low left col-xs-4"></div>');
  empty.text(" = Not enough TAs.");
  empty.prepend('<i class="icon fa fa-battery-quarter"></i>');

  var medium = $('<div class="col-xs-4"></div>');
  medium.text(" = Pending event.");
  medium.prepend('<i class="fa fa-bolt"></i>');

  var full = $('<div class="full right col-xs-4"></div>');
  full.text(" = Enough TAs!");
  full.prepend('<i class="icon fa fa-battery-full"></i>');

  legendDiv.append(empty);
  legendDiv.append(medium);
  legendDiv.append(full);
}
