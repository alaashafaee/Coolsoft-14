// Semicolon (;) to ensure closing of earlier scripting
// Encapsulation
// $ is assigned to jQuery

function showdialog(id){

	$.ajax({ 
		type: "GET",
		url: '/tracks/recommend_problem/' + id,
		datatype: 'json',
		success: fill
	});
}

function fill(data){
	elem = $('#container');
	elem.html("");
	if(Object.keys(data).length == 0){
		elem.html("<div align='center'>Empty</div>");
		$('.classmates_list').bPopup();
		return;
	}
	elem.html("<ul>");
	$.each(data, function (i , datum){
		datum = data[i];
		temp = "<li>" + datum + " " + i + "</li>"
		elem.append(temp);
	});
	elem.append("</ul>");
	$('.classmates_list').bPopup();	
}
// ;
// (function ($) {
//     // DOM Ready
//     $(function () {
//         // Binding a click event
//         // From jQuery v.1.7.0 use .on() instead of .bind()
//         $('.recommend').bind('click', function (e) {
//             e.preventDefault();

//             $('.classmates_list').bPopup();
//         });
//     });
// })(jQuery);
