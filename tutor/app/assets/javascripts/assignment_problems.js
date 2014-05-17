// [Create Assignment - Story 4.27]
// used for checkboxes to be able to select many problems.
// Parameters: none
// Returns: none 
// Author: Nadine Adel
('input[type="checkbox"]').checkbox({
	buttonStyle: 'btn-link',
	buttonStyleChecked: 'btn-inverse',
	checkedClass: 'icon-check',
	uncheckedClass: 'icon-check-empty',
	constructorCallback: null,
	defaultState: false,
	defaultEnabled: true,
	checked: false,
	enabled: true
});
