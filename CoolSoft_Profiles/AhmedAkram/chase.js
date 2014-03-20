jQuery(function($) {
    $('.about').mouseover(function() {
        var dWidth = $(document).width() - 100, // 100 = image width
            dHeight = $(document).height() - 100, // 100 = image height
            nextX = Math.floor(Math.random()*100),
            nextY = Math.floor(Math.random()*100);
        $(this).animate({ left: nextX + 'px', top: nextY + 'px' });
    });
});


function goCrazy() {
	var r=confirm("Are You Sure ?!");
	if (r == true){
  		makeDiv();
  	}
}

function makeDiv(){
    var divsize = ((Math.random()*100) + 50).toFixed();
    var color = '#'+ Math.round(0xffffff * Math.random()).toString(16);
    $newdiv = $('<div/>').css({
        'width':divsize+'px',
        'height':divsize+'px',
        'background-color': color,
        'border-radius':+divsize/2+'px'
    });
    
    var posx = (Math.random() * ($(document).width() - divsize)).toFixed();
    var posy = (Math.random() * ($(document).height() - divsize)).toFixed();
    
    $newdiv.css({
        'position':'absolute',
        'left':posx+'px',
        'top':posy+'px',
        'display':'none'
    }).appendTo( 'body' ).fadeIn(10, function(){
       makeDiv(); 
    }); 
}
