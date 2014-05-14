jQuery(document).on("ready page:load", function() {
	$(function () {
		var newYear = new Date();
		newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1);
		$('#countdown').countdown({until: newYear});
	});
});