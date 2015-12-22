/**
 * Navigation helpers
 */
;(function(exports) {
    
    function smoothScroll(selector) {
        var offset = $(selector).offset().top
        $('html, body').animate({
            scrollTop: offset - 40
        }, 500);
    }

    exports.nav = {};
    exports.nav.smoothScroll = smoothScroll;

})(window);