jQuery(document).on("ready page:load", function() {
	$(function () {
		var current = new Date();
		current.setSeconds(current.getSeconds()+15);
		$('#countdown').countdown({until: current, onTick: highlightLast10});
		function highlightLast10(periods) { 
			if ($.countdown.periodsToSeconds(periods) === 10) { 
				$(this).addClass('highlight'); 
			} 
		}
	});
});