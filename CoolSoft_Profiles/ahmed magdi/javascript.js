jQuery(function($){
	$('.faders').css({opacity: 0.5}).hover(function(){
		$(this).stop().animate({opacity: 1});
	}, function(){
		$(this).stop().animate({opacity: 0.5});
	});

});