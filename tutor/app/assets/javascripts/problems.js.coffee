# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

digit = 0
min = 0
time = 0
timer_is_on = 0

# [Give Hints - Story 3.6, Problem Timer - Story 3.10]
# Counts up the time spent so far on the problem since the page opened
# 	and displays hints accordingly
# Parameters:
# 	none
# Returns: none
# Author: Mohamed Fadel + Rami Khalil
timer = ->
	digit++
	if digit > 59
		min++
		document.getElementById("mins").innerHTML = min
		digit = 0
	if digit <= 9
		digit = "0" + digit  
	document.getElementById("secs").innerHTML = digit
	i = 0
	while true
		hint = $('#hint' + i)
		if typeof(hint.attr 'time') == 'undefined'
			break
		time = hint.attr 'time'
		if time <= min*60 + parseInt(digit, 10)
			hint.attr 'class', ''
		i++

activate = ->
	unless timer_is_on
		timer_is_on = 1
		time = setInterval(timer, 1000)
		timer

jQuery ->
	activate()
	return
