jQuery(document).on("ready page:load", function() {
	$(function () {
		var timer = $('#temp').data('timer')
		var destroy = $('#temp').data('del')
		var count = new Date(timer);
		$('#countdown').countdown(destroy ? 'destroy' : {until: count, onTick: highlightLast10});
		function highlightLast10(periods) { 
			if ($.countdown.periodsToSeconds(periods) === 10) { 
				$(this).addClass('highlight'); 
			} 
		}
	});
});