// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

$(document).ready(function() {
  function pushContentBelowNavbar() {
    // get height of navbar
    var nav = $('nav');
    var navHeight = nav.height();

    // adjust spacer to bump content down by same height
    var spacer = $('#spacer');
    spacer.css({ "min-height": navHeight + 30 + 'px' });

    // drop padding from main element
    var main = $('main');
    main.css({ "padding": 0 });
  }

  // run once after document ready
  pushContentBelowNavbar();

  // repeat whenever the size of the navbar might change
  $(window).resize(function() {
    pushContentBelowNavbar();
  });

  $(window).load(function() {
    pushContentBelowNavbar();
  });
});
