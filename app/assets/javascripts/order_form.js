/**
 * Order form helpers
 */
;(function(exports) {
    
    function registerEvents() {
        $('#qty').change(function() {
            var qty = $(this).val();
            var price = parseFloat($('#price').attr('price'));
            var total = qty * price;
            $('#summary-qty').text(qty);
            $('#total').text('$' + total.toFixed(2));
        });
    }
   
   exports.orders = {};
   exports.orders.registerEvents = registerEvents;
   
})(window);