# [Create Track - Story 4.1]
# Triggers the visibilty of the create track form
# Author: Mussab ElDash
@newTrack = ->
	create = document.getElementById("create_track")
	new_track = document.getElementById("new_track")
	create.hidden = !create.hidden
	if create.hidden
		new_track.innerText = "New"
	else
		new_track.innerText = "Hide"
	return

# [Edit Track Rating - Story 4.13]
# Makes the list of track sortable.
#	Sends array of new order of tracks to the sort action 
#	in topic's controller.  
# Parameters: none
# Returns: none
# Author: Lin Kassem
$(document).ready ->
	$("#list-of-tracks").sortable
		placeholder: "ui-state-highlight"
		axis: "y"
		tolerance: "pointer"
		forcePlaceholderSize: true
		cursor: "move"
		containment: "parent"

	$("#edit_track_rating_dialog").dialog
		autoOpen: false
		modal: true
		width: "auto"
		height: "auto"
		autoResize: false
		buttons:
			Done: ->
				array = $("#list-of-tracks").sortable("toArray")
				$.ajax
					url: "/topics/sort"
					type: "POST"
					beforeSend: (xhr) ->
						xhr.setRequestHeader "X-CSRF-Token",
						$("meta[name=\"csrf-token\"]").attr("content")
						return

					data:
						methodParam: array

					success: (data) ->
						alert "New track ratings saved!"
						location.reload()
						return

					error: (args) ->
						alert "Error on ajax post"
						return

				$(this).dialog "close"
				return

			Cancel: ->
				$(this).dialog "close"
				alert "Changes will not be saved !"
				
				return

	$("#opener").click(->
		$("#edit_track_rating_dialog").dialog "open"
		$("#edit_track_rating_dialog").css "overflow", "hidden"
		return
	).disableSelection()
	return