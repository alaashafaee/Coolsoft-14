// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function post(){
	input= $("#input_field").val();
	postId = window.location.search.substring(1);
	$.ajax({
		type:"GET",
		url:'/replies/create',
		data : {
			reply: input,
			post_id: postId
		},
		datatype : 'json',
		success : append()
	});
}

function append(data){
	container = $('#text_holder');
	container.html("");
	input = $("#input_field").val();
	if(!Object.keys(data).length == 0){
		$.each(data, function(i){
			line = "<p>" + input + "</p>";
			container.append(line);
		});
	}
}

