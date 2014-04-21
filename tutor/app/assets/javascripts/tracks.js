// Semicolon (;) to ensure closing of earlier scripting
// Encapsulation
// $ is assigned to jQuery
;
(function ($) {
    // DOM Ready
    $(function () {
        // Binding a click event
        // From jQuery v.1.7.0 use .on() instead of .bind()
        $('#my-button1').bind('click', function (e) {
            e.preventDefault();
            $('#element_to_pop_up').bPopup();
        });
    });
})(jQuery);
