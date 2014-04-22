# The list of variables
variables = null
# The number of the current index of the line to be executed
indexNumber = 0

# [Debugger: Debug - Story 3.6]
# Sends the code to the server and changes the Variables to the data recieved
# Parameters:
# 	problem_id: The id of the problem being solved
# Returns: none
# Author: Mussab ElDash
@start_debug = (problem_id) ->
	input = $('#solution_code').val()
	test = $('#testcases').val()
	start_spin()
	$.ajax
		type: "POST"
		url: '/debuggers/' + problem_id
		data: {code : input , case : test}
		datatype: 'json'
		success: (data) ->
			toggleDebug()
			variables = data
			stop_spin()
			highlight_line data[0]['line']
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
	if indexNumber + 1 < variables.length
		jump_state ++indexNumber
	else if(indexNumber == 99)
		alert "The online debugger can only step forward 100 times."
	else
		alert "The program has terminated."

# [Execute Line By Line - Story 3.8]
# Moves to the previous state of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil
@previous = () ->
	if indexNumber > 0
		jump_state --indexNumber
	else
		alert "This is the first step in the program."

# [Execute Line By Line - Story 3.8]
# Highlights the target line number in the editor
# Parameters:
#	line: The line number to highlight.
# Returns: none
# Author: Rami Khalil
@highlight_line = (line) ->
	alert "At line: " + line

# [Execute Line By Line - Story 3.8]
# Jumps to the target state by highlighting the line and showing variables
# Parameters:
#	stateNumber: The target state number.
# Returns: none
# Author: Rami Khalil + Khaled Helmy
@jump_state = (stateNumber) ->
	highlight_line variables[stateNumber]['line']
	update_memory_contents stateNumber

# [View Variables - Story 3.7]
# Updates the variables values according to a certain state
# Parameters:
#	stateNumber: The target state number.
# Returns: none
# Author: Khaled Helmy
@update_memory_contents = (stateNumber) ->
	update_memory_contents = (stateNumber) ->
	div = document.getElementById("memory")
	list_of_variables = variables[stateNumber]["locals"]
	s = ""
	i = 0
	while i < list_of_variables.length
    	s += list_of_variables[i]
    	s += "<br />"
    	i++
  	div.innerHTML = s
  	return

# [Debug - Story 3.6]
# Stops the debugging session.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
@stop = () ->
	toggleDebug()
	indexNumber = 0;
	variables = null;
