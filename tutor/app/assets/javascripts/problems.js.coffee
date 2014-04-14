# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

digit = 0
min = 0
time = 0
timer_is_on = 0

timer = ->
	digit++
	if digit > 59
		min++
		document.getElementById("mins").innerHTML = min
		digit = 0
	if digit <= 9
		digit = "0" + digit  
	document.getElementById("secs").innerHTML = digit

activate = ->
	unless timer_is_on
		timer_is_on = 1
		time = setInterval(timer, 1000)
		timer

jQuery ->
	activate()
	return
