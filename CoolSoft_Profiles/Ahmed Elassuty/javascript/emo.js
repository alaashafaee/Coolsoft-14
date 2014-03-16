jQuery(function($){
	$('.fadeIcons').css({opacity: 0.7}).hover(function(){
		$(this).animate({opacity: 1});
	},function(){
		$(this).animate({opacity: 0.7});
		});
	});