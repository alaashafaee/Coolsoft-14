# [Create Track - Story 4.1]
# triggers the visibilty of the create track form
# Author: Mussab ElDash
@newTrack = ->
	create = document.getElementById("create_track")
	if create.hidden is true
		create.hidden = false
	else
		create.hidden = true
	return
