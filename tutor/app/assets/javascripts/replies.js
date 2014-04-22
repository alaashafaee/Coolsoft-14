// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


function post(id){
	input= $("#input_field").val();
	// postId = window.location.search.substring(4);
	postId = id;
	$.ajax({
		type:"GET",
		url:'/replies/new',
		data : {
			reply: input,
			post_id: postId
		},
		datatype : 'json'
	});
}

function append(data){
	container = $('#text_holder');
	container.html("");
	input = $("#input_field").val();
	if(!Object.keys(data).length == 0){
		$.each(data, function(i){
			link_edit = ""
			line = "<p>" + input + "</p>";
			container.append(line);
		});
	}
}

