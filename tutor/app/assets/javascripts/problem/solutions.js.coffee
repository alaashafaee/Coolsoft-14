# The list of variables
variables = null
# The number of the current index of the line to be executed
index_number = 0
# The status of the debugging session
status = "The debugging session was successful."

# [Debugger: Debug - Story 3.6]
# Sends the code to the server and changes the Variables to the data recieved
# Parameters:
# 	problem_id: The id of the problem being solved
#	problem_type: The type of the problem to be submitted
# Returns: none
# Author: Mussab ElDash
@start_debug = (problem_id, problem_type) ->
	input = get_editor_session().getValue()
	if input.length is 0
		alert "You didn't write any code"
		return
	test = $('#solution_input').val()
	class_name = $("#class_name").val()
	lang = get_lang()
	start_spin()
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/debuggers/' + problem_id
		data: {code: input, case: test, class_name: class_name,\
				problem_type: problem_type, lang: lang}
		datatype: 'json'
		success: (data) ->
			clear_console()
			stop_spin()
			if data["data"] is false
				toggle_code_area()
				return
			unless data["success"]
				compilation_error data["data"]["errors"]
				toggle_code_area()
				return
			variables = data["data"]
			status = data["status"]
			alert status
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
#	problem_type: The type of the problem to be submitted
# Returns:
#	none
# Author: Ahmed Akram
@compile = (problem_id, problem_type) ->
	input = get_editor_session().getValue()
	class_name = $("#class_name").val()
	lang = get_lang()
	if input.length is 0
		alert "You didn't write any code"
		return
	start_spin()
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/solutions/compile_solution'
		data: {code: input, problem_id: problem_id,\
			class_name: class_name, problem_type: problem_type, lang: lang}
		datatype: 'json'
		success: (compiler_feedback) ->
			clear_console()
			stop_spin()
			toggle_code_area()
			if !compiler_feedback["success"]
				compilation_error compiler_feedback["errors"]
				return
			$('.compilation_succeeded').html("Compilation Succeeded!")
			$('.compilation_feedback').html(compiler_feedback["warnings"])
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
#	problem_type: The type of the problem to be submitted
# Returns:
#	none
# Author: Ahmed Akram
@run_input = (problem_id, problem_type) ->
	code = get_editor_session().getValue()
	if code.length is 0
		alert "You didn't write any code"
		return
	test = $('#solution_input').val()
	class_name = $("#class_name").val()
	lang = get_lang()
	start_spin()
	toggle_code_area()
	$.ajax
		type: "POST"
		url: '/solutions/execute'
		data: {code: code, problem_id: problem_id, case: test,\
			class_name: class_name, problem_type: problem_type, lang: lang}
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
	$('#solution_input').prop 'disabled', !$('#solution_input').prop 'disabled'
	$('#mode').prop 'disabled', !$('#mode').prop 'disabled'

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
	$('#validate_case').html("")
	$('#output_section').html("")
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
# Author: Ahmed Akram + Rami Khalil
@toggleDebug = (state) ->
	$('#debugButton').toggle(!state)
	$('#compileButton').toggle(!state)
	$('#testButton').toggle(!state)
	$('#nextButton').toggle(state)
	$('#previousButton').toggle(state)
	$('#stopButton').toggle(state)
	editor = get_editor()
	editor.setReadOnly(state)


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
		alert status
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
	editor = get_editor()
	editor.gotoLine line, 0, true

# [Execute Line By Line - Story 3.8]
# Jumps to the target state by highlighting the line and showing variables
# Parameters:
#	state_number: The target state number.
# Returns: none
# Author: Rami Khalil + Khaled Helmy
@jump_state = (state_number) ->
	highlight_line variables[state_number]['line']
	if state_number isnt 0
		clear_console()
	$("#output_section").html variables[state_number]["stream"]
	if variables[state_number]["exception"]
		runtime_error variables[state_number]["exception"]
	update_memory_contents state_number
	update_stack_trace state_number

# [View Variables - Story 3.7]
# Updates the variables values according to a certain state
# Parameters:
#	state_number: The target state number.
# Returns: none
# Author: Khaled Helmy
@update_memory_contents = (state_number) ->
	div = document.getElementById("memory")
	list_of_variables = variables[state_number]["locals"]
	content = '<table class="table table-striped table-bordered table-condensed table-hover" border="3">'
	content += "<tr class='info'><th>Variable</th><th>Value</th></tr>"
	globals = ""
	global = "global"
	i = 0
	while i < list_of_variables.length
		values = list_of_variables[i].split " = "
		tmp = values[0].split "."
		if tmp[0] == global
			globals += "<tr class='success'><td>" + tmp[1] + "</td>"
			globals += "<td>" + values[1] + "</td></tr>"
		else
			content += "<tr class='success'><td>" + values[0] + "</td>"
			content += "<td>" + values[1] + "</td></tr>"
		i++
	content += "</table>"
	if globals.length > 0
		append = '<table class="table table-striped table-bordered table-condensed table-hover" border="3">'
		append += "<tr class='info'><th>Variable</th><th>Value</th></tr>"
		globals = append + globals
		globals += "</table>"
	# div.innerHTML = globals + content
	div.innerHTML = globals
	return

# [View Variables - Story 3.7]
# Updates the stack trace according to a certain state
# Parameters:
#	state_number: The target state number.
# Returns: none
# Author: Khaled Helmy
@update_stack_trace = (state_number) ->
	div = document.getElementById("stack")
	list_of_methods = variables[state_number]["stack"]
	content = '<table class="table table-striped table-bordered table-condensed table-hover" border="3">'
	content += "<tr class='info'><th>Stack Trace</th></tr>"
	i = 0
	while i < list_of_methods.length
		current_method = list_of_methods[i]
		content += "<tr class='success'><td>" + current_method + "</td></tr>"
		i++
	content += "</table>"
	if list_of_methods.length > 0
		div.innerHTML = content
	else
		div.innerHTML = ""
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

# [Solve Contest Problem - Story 5.20]
# Sends the contest submission results to the contests controllers
# Parameters:
#	status: Whether accepted or not
#	contest_id: The contest id
#	problem_id: The id of the problem being solved
# Returns: none
# Author: Ahmed Akram
@contest_problem_submission = (status, contest_id, problem_id) ->
	$.ajax
		type: "POST"
		url: '/cproblems/submit'
		data: {cproblem_id: problem_id, contest_id: contest_id, status: status}
		datatype: 'json'
		success: (data) ->
			return
	return

# [Compiler: Validate - Story X.7]
# submits a solution in the form without refreshing
# 	using ajax showing an alert box for success and failure scenarios
# Parameters:
#	problem_id: the id of the problem being solved
#	problem_type: The type of the problem to be submitted
# Returns: a json object containing two arrays one for the errors
#	of the current code and the other containing success messages
#	in addition to the status of the submitted solution
#	and the success and failure messages are displayed in a table
#	in case of Exercises, else a brief message is displayed
# Author: MOHAMEDSAEED
@validate_code = (problem_id, problem_type) ->
	code = get_editor_session().getValue()
	mins = parseInt($('#mins').text())
	secs = parseInt($('#secs').text())
	time = (mins * 60) + secs
	if code.length is 0
		alert 'Blank submissions are not allowed'
		return
	class_name = $("#class_name").val()
	lang = get_lang()
	toggle_code_area()
	start_spin()	
	$.ajax
		type: "POST"
		url: '/solutions'
		data: {problem_id: problem_id, code: code, time: time,\
			class_name: class_name, problem_type: problem_type, lang: lang}
		datatype: 'json'
		success: (data) ->
			clear_console()
			stop_spin()
			toggle_code_area()
			if data['compiler_error']
				compilation_error(data['compiler_output'])
				if problem_type == "Cproblem" 
					contest_id = document.getElementById('contest_id').innerHTML
					contest_problem_submission(0, contest_id, problem_id)
				return
			out = $('#validate_case')
			out.html("")
			content = ""
			content = '<table class="table table-striped table-bordered
				table-condensed table-hover" border="3">'
			content += "<tr class='info'><th>TestCase</th><th>Status</th></tr>"
			if problem_type == "Cproblem"
				i = data[data.length-1]['status']
				if i == 2 
					content = "<font color ='red'>Compilation failed</font>"
				else if i == 4
					content = "<font color ='red'>Testcases have Runtime Errors</font>"
				else if i == 5
					content = "<font color ='red'>Testcases have Logic Errors</font>"
				else 
					content = "<font color ='green'>Passed all testcases</font>"
				out.html(content)
				contest_id = document.getElementById('contest_id').innerHTML
				contest_problem_submission(i, contest_id, problem_id)
			else if problem_type == "AssignmentProblem" 
				content = "<font color ='green'>Solution has been submitted succefully</font>"
				out.html(content)
				return
			for i in data
				if !i['last'] && i['success']
					content += "<tr><td>" + "<font color ='green'>#{i['test_case']}</font>" +
						"</td>"
					content += "<td>" + "<font color ='green'>#{i['response']}</font>" +
						"</td></tr>"
				else if !i['last'] && !i['success']
					content += "<tr><td>" + "<font color ='red'>#{i['test_case']}</font>" +
						"</td>"
					content += "<td>" + "<font color ='red'>#{i['response']}</font>"+
						"</td></tr>"
			out.html(content)
			return
		error: (data) ->
			clear_console()
			stop_spin()
			toggle_code_area()
			return
	return

# [Code Editor: Write Code - Story 3.3]
# reloads the template that is displayed inside the editor
# Parameters: none
# Returns: none
# Author: MOHAMEDSAEED + Rami Khalil
@reload_template = () ->
	disabled = get_editor().getReadOnly()
	unless disabled
		if get_lang() == "java"
			template = $('#problem_default_code').val()
		else
			template = ""
		get_editor_session().setValue(template);
		$('#class_name').val("CoolSoft");
	return

# [Debug: Debug Python - Story X.8]
# Gets the editor
# Parameters: none
# Returns:
# 	The editor
# Author: Mussab ElDash
get_editor = ->
	ace.edit("editor")

# [Debug: Debug Python - Story X.8]
# Gets the session of the editor
# Parameters: none
# Returns:
# 	The session of the editor
# Author: Mussab ElDash
get_editor_session = ->
	get_editor().getSession()

# [Debug: Debug Python - Story X.8]
# Gets the language selected
# Parameters: none
# Returns:
# 	The selected Language
# Author: Mussab ElDash
get_lang = ->
	mode = get_editor_session().getMode()["$id"]
	mode.substring(mode.lastIndexOf("/") + 1)
