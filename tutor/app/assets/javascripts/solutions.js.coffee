# The list of variables
Variables = null
# The number of the current line to be executed
LineNumber = 0

# [Debugger: Debug - Story 3.6]
# Sends the code to the server and changes the Variables to the data recieved
# Parameters: 
# 	problem_id: The id of the problem being solved
# Returns: None
# Author: Mussab ElDash
@start_debug = (problem_id) ->
	input = document.getElementById('solution_code').value
	test = document.getElementById('testcases').value
	alert input
	alert test
	$.ajax
		type: "POST"
		url: '/debug/' + problem_id
		data: {id : problem_id , code : input , case : test}
		datatype: 'json'
		success: (data) ->
			Variables = data
			$.each data, (ia, da) ->
				alert da["line"] + "=>" + da["locals"] + "da[locals] is Empty for now"
			document.getElementById('next').disabled = false
			document.getElementById('previous').disabled = true
			# toggleDebug
			return
	return