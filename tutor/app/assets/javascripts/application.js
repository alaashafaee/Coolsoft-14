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
<<<<<<< HEAD
//= require sync
=======
//= require jquery-ui-1.10.4
>>>>>>> 409c730358745f49f6f0886d3effa9179ed46d8f
//= require_tree .
//= require bootstrap
//= require jquery.tokeninput
//= require utilities
<<<<<<< HEAD

=======
//= require jquery.plugin.js
//= require jquery.countdown.js

// [Simple Search auto-complete - Story 1.23]
// autocomplete for the search bar
// Parameters: search term
// Returns: Array with the matched results
// Author: Ahmed Elassuty
$(function(){
	$('#search_field').autocomplete({
		source: $('#search_field').data("autocomplete-source")
	});
});
>>>>>>> 409c730358745f49f6f0886d3effa9179ed46d8f
