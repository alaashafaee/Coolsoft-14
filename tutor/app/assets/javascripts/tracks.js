// # [Recommendation to students]
// # Author: Mohab Ghanim

function showdialog(problem_id, recommender_id){
	$.ajax({ 
		type: "GET",
		url: '/tracks/show_classmates/' + problem_id,
		datatype: 'json',
		success: function(json){
			fill(json, problem_id, recommender_id)}
	});
}

function fill(data, problem_id, recommender_id){
	elem = $('#container');
	elem.html("");
	if(Object.keys(data).length == 0){
		elem.html("<div align='center'>No classmates to recommend this problem to</div>");
		$('.classmates_list').bPopup();
		return;
	}
	elem.html("<h2> Recommend this problem to </h2>")
	elem.append("<ul class ='list-group'>");
	$.each(data, function (i , datum){
		datum = data[i];
		temp = "<li class='list-group-item'>" + datum['student_name'] +
					"<button type='button' class='recommend btn btn-xs'"+
					"onclick='recommend(" + problem_id + "," + recommender_id + "," + i + ")'";
						if (datum['recommended_before'] == 'true' ){
							temp += "disabled";
							temp += ">recommended before"
						}else {
							temp += ">recommend";
						} 
					temp += "</button>" + 
				"</li>"
		elem.append(temp);
	});
	elem.append("</ul>");
	$('.classmates_list').bPopup();	
}

function recommend(problem_id, recommender_id, student_id){

	$.ajax({
		type: "POST",
		url: '/tracks/insert_recommendation/',
		data: {	p_id : problem_id,
				r_id : recommender_id,
				s_id : student_id
			}
	});
	showdialog(problem_id, recommender_id);

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
