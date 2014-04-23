// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// # Description: Ajax for createing a record in the database
// # Parameters:
// #	id : id of the current Post
// # Returns: JSON Request
// # Author: Ahmed Mohamed Magdi
function post(id){
	input= $("#input_field").val();
	// postId = window.location.search.substring(4);
	postId = id;
	$.ajax({
		type:"POST",
		url:'/replies',
		data : {
			reply: input,
			post_id: postId
		},
		datatype : 'json'
	});
}

// # Description: 
// # Parameters:
// # Returns: none
// # Author: Ahmed Mohamed Magdi
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

