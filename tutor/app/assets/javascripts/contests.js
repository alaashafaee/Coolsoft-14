jQuery(document).on("ready page:load", function() {
  $(function () {
    $('#countdown').countdown({until: '+2d'});
  });
});