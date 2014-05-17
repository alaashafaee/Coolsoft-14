/* Place all the behaviors and hooks related to the matching controller here.
 * All this logic will automatically be available in application.js.
 * You can use CoffeeScript in this file: http://coffeescript.org/
 */

function edit_form_course(data) {
	$("#course-name").html("<input type=\"text\" name=\"coursename\" id=\"coursename\" value=\""+data.name+"\" placeholder=\"name\">")
	$("#course-code").html("<input type=\"text\" name=\"coursecode\" id=\"coursecode\" value=\""+data.code+"\" placeholder=\"code\">")
	$("#course-link").html("<input type=\"text\" name=\"courselink\" id=\"courselink\" value=\""+data.link+"\" placeholder=\"code\">")
	$("#course-description").html("<textarea type=\"text\" name=\"coursedesc\" id=\"coursedesc\" placeholder=\"description\">"+data.description+"</textarea>")
	$("#course-semester").html("<input type=\"text\" name=\"coursesmester\" id=\"coursesemester\" value=\""+data.semester+"\" placeholder=\"semester\">")
	$("#course-year").html("<input type=\"text\" name=\"courseyear\" id=\"courseyear\" value=\""+data.year+"\" placeholder=\"year\">")
	$("#course-submition").html("<button class=\"btn btn-success submit-course\" type=\"button\" onclick=\"update_course();\">Save</button>")
}

function reset_form_course(course_up) {
	form_print_html("course-name", course_up.name);
	form_print_html("course-code", course_up.code);
	form_print_html("course-link", course_up.link);
	form_print_html("course-description", course_up.description);
	form_print_html("course-semester", course_up.semester);
	form_print_html("course-year", course_up.year);
	$("#course-submition").html("")
}
function form_print_html(div_id,info) {
	$("#"+div_id).html("<p><font> "+info+" </font></p>")
}

var course;
function edit_course(course_id) {
	course = course_id;
	$.ajax({
		type: "GET",
		url: "/courses/find_course/"+course_id,
		data:{
			id: course_id
		},
		success: function(data) {
			edit_form_course(data);
		},
		error: function() {
			alert("Unable to connect to server");
		}
	});
}

function update_course() {
	Cname = $("#coursename").val();
	Ccode = $("#coursecode").val();
	Clink = $("#courselink").val();
	Csemester = $("#coursesemester").val();
	Cyear = $("#courseyear").val();
	Cdesc = $("#coursedesc").val();
	course_up = {
				name:Cname,
				code: Ccode,
				link: Clink,
				semester: Csemester,
				year: Cyear,
				desc: Cdesc 
			}
	$.ajax({
		type: "PATCH",
		url: "/courses/"+course,
		data:{
			id: course,
			course: course_up
		},
		success: function(data) {
			reset_form_course(data);
			alert("Changes success")
		},
		error: function() {
			alert("Wrong Inputs");
		}
	});
}

