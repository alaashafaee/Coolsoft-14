jQuery(document).on("ready page:load", function() {
	/*
	[Contest Timer - Story 5.28]
	Sets the behaviour of the timer once the page loads based on the received contest time.
		If it received that the contest has ended, the timer will disappear. Else, it would
		set the timer to the countdown of the given time. It uses the function 'highlightLast10'
		to change the color of the timer to the red color in the last 10 seconds. It uses the
		the function 'reload' to reload the page and thus contacting the server to know the behaviour
		of the timer once the contest ends.
	Parameters: none
	Returns: none
	Author: Khaled Helmy
	*/
	$(function () {
		if (!element_exists('temp'))
			return
		var timer = $('#temp').data('timer')
		timer = timer.substring(1, timer.length-1)
		var destroy = $('#temp').data('del')
		var count = new Date(timer);
		$('#countdown').countdown(destroy ? 'destroy' : {until: count, onTick: highlightLast10,
			onExpiry: reload});
		/*
		[Contest Timer - Story 5.28]
		Attaches the class 'highlight' which changes the color of the timer if the number of
			seconds left till the end of the timer is less than or equal to 10 seconds.
		Parameters:
			periods: time left in seconds for the timer to end.
		Returns: none
		Author: Khaled Helmy
		*/
		function highlightLast10(periods) { 
			if ($.countdown.periodsToSeconds(periods) <= 10) { 
				$(this).addClass('highlight'); 
			}
		}
		/*
		[Contest Timer - Story 5.28]
		Reloads the page once it is called.
		Parameters: none
		Returns: none
		Author: Khaled Helmy
		*/
		function reload() {
			location.reload(true)
		}
	});
});