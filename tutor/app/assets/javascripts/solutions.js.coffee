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
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/debuggers/' + problem_id
		data: {code : input , case : test}
		datatype: 'json'
		success: (data) ->
			clear_console()
			variables = data
			stop_spin()
			if !data["success"]
				compilation_error data["data"]["errors"]
				return
			variables = data["data"]
			toggleDebug(1)
			debug_console()
			jump_state 0
		error: ->
			clear_console()
			stop_spin()
			toggle_code_area()
			return
	return

# [Compiler: Test - Story 3.15]
# Sends the code to the server to be compiled
# Parameters:
# 	problem_id: The id of the problem being solved
# Returns: 
#	none
# Author: Ahmed Akram
@compile = (problem_id) ->
	input = $('#solution_code').val()
	if input.length is 0
		alert "You didn't write any code"
		return
	start_spin()
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/solutions/compile_solution'
		data: {code : input, problem_id : problem_id}
		datatype: 'json'
		success: (unique) ->
			clear_console()
			stop_spin()
			toggle_code_area()
			if !unique["success"]
				compilation_error unique["errors"]
				return
			$('.compilation_succeeded').html("Compilation Succeeded!")
		error: ->
			clear_console()
			stop_spin()
			toggle_code_area()
			return
	return

# [Compiler: Test - Story 3.15]
# Sends the code and the test case to the server to be tested
# Parameters:
# 	problem_id: The id of the problem being solved
# Returns: 
#	none
# Author: Ahmed Akram
@run_input = (problem_id) ->
	code = $('#solution_code').val()
	if code.length is 0
		alert "You didn't write any code"
		return
	test = $('#solution_input').val()
	start_spin()
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/solutions/execute'
		data: {code : code, problem_id : problem_id, input: test}
		datatype: 'json'
		success: (data) ->
			clear_console()
			stop_spin()
			toggle_code_area()
			if data["compiler_error"]
				compilation_error data["compiler_output"]
				return
			else if data["executer_feedback"]
				input_test_output data["executer_output"]
				return
			else
				runtime_error data["executer_output"]
				return
		error: ->
			clear_console()
			stop_spin()
			toggle_code_area()
			return
	return

# [Compiler: Test - Story 3.15]
# Fills the console with the runtime errors
# Parameters:
# 	data: The hash containing the response
# Returns: 
#	none
# Author: Ahmed Akram
input_test_output = (data) ->
	$('#output_section').html(data["message"])
	return

# [Compiler: Test - Story 3.15]
# Disables the code and input area while debugging, compiling or running test case
# Parameters:
# 	none
# Returns: 
#	none
# Author: Ahmed Akram
toggle_code_area = ->
	$('#solution_code').prop 'disabled', !$('#solution_code').prop 'disabled'
	$('#solution_input').prop 'disabled', !$('#solution_input').prop 'disabled'

# [Compiler: Test - Story 3.15]
# Fills the console with the runtime errors
# Parameters:
# 	data: The hash containing the response
# Returns: 
#	none
# Author: Ahmed Akram
runtime_error = (data) ->
	$('#runtime_error').toggle(true)
	$('#error_section').html(if data["errors"] then data["errors"] else data)
	$('#explanation_section').html(data["explanation"])
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
clear_console = () ->
	$('#runtime_error').toggle(false)
	$('.compilation_succeeded').html("")
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

# [Compiler: Test - Story 3.15]
# Toggles debugging mode by changing the available buttons.
# Parameters: 
#	none
# Returns: 
#	none
# Author: Ahmed Akram
@toggleDebug = (state) ->
	$('#debugButton').toggle(!state)
	$('#compileButton').toggle(!state)
	$('#testButton').toggle(!state)
	$('#nextButton').toggle(state)
	$('#previousButton').toggle(state)
	$('#stopButton').toggle(state)

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
	toggleDebug(0)
	index_number = 0;
	toggle_code_area()
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