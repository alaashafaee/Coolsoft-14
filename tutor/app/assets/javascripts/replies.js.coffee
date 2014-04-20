# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# // $(function() {
# // 	$("submit_reply").live("click", function(){
# // 		alart("dadasdas");
# // 		return false;
# // 	});
# // });

$(document).ready ->
  $("#new_reply").on("ajax:success", (e, data, status, xhr) ->
    $("#new_post").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_post").append "<p>ERROR</p>"

$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "The post was deleted."