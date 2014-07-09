//= require_tree

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

digit = 0
min = 0
time = 0
timer_is_on = 0

# [Give Hints - Story 3.6, Problem Timer - Story 3.10, Consistent Timer - Story 3.13]
# Counts up the time spent so far on the problem since the page opened
# 	and displays hints accordingly
# Parameters: none
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
		tip = $('#tip' + i)
		if typeof(tip.attr 'time') == 'undefined'
			break
		if typeof(tip.attr 'shown') == 'undefined'
			time = tip.attr 'time'
			if time <= min*60 + parseInt(digit, 10)
				tip.attr 'class', ''
				the_tip = 'Tip: ' + tip.html()
				tip.attr 'shown', ''
				log = alert the_tip, 'log', 0
		i++
	return

activate = ->
	unless timer_is_on
		timer_is_on = 1
		time = setInterval(timer, 1000)
		timer

# [Design - Story Design]
# Start counter if the two labels with ids "mins" and "secs" exists
# Parameters: none
# Returns: none
# Author: Mussab ElDash
jQuery ->
	if element_exists("mins") and element_exists("secs")
		activate()
	return
