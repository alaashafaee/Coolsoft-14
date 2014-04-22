# The list of variables
variables = null
# The number of the current index of the line to be executed
index_number = 0

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
			jump_state 0
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
# Parameters: none
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
# Parameters: none
# Returns: none
# Author: Rami Khalil (Temporary)
@compile = () ->
	alert "Compiling"

# [Test - Story 3.15]
# Sends the code and the input to be processed on the server.
# Parameters: none
# Returns: none
# Author: Rami Khalil (Temporary)
@test = () ->
	alert "Testing"

# [Execute Line By Line - Story 3.8]
# Moves to the next state of execution.
# Parameters: none
# Returns: none
# Author: Rami Khalil
@next = () ->
	if index_number + 1 < variables.length
		jump_state ++index_number
	else if(index_number == 99)
		alert "The online debugger can only step forward 100 times."
		jump_state index_number
	else
		alert "The program has terminated."
		jump_state index_number

# [Execute Line By Line - Story 3.8]
# Moves to the previous state of execution.
# Parameters: none
# Returns: none
# Author: Rami Khalil
@previous = () ->
	if index_number > 0
		jump_state --index_number
	else
		alert "This is the first step in the program."
		jump_state index_number

# [Execute Line By Line - Story 3.8]
# Highlights the target line number in the editor
# Parameters:
#	line: The line number to highlight.
# Returns: none
# Author: Rami Khalil
@highlight_line = (line) ->
	text_area = document.getElementById "solution_code"
	code_lines = text_area.value.split '\n'
	start_offset = 0
	for i in[0..code_lines.length] by 1
		if i == line
			break
		start_offset += code_lines[i].length+1
	end_offset = start_offset + code_lines[line].length

	# Chrome / Firefox
	if typeof(text_area.selectionStart) != "undefined"
		text_area.focus()
		text_area.selectionStart = start_offset
		text_area.selectionEnd = end_offset

	# IE
	if document.selection && document.selection.createRange
		text_area.focus()
		text_area.select()
		document.selection.createRange()
		text_area.collapse(true)
		text_area.moveEnd("character", end_offset)
		text_area.moveStart("character", start_offset)
		text_area.select()

# [Execute Line By Line - Story 3.8]
# Jumps to the target state by highlighting the line and showing variables
# Parameters:
#	stateNumber: The target state number.
# Returns: none
# Author: Rami Khalil + Khaled Helmy
@jump_state = (stateNumber) ->
	highlight_line variables[stateNumber]['line'] - 1
	update_memory_contents stateNumber

# [View Variables - Story 3.7]
# Updates the variables values according to a certain state
# Parameters:
#	stateNumber: The target state number.
# Returns: none
# Author: Khaled Helmy
@update_memory_contents = (stateNumber) ->
	div = document.getElementById("memory")
	list_of_variables = variables[stateNumber]["locals"]
	content = '<table class="table table-striped table-bordered table-condensed table-hover" border="3">'
	content += "<tr class='info'><th>Variable</th><th>Value</th></tr>"
	i = 0
	while i < list_of_variables.length
		values = list_of_variables[i].split " = "
		content += "<tr class='success'><td>" + values[0] + "</td>"
		content += "<td>" + values[1] + "</td></tr>"
		i++
	content += "</table>"
	div.innerHTML = content
	return

# [Debug - Story 3.6]
# Stops the debugging session.
# Parameters: none
# Returns: none
# Author: Rami Khalil (Temporary)
@stop = () ->
	toggleDebug()
	index_number = 0;
	variables = null;
