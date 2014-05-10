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
		var newTheme = $('#theme').val();
		editor.setTheme("ace/theme/"+newTheme);
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
		var newMode = $('#mode').val();
		edit_session.setMode("ace/mode/"+newMode);
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
		var newFont = $('#font').val();
		editor.setFontSize(parseInt(newFont));
}