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
# Makes the list of tracks sortable.
#	Sends array of new order of tracks to the sort action 
#	in topic's controller.  
# Parameters: none
# Returns: none
# Author: Lin Kassem
@test = ->  
	document.getElementById("editTrackRatingbtn").style= "display: none;"  
	document.getElementById("submitNewRatingbtn").style= "display: true;" 
	document.getElementById("new_track").style= "display: none;"
	$('.in').removeClass 'in'
	$('.glyphicon-chevron-down').removeClass 'glyphicon-chevron-down'
	$('.glyphicon-chevron-right').removeClass 'glyphicon-chevron-right'
	$("#accordion").sortable
		placeholder: "ui-state-highlight"
		axis: "y"
		tolerance: "pointer"
		forcePlaceholderSize: true
		cursor: "move"
		containment: "parent"
	return

@submitNewRating = ->
	array = $("#accordion").sortable("toArray")
	$.ajax
		url: "/topics/sort"
		type: "POST"
		beforeSend: (xhr) ->
			xhr.setRequestHeader "X-CSRF-Token",
			 $("meta[name=\"csrf-token\"]").attr("content")
			return
		success: (data) ->
			$("#alert").removeClass().addClass("alert alert-success").
			text "New track ratings saved!"
			window.setTimeout (->
				location.reload()
				return
			), 2000
			return
		error: (data) ->
			$("#alert").removeClass().addClass("alert alert-warning").
			text "Error! New track rating cannot be saved."
			window.setTimeout (->
				location.reload()
				return
			), 2000
			return
		data:
			methodParam: array
	return

$ ->
	$(".btn-info").tooltip()
	return