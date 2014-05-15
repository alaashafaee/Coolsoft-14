jQuery(document).on("ready page:load", function() {
	$(function () {
		var name = $('#temp').data('name')
		var date = contest.start_time
		var start = new Date(date);
		$('#countdown').countdown({until: start, onTick: highlightLast10});
		function highlightLast10(periods) { 
			if ($.countdown.periodsToSeconds(periods) === 10) { 
				$(this).addClass('highlight'); 
			} 
		}
	});
});