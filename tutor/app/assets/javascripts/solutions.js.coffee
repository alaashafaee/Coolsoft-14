#Makes declared functions directly callable from DOM
root = exports ? this

# [Execute Line By Line - Story 3.8]
# Toggles debugging mode by changing the available buttons.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
root.toggleDebug = () ->
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
root.compile = () ->
	alert "Compiling"

# [Test - Story 3.15]
# Sends the code and the input to be processed on the server.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
root.test = () ->
	alert "Testing"

# [Debug - Story 3.6]
# Moves to the next line of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
root.debug = () ->
	toggleDebug()

# [Execute Line By Line - Story 3.8]
# Moves to the next state of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil
root.next = () ->
	alert "Next Step"

# [Execute Line By Line - Story 3.8]
# Moves to the previous state of execution.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil
root.previous = () ->
	alert "Previous Step"

# [Debug - Story 3.6]
# Stops the debugging session.
# Parameters:
#	none
# Returns: none
# Author: Rami Khalil (Temporary)
root.stop = () ->
	toggleDebug()
