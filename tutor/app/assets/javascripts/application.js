// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.10.4
//= require jquery.bpopup.min
//= require jquery.simple-dtpicker
//= require jquery.plugin
//= require jquery.countdown
//= require jquery.tokeninput
//= require alertify
//= require cocoon
//= require bootstrap
//= require bootstrap-wysihtml5/b3
//= require bootstrap-wysihtml5/locales
//= require appAssets

// [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
// Adds the behaviour of flash messages of the types alert, notice and error
// 	to fade out after two seconds.
// Parameters: none
// Returns: none
// Author: Khaled Helmy
$(function() {
	var flashCallback = function() {
		return $(".alert, .notice, .error").fadeOut();
	};
	$(".alert, .notice, .error").bind('click', (function(_this) {
		return function(ev) {
			return $(".alert, .notice, .error").fadeOut();
		};
	})(this));
	return setTimeout(flashCallback, 2000);
});

// [Simple Search auto-complete - Story 1.23]
// autocomplete for the search bar
// Parameters:
// 		search term
// Returns: Array with the matched results
// Author: Ahmed Elassuty
$(function(){
	$('#search_field').autocomplete({
		source: $('#search_field').data("autocomplete-source")
	});
});


$(document).ready(function(){
	$('.wysihtml5').each(function(i, elem) {
	  $(elem).wysihtml5();
	});
})

$(function() {
	$( "#tabs" ).tabs();
});
