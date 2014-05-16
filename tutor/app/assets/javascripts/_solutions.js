// [Editor cusomization - Story 3.19]
//	Enable method "selectpicker" from the javascript file.
// Parameters: none.
// Returns: none.
// Author: Mimi
$(document).ready(function(e){
	$('.selectpicker').selectpicker();
});

// [Editor cusomization - Story 3.19] 
//	change the theme of the editor.
// Parameters: 
//	The selected input from the 'theme' drop-downlist.
// Returns: none.
// Author: Mimi
function changeTheme(){
	var new_theme = $('#theme').val();
	editor.setTheme("ace/theme/"+new_theme);
}

// [Editor cusomization - Story 3.19]
//	change the mode of the editor.
// Parameters: 
//	The selected input from the 'mode' drop-downlist.
// Returns: none.
// Author: Mimi
function changeMode(){
	var new_mode = $('#mode').val();
	edit_session.setMode("ace/mode/"+new_mode);
}

// [Editor cusomization - Story 3.19]
//	change the font-size of the editor.
// Parameters: 
//	The selected input from the 'font' drop-downlist.
// Returns: none.
// Author: Mimi
function changeFont(){
	var new_font = $('#font').val();
	editor.setFontSize(parseInt(new_font));
}

function show(id){
	id += "add_button"
	document.getElementById(id).style.opacity = 1;
}
function hide(id){
	id += "add_button"
	document.getElementById(id).style.opacity = 0;
}
function pop(id){
	id += "form"
	document.getElementById(id).style.display = 'initial'
	$(document.getElementById(id)).bPopup({
		modalClose: false,
		opacity: 0.6,
		positionStyle: 'fixed',
		speed: 650,
		transition: 'slideIn'
	});
}