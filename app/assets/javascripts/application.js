// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker

var NAVBAR_HEIGHT_CLOSED = 103;
var NAVBAR_HEIGHT_OPEN = 252;

$(function(){
  $("button[data-toggle='collapse']").click(function() {
    toggleNavPadding();
    console.log("NAVBAR TOGGLE BUTTON CLICKED");
  });
});

// make room for expanded navbar
var toggleNavPadding = function() {
  if (parseInt($("body").css("padding-top")) > NAVBAR_HEIGHT_CLOSED) {
    $("body").animate({ "padding-top": "-=212" }, 200);
  }
  else {
    $("body").animate({ "padding-top": "+=212" }, 200);
  }
};
