//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var type = new Array();
var param_name = new Array();
var var_type = new Array();
var var_name = new Array();

//# [Add Solutions' constraints - Story 4.14]
//# Description: Adds the parameters from the text_fields to array
//# Parameters: none
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function add_params(field) {
	var tmp_type = document.getElementById("params_type").value;
	var tmp_name = document.getElementById("params_name").value;
	if (tmp_name != "" && tmp_type != "") {
		document.getElementById("params_type").style.border= "";
		document.getElementById("params_name").style.border= "";
		type[type.length] = tmp_type;
		document.getElementById("params_type").value = "";
		param_name[param_name.length] = tmp_name;
		document.getElementById("params_name").value = "";
		document.getElementById("parameter").innerHTML = "<h3>Paramters Constraints</h3><table>";
		for (var i = 0; i < type.length; i++) {
			$('#parameter').append("<tr>");
			$('#parameter').append("<td width = \"10px\"></td>");
			$('#parameter').append("<td><label>"+type[i]+"</label></td>");
			$('#parameter').append("<td width = \"10px\"></td>");
			$('#parameter').append("<td><label>"+param_name[i]+"</label></td>");
			$('#parameter').append("<td width = \"20px\"></td>");
			$('#parameter').append("<td><img alt=\"delete buttom\" id=\"params_"+i+"\" \
				onclick=\"remove_params(this);\" src=\"/assets/delete_button.png\" \
				style=\"width:8%;height:8%;margin_top:10px;;cursor:pointer\"></td>");
			$('#parameter').append("</tr>");
		}
		$('#parameter').append("</table>");
	}
	else {
		if (tmp_name == "" && tmp_type == "") {
			document.getElementById("params_type").style.border= "red 1px solid";
			document.getElementById("params_name").style.border= "red 1px solid";
		}
		else if(tmp_name == "") {
			document.getElementById("params_type").style.border= "";
			document.getElementById("params_name").style.border= "red 1px solid";
		}
		else{
			document.getElementById("params_type").style.border= "red 1px solid";
			document.getElementById("params_name").style.border= "";
		}
	}
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: removes selected variable from method Contraints
//# Parameters: none
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function remove_params(field) {
	var index = field.id.split("_")[1];
	type.splice(index,1);
	param_name.splice(index,1);
	document.getElementById("parameter").innerHTML = "<h3>Paramters Constraints</h3><table>";
	if(type.length == 0) {
		$('#parameter').append("No paramter");
	}
	for (var i = 0; i < type.length; i++) {
		$('#parameter').append("<tr>");
		$('#parameter').append("<td width = \"10px\"></td>");
		$('#parameter').append("<td><label>"+type[i]+"</label></td>");
		$('#parameter').append("<td width = \"10px\"></td>");
		$('#parameter').append("<td><label>"+param_name[i]+"</label></td>");
		$('#parameter').append("<td width = \"20px\"></td>");
		$('#parameter').append("<td><img alt=\"delete buttom\" id=\"params_"+i+"\" \
			onclick=\"remove_params(this);\" src=\"/assets/delete_button.png\" \
			style=\"width:8%;height:8%;margin_top:10px;;cursor:pointer\"></td>");
		$('#parameter').append("</tr>");
	}
	$('#parameter').append("</table>");
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: Adds the parameters from the text_fields to array
//# Parameters: none
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function add_variable(field) {
	var tmp_type = document.getElementById("variable_type").value;
	var tmp_name = document.getElementById("variable_name").value;
	if (tmp_name != "" && tmp_type != "") {
		document.getElementById("variable_type").style.border= "";
		document.getElementById("variable_name").style.border= "";
		var_type[var_type.length] = tmp_type;
		document.getElementById("variable_type").value = "";
		var_name[var_name.length] = tmp_name;
		document.getElementById("variable_name").value = "";
		document.getElementById("variable").innerHTML = "<h3>Variables Constraints</h3><table>";
		for (var i = 0; i < var_type.length; i++) {
			$('#variable').append("<tr>");
			$('#variable').append("<td width = \"10px\"></td>");
			$('#variable').append("<td><label>"+var_type[i]+"</label></td>");
			$('#variable').append("<td width = \"10px\"></td>");
			$('#variable').append("<td><label>"+var_name[i]+"</label></td>");
			$('#variable').append("<td width = \"20px\"></td>");
			$('#variable').append("<td><img alt=\"delete buttom\" id=\"params_"+i+"\" \
				onclick=\"remove_variable(this);\" src=\"/assets/delete_button.png\" \
				style=\"width:8%;height:8%;margin_top:10px;;cursor:pointer\"></td>");
			$('#variable').append("</tr>");
		}
		$('#variable').append("</table>");
	}
	else {
		if (tmp_name == "" && tmp_type == "") {
			document.getElementById("variable_type").style.border= "red 1px solid";
			document.getElementById("variable_name").style.border= "red 1px solid";
		}
		else if(tmp_name == "") {
			document.getElementById("variable_type").style.border= "";
			document.getElementById("variable_name").style.border= "red 1px solid";
		}
		else {
			document.getElementById("variable_type").style.border= "red 1px solid";
			document.getElementById("variable_name").style.border= "";
		}
	}
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: removes selected variable from Variable Contraints
//# Parameters: none
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function remove_variable(field) {
	var index = field.id.split("_")[1];
	var_type.splice(index,1);
	var_name.splice(index,1);
	document.getElementById("variable").innerHTML = "<h3>Variables Constraints</h3><table>";
	if(var_type.length == 0) {
		$('#variable').append("No Variables");
	}
	for (var i = 0; i < var_type.length; i++) {
		$('#variable').append("<tr>");
		$('#variable').append("<td width = \"10px\"></td>");
		$('#variable').append("<td><label>"+var_type[i]+"</label></td>");
		$('#variable').append("<td width = \"10px\"></td>");
		$('#variable').append("<td><label>"+var_name[i]+"</label></td>");
		$('#variable').append("<td width = \"20px\"></td>");
		$('#variable').append("<td><img alt=\"delete buttom\" id=\"params_"+i+"\" \
			onclick=\"remove_params(this);\" src=\"/assets/delete_button.png\" \
			style=\"width:8%;height:8%;margin_top:10px;;cursor:pointer\"></td>");
		$('#variable').append("</tr>");
	}
	$('#variable').append("</table>");
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: for showing the error massages for the user
//# Parameters: 
//# 	errorArray: array of Errors,for multi error massage show
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function showErrorMessage(arrayOfErrors) {
	for (var i = 0; i < arrayOfErrors.length; i++) {
		$("#errors").append("<div class=\"alert alert-danger\">"+arrayOfErrors[i]+"</div>");
	};
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: Validates Data before sending it to the Server side
//# Parameters: 
//# 	method_cons: Hash containting the Method parameters
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function testingValidation(errorArray,method,name) {
	if (type.length == 0 &&
		var_type.length == 0 &&
		method == 0 &&
		name == 0) {
		errorArray.push("Can not submit an empty Data,\
			Try filling either Method Constraint for Variable Constraint");
		return false;
	};
	if (type.length > 0) {
		if (method == "" && name == "") {
			document.getElementById("_constrain_method_return").style.border= "red 1px solid";
			document.getElementById("_constrain_method_name").style.border= "red 1px solid";
			errorArray.push("Enter method name and return type ..");
		}
	};
	if(method == "" && name != "") {
		document.getElementById("_constrain_method_name").style.border= "";
		document.getElementById("_constrain_method_return").style.border= "red 1px solid";
		errorArray.push("Enter method return type ..");
	}
	else if(name == "" && method != "") {
		document.getElementById("_constrain_method_name").style.border= "red 1px solid";
		document.getElementById("_constrain_method_return").style.border= "";
		errorArray.push("Enter method name ..");
	}
	return errorArray.length == 0;
}

//# [Add Solutions' constraints - Story 4.14]
//# Description: submits via ajax to the controller
//# Parameters: none
//# Returns: none
//# Author: Ahmed Mohamed Magdi
function submitParams() {
	$("#errors").html("");
	errorArray = new Array();
	var hash_p = new Array();
	var hash_v = new Array();
	method = $('#_constrain_method_return').val()
	name = $('#_constrain_method_name').val()
	if (!testingValidation(errorArray,method,name)) {
		showErrorMessage(errorArray);
		return;
	};
	for (var i = 0; i < type.length; i++) {
		hash_p.push({
			type: type[i] ,
			name: param_name[i]
		});
	};
	for (var i = 0; i < type.length; i++) {
		hash_v.push({
			type: var_type[i] ,
			name: var_name[i]
		});
	};
	$.ajax({
		type: "POST",
		url: "/solutions_constraints",
		data:{
			parameter_constraint: hash_p,
			variable_constraint: hash_v,
			method_return: method,
			method_name: name
		},
		success: function(data) {
			if (data) {
				alert("Data have been Added successfully");
				window.location = window.location
			}
			else {
				alert("Data messigin/incorrect !");
			}
		},
		datatype: "JSON",
		error: function() {
			alert("Failed to Add Constraints, Check again");
		}
	});
}