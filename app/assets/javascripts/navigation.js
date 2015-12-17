/**
 * Navigation helpers
 */
;(function(exports) {
    
    function scrollTo(selector) {
        $('html, body').animate({
            scrollTop: $(selector).offset().top - 40
        }, 500);
    }
    
    exports.scrollTo = scrollTo;

})(window);