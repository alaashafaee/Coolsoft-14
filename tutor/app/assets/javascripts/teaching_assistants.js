$(document).ready(function() {
	$('.tabs .tab-links a').on('click', function(e) {
		var currentAttrValue = $(this).attr('href');
		// Show/Hide Tabs
		$('.tabs ' + currentAttrValue).siblings().slideUp(400);
		$('.tabs ' + currentAttrValue).delay(400).slideDown(400);
		//or use fade
		//$('.tabs ' + currentAttrValue).fadeIn(400).siblings().hide();
		// Change/remove current tab to active
		$(this).parent('li').addClass('active').siblings().removeClass('active');
		e.preventDefault();
	});
});