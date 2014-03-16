jQuery(function($){
	$('#my-img').hover(function(){
		$('#social_buttons').fadeOut(100);
		$('#hover').fadeOut(100);
		if ( $( this ).height() < 400){
			$(this).animate({
		        marginLeft: "-=205" , marginTop: "-=100" , height: "500px" , borderRadius: "0%"}, 2000, function() {
		        	$('#header').slideDown(100);
		        	$('#my-info').css({marginTop: "-15"}).slideDown(300);
		        }
			);
		}
	}
	,function(){
		$(this).close();
		}); 
});