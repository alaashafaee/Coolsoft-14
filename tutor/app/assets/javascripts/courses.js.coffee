# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
src="//code.jquery.com/jquery-1.10.2.js">
src="//code.jquery.com/ui/1.10.4/jquery-ui.js">

$(document).ready ->
	$("#list-of-topics").sortable
		placeholder: "ui-state-highlight"
		axis: "y"
		tolerance: "pointer"
		forcePlaceholderSize: true
		cursor: "move"
		containment: "parent"

	$("#order_topics_dialog").dialog
		autoOpen: false
		modal: true
		width: "auto"
		height: "auto"
		autoResize: false
		buttons:
			Done: ->
				array = $("#list-of-topics").sortable("toArray")
				$.ajax
					url: "/courses/sort"
					type: "POST"
					beforeSend: (xhr) ->
						xhr.setRequestHeader "X-CSRF-Token", 
						$("meta[name=\"csrf-token\"]").attr("content")
						return
					data:
						methodParam: array
					success: (data) ->
						alert "New topics order saved!"
						location.reload()
						return
					error: (args) ->
						alert "This is embarrasing :)"
						return
				$(this).dialog "close"
				return
			Cancel: ->
				$(this).dialog "close"
				alert "Changes will not be saved !"				
				return
	$("#opener").click(->
		$("#order_topics_dialog").dialog "open"
		$("#order_topics_dialog").css "overflow", "hidden"
		return
	).disableSelection()
	return

