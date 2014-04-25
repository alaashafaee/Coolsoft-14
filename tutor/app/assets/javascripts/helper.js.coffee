# [Design - Story Design]
# Checks if an element exists in the document
# Parameters: 
# 	element_id: The id of the element to be checked
# Returns: True if the element exist and false if not
# Author: Mussab ElDash
@element_exists = (element_id) ->
	$("##{element_id}").length > 0
