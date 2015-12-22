/**
 * Order form helpers
 */
;(function(exports) {
    
    function registerEvents() {
        $('#qty').change(updateQty);
        $('body').on('click','#submit-order',submitOrder);
        $('input').on('change',removeError);
        $('select').on('change',removeError);
    }
    
    function updateQty() {
        var qty = $('#qty').val();
        var price = parseFloat($('#price').attr('price'));
        var total = qty * price;
        $('#summary-qty').text(qty);
        $('#total').text('$' + total.toFixed(2));
    }
    
    function submitOrder() {
        $.ajax({
            type: "POST",
            url: "/orders",
            data: buildOrderPayload(),
            contentType: "application/json; charset=utf-8",
            dataType: 'JSON',
            success: orderSuccessHandler,
            error: orderFailureHandler,
        });
    }
    
    function buildOrderPayload() {
        var order = {};
        order.qty = $('#qty').val();
        order.first = $('#first-name').val();
        order.last = $('#last-name').val();
        order.city = $('#city').val();
        order.country = $('#country').val();
        order.cardholder = $('#cardholder').val();
        order.card = $('#card').val();
        order.expiry_month = $('#expiry-month').val();
        order.expiry_year = $('#expiry-year').val();
        order.cvv = $('#cvv').val();
        return JSON.stringify({order: order});
    }
    
    function orderSuccessHandler(data) {
        $('#success-alert').show();
        $('#error-alert').hide();
    }
    
    fldMap = {
        '#qty':'qty',
        '#first-name':'first',
        '#last-name':'last',
        '#city':'city',
        '#country':'country',
        '#cardholder': 'cardholder',
        '#card':'card',
        '#expiry-month':'expiry_month',
        '#expiry-year':'expiry_year',
        '#cvv':'cvv'
    }
    
    function orderFailureHandler(xhr) {
        $('#success-alert').hide();
        $('#error-alert').show();
        if(xhr && xhr.responseText) {
            if(xhr.status == 400) {
                $('#error-alert').text('Please fill in or correct all the required fields in the order form.');
            } else {
                $('#error-alert').text('We were unable to place your order, please try again later.');
            }
            errors = JSON.parse(xhr.responseText);
            for(var id in fldMap) {
                var fld = fldMap[id];
                if(errors[fld]) $(id).parents('.form-group').addClass('has-error');
            }
        }
    }
    
    function removeError() {
        $(this).parents('.form-group').removeClass('has-error');
    }
   
   exports.orders = {};
   exports.orders.registerEvents = registerEvents;
   exports.orders.submitOrder = submitOrder;
   exports.orders.buildOrderPayload = buildOrderPayload;
   exports.orders.orderSuccessHandler = orderSuccessHandler;
   exports.orders.orderFailureHandler = orderFailureHandler;
   
})(window);