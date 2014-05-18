# [Design - Story Design]
# Checks if an element exists in the document
# Parameters:
# 	element_id: The id of the element to be checked
# Returns: True if the element exist and false if not
# Author: Mussab ElDash
@element_exists = (element_id) ->
	$("##{element_id}").length > 0

# [Enhance Design - Story Design]
# There incase needed someday
# Parameters: none
# Returns: none
# Author: Mussab ElDash
$(document).on 'ready page:load', ->
	return

# [Enhance Design - Story Design]
# Checks if an element exists in the document
# Parameters:
# 	element_id: The id of the element to be checked
# Returns: True if the element exist and false if not
# Author: Mussab ElDash
window.alert = (str, type, time) ->
	persistent = !isNaN(parseFloat(time))
	boolean = type == "success" || type == "error" || type == "log"
	if boolean && persistent
		alertify.log(str, type, parseFloat(time)*1000)
	else if boolean
		alertify.log(str, type)
	else
		alertify.alert(str)
	return
return