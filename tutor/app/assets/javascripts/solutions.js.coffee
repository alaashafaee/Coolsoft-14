# The list of variables
Variables = null
# The number of the current index of the line to be executed
IndexNumber = 0

# [Debugger: Debug - Story 3.6]
# Sends the code to the server and changes the Variables to the data recieved
# Parameters:
# 	problem_id: The id of the problem being solved
# Returns: none
# Author: Mussab ElDash
@start_debug = (problem_id) ->
	input = $('#solution_code').val()
	test = $('#testcases').val()
	alert input
	alert test
	start_spin()
	$.ajax
		type: "POST"
		url: '/debuggers/' + problem_id
		data: {code : input , case : test}
		datatype: 'json'
		success: (data) ->
			$('#nextButton').attr "disabled", false
			$('#previousButton').attr "disabled", true
			toggleDebug()
			Variables = data
			stop_spin()
			for datum in data
				alert "#{datum['line']}=>#{datum['locals']}locals is Empty for now"
			return
		error: ->
			stop_spin()
			return
	return

@start_spin = ->
	$('#spinner').attr "class" , "spinner"
	return

@stop_spin = ->
	$('#spinner').attr "class" , ""
	return

# [Execute Line By Line - Story 3.8]
# Toggles debugging mode by changing the available buttons.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
@toggleDebug = () ->
	$('#debugButton').prop 'hidden', !$('#debugButton').prop 'hidden'
	$('#compileButton').prop 'hidden', !$('#compileButton').prop 'hidden'
	$('#testButton').prop 'hidden', !$('#testButton').prop 'hidden'

	$('#nextButton').prop 'hidden', !$('#nextButton').prop 'hidden'
	$('#previousButton').prop 'hidden', !$('#previousButton').prop 'hidden'
	$('#stopButton').prop 'hidden', !$('#stopButton').prop 'hidden'

# [Compile - Story 3.4]
# Sends the code to the server to be compiled.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
@compile = () ->
	alert "Compiling"

# [Test - Story 3.15]
# Sends the code and the input to be processed on the server.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
@test = () ->
	alert "Testing"

# [Execute Line By Line - Story 3.8]
# Moves to the next state of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil
@next = () ->
	alert "Next Step"

# [Execute Line By Line - Story 3.8]
# Moves to the previous state of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil
@previous = () ->
	alert "Previous Step"

# [Debug - Story 3.6]
# Stops the debugging session.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
@stop = () ->
	toggleDebug()
