// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// # [Post a Reply - Story 1.14]
// # It is used to post a reply to the Database
// # Parameters:
// #	id: id of the current Post
// # Returns: JSON Request
// # Author: Ahmed Mohamed Magdi
function post_reply(_id) {
	input = $("#input_field").val();
	$.ajax({
		error: function() {
			alert("Failed to add constraints, Check again");
		},
		type: "POST",
		url: "/replies",
		data: {
			content: input,
			id: _id
		},
		datatype: "JSON",
		success: function(data) {
			window.location = window.location
		}
	});
}

// # [Edit a Reply - Story 1.19]
// # For show the form for editing a reply
// # Parameters:
// #	reply_id: for getting the id of the reply
// #	data: the content of the reply
// # Returns: none
// # Author: Ahmed Mohamed Magdi
function edit_form_reply(reply_id,data) {
	$("#reply_content_"+reply_id).html("<table> <tr> \
		<td><textarea id=\"textarea_"+reply_id+"\" class=\"wysihtml5\" style=\" width:100% !important;\"placeholder=\"Enter text ...\">"+data+"</textarea> \
		</td><td width=\"20px\"></td><td><input class=\"btn btn-default btn-sm\" name=\"commit\" \
		onclick=\"update_reply("+reply_id+")\" type=\"submit\" value=\"Update\"></td></tr></table>");
}

// # [Edit a Reply - Story 1.19]
// # For updating reply in the database
// # Parameters:
// #	reply_id: for getting the id of the reply
// # Returns: 
// # 	JSON Request
// # Author: Ahmed Mohamed Magdi
function update_reply(reply_id) {
	input_data = $("#textarea_"+reply_id).val();
	$.ajax({
		type: "PATCH",
		url: "/replies/"+reply_id,
		data:{
			id: reply_id,
			content: input_data
		},
		success: function(data) {
			// window.location = window.location
			reform_updated_reply(data);
		},
		datatype: "JSON",
		error: function() {
			alert("Failed update the reply, Check again");
		}
	});
}

function reform_updated_reply(data) {
	$("#reply_content_"+data.id).html("<h2>"+data.content+"</h2>");
}

// # [Edit a Reply - Story 1.19]
// # For getting the content of a reply
// # Parameters:
// #	reply_id: for getting the id of the reply
// #	post_id: for getting the id of the post
// # Returns:
// # 	JSON Request
// # Author: Ahmed Mohamed Magdi
function edit_reply(reply_id,post_id) {
	$.ajax({
		type: "GET",
		url: "/replies/"+reply_id,
		data:{
			id: reply_id
		},
		success: function(data) {
			// alert(data.content);
			edit_form_reply(reply_id,data.content);
		},
		datatype: "JSON",
		error: function() {
			alert("Failed editing rely, Check again");
		}
	});
}

// # [Delete a Reply - Story 1.16]
// # For deleting a reply from the database
// # Parameters:
// #	reply_id: for getting the id of the reply
// #	post_id: for getting the id of the post
// # Returns:
// # 	JSON Request
// # Author: Ahmed Mohamed Magdi
function delete_reply(reply_id,post_id) {
	$.ajax({
		type: "DELETE",
		url: "/replies/"+reply_id,
		data:{
			id: reply_id
		},
		success: function(data) {
			if (data) {
				$("#reply_"+reply_id).fadeOut(500, function() {
					$(this).remove();
				});
			}	
			else {
				alert("Server Issue 500");
			}
		},
		datatype: "JSON",
		error: function() {
			alert("Unable to connect to Server");
		}
	});
}
