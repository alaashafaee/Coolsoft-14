root = exports ? this

root.toggleDebug = () ->
	$('#debugButton').prop 'hidden', !$('#debugButton').prop 'hidden'
	$('#compileButton').prop 'hidden', !$('#compileButton').prop 'hidden'
	$('#testButton').prop 'hidden', !$('#testButton').prop 'hidden'

	$('#nextButton').prop 'hidden', !$('#nextButton').prop 'hidden'
	$('#previousButton').prop 'hidden', !$('#previousButton').prop 'hidden'
	$('#stopButton').prop 'hidden', !$('#stopButton').prop 'hidden'

root.compile = () ->
	alert "Compiling'"

root.test = () ->
	alert "Testing"

root.debug = () ->
	toggleDebug()

root.next = () ->
	alert "Next Step"

root.previous = () ->
	alert "Previous Step"

root.stop = () ->
	toggleDebug()
