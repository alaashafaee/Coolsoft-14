// [Editor cusomization - Story 3.19]
// Description: 
//	Enable method "selectpicker" from the javascript file.
// Parameters: 
//	None.
// Returns:
//	None.
// Author: Mimi
$(document).ready(function(e){
	$('.selectpicker').selectpicker();
});

// [Editor cusomization - Story 3.19]
// Description: 
//	change the theme of the editor.
// Parameters: 
//	The selected input from the 'theme' drop-downlist.
// Returns:
//	None.
// Author: Mimi
function changeTheme(){
	var new_theme = $('#theme').val();
	editor.setTheme("ace/theme/"+new_theme);
}

// [Editor cusomization - Story 3.19]
// Description: 
//	change the mode of the editor.
// Parameters: 
//	The selected input from the 'mode' drop-downlist.
// Returns:
//	None.
// Author: Mimi
function changeMode(){
	var new_mode = $('#mode').val();
	edit_session.setMode("ace/mode/"+new_mode);
}

// [Editor cusomization - Story 3.19]
// Description: 
//	change the font-size of the editor.
// Parameters: 
//	The selected input from the 'font' drop-downlist.
// Returns:
//	None.
// Author: Mimi
function changeFont(){
	var new_font = $('#font').val();
	editor.setFontSize(parseInt(new_font));
}