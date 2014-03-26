# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# called from a bootstrap dropdown, this closes the dropdown
$('a[data-toggle=modal]').on 'click', ->
  $('.dropdown').removeClass('open')
# this sets up the ajax loader, and it will stay until the method specific js removes it
$('a[data-target=#ajax-modal]').on 'click', ->
   e.preventDefault()
   e.stopPropagation();
   $('body').modalmanager('loading');
   $.rails.handleRemote( $(this) );
#removes whatever is in the modal body content div upon clicking close/outside modal
$(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
  $('.modal-body-content').empty()
$(document).on 'click', '#ajax-modal', (e) ->
  e.stopPropagation();