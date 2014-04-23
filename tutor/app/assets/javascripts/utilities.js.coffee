# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#auto_complete").tokenInput "/utilities/auto_complete.json",
		crossDomain: false
		prePopulate: [$("#auto_complete").data("load")]
		hintText: ""
		tokenLimit: 1
		minChars: 1
		resultsLimit: 1
		theme: ""