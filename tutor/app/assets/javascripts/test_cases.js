//[Edit test case-story 4.9]
//Toggle to view previous test cases
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