# [course resources - Story 1.25]
# delete resource
# Parameters:
# 	  resource id
# Returns: on success deletes resource
# Author: Ahmed Elassuty

$(document).ready ->
	$("#resources").on "cocoon:before-remove", (e, resource) ->
		$(this).data "remove-timeout", 1000
		x = resource[0].children[1].id.replace("link","id")
		if $("#"+x)[0]
			id = $("#"+x)[0].value
			$.ajax
				url: id
				type: "DELETE"
				success: (result) ->
					document.getElementById(x).remove()
		resource.fadeOut "slow"

	$("#resources").on "cocoon:after-remove", (e, resource) ->
		resource.remove()

	$("#resources").on "cocoon:before-insert", (e, resource) ->

	$(".resource").on "cocoon:after-insert", (e, resource) ->