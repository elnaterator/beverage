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
    
    var nav = {
        smoothScroll: smoothScroll
    };
    exports.nav = nav;

})(window);