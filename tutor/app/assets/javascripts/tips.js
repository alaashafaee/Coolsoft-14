//[View hints and tips-story 4.22]
//Toggle to view previous tips
//Parameters:
//	id: Element that will be toggled.
//Returns: none.
//Author: Nadine Adel
function toggle_visibility(id) {
	var element = document.getElementById(id);
	if(element.style.display == 'block')
		element.style.display = 'none';
	else
		element.style.display = 'block';
}