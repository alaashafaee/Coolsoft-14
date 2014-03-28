# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
    alert('working!');
    $('#toggleButton').click(function() {
        if ($('#experiment').is(':visible')) {
            $('#experiment').hide();
        } else {
            $('#experiment').show();
        }
    })
});