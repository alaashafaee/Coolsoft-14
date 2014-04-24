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
	if input.length is 0
		alert "You didn't write any code"
		return
	test = $('#solution_input').val()
	start_spin()
	$.ajax
		type: "POST"
		url: '/debuggers/' + problem_id
		data: {code : input , case : test}
		datatype: 'json'
		success: (data) ->
			stop_spin()
			if !data["success"]
				compilation_error data["data"]["errors"]
				return
			variables = data["data"]
			toggleDebug()
			debug_console()
			jump_state 0
		error: ->
			stop_spin()
			return
	return

# [Debugger: Debug - Story 3.6]
# Fills the console with the compilation errors
# Parameters: none
# Returns: none
# Author: Mussab ElDash
compilation_error = (data) ->
	$('.compilation_failed').html("Compilation Failed!")
	$('.compilation_feedback').html(data)
	return

# [Debugger: Debug - Story 3.6]
# Clears the console
# Parameters: none
# Returns: none
# Author: Mussab ElDash
clear_console = ->
	$('.compilation_failed').html("")
	$('.compilation_feedback').html("")
	return

# [Debugger: Debug - Story 3.6]
# Write successful debug in the console
# Parameters: none
# Returns: none
# Author: Mussab ElDash
debug_console = ->
	$('.compilation_succeeded').html("Debugging Succeeded!")
	return

# [Debugger: Debug - Story 3.6]
# Starts the Spinner
# Parameters: none
# Returns: none
# Author: Mussab ElDash
@start_spin = ->
	$('#spinner').addClass "spinner"
	return

# [Debugger: Debug - Story 3.6]
# Stops the Spinner
# Parameters: none
# Returns: none
# Author: Mussab ElDash
@stop_spin = ->
	$('#spinner').removeClass "spinner"
	return

# [Debugger: Debug - Story 3.6]
# Toggles the Spinner
# Parameters: none
# Returns: none
# Author: Mussab ElDash
@toggle_spin = ->
	$('#spinner').toggleClass "spinner"

# [Execute Line By Line - Story 3.8]
# Toggles debugging mode by changing the available buttons.
# Parameters: none
# Returns: none
# Author: Rami Khalil (Temporary)
@toggleDebug = ->
	$('#debugButton').prop 'hidden', !$('#debugButton').prop 'hidden'
	$('#compileButton').prop 'hidden', !$('#compileButton').prop 'hidden'
	$('#testButton').prop 'hidden', !$('#testButton').prop 'hidden'
	$('#solution_code').prop 'disabled', !$('#solution_code').prop 'disabled'

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
	highlight_line variables[stateNumber]['line'] - 2
	show_runtime stateNumber
	update_memory_contents stateNumber

# [Debugger: Debug - Story 3.6]
# Shows the runtime error in its correcsponding section in the page
# Parameters:
# 	stateNumber: The target state number.
# Returns: none
# Author: Mussab ElDash
show_runtime = (stateNumber) ->
	runtime = variables[stateNumber]['exception']
	explain = variables[stateNumber]['explain']

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

# To be Used when changing to ajax in order not to refresh page
# [Compiler: Validate - Story 3.5]
# submits a solution in the form without refreshing
# 	using ajax showing an alert box for success and failure scenarios
# Parameters:
# 	problem_id: the id of the problem being solved
# Returns: a json object containing two arrays one for the errors
#	of the current code and the other containing success messages
# Author: MOHAMEDSAEED
@validate_code = (problem_id) ->
	code = $('#solution_code').val()
	mins = parseInt($('#mins').text())
	secs = parseInt($('#secs').text())
	time = mins*60 + secs
	start_spin()
	$.ajax
		type: "POST"
		url: '/solutions'
		data: {problem_id: problem_id, code: code, time: time}
		datatype: 'json'
		success: (data) ->
			stop_spin()
			success = $('#validate_success')
			errors = $('#validate_error')
			success.html("")
			for i in data["success"]
				success.append("#{i}<br>")
			errors.html("")
			for i in data["failure"]
				errors.append("#{i}<br>")
			if code.length isnt 0
				alert 'Solution has been submitted successfully'
			else
				alert 'Blank submissions are not allowed'
			return
		error: (data) ->
			stop_spin()
			return
	return
