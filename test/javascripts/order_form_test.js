//= require jquery/dist/jquery
//= require bootstrap-sprockets
//= require order_form

module('order form : quantity change handler', {
    setup: function() {
        fixture.load('order_form.html');
        orders.registerEvents();
    }
});

test('should update quantity in summary', function() {
   $("#qty").val(2);
   $("#qty").change();
   equal($("#summary-qty").text(), '2', 'should update summary-qty');
});

test('should update total in summary', function() {
   $('#price').attr('price',3.5);
   $("#qty").val(2);
   $("#qty").change();
   equal($("#total").text(), '$7.00', 'should update total');
});


module('order form : click place order', {
    setup: function() {
        fixture.load('order_form.html');
    }
});


function setFields() {
    $('#qty').val(5);
    $('#first-name').val('Bill');
    $('#last-name').val('Billson');
    $('#city').val('Seattle');
    $('#country').val('USA');
    $('#cardholder').val('Bill Billson');
    $('#card').val('4111111111111111');
    $('#expiry-month').val('01');
    $('#expiry-year').val('19');
    $('#cvv').val('111');
}

test('success handler should render success message', function() {
   orders.orderSuccessHandler({id:123,qty:10,first:'Bill',last:'',city:'Seattle',country:'USA'})
   ok($('#success-alert').is(':visible'), "success alert should be rendered");
});

test('should submit order with success', function() {
    setFields();
    // stub ajax for success
    $.ajax = function(conf) {
        conf.success(conf.data);
    }
    $('#submit-order').click();
    ok($('#success-alert').is(':visible'), "success alert should be rendered");
});

test('should submit order with error', function() {
    setFields();
    // stub ajax for failure
    $.ajax = function(conf) {
        conf.error();
    }
    $('#submit-order').click();
    ok($('#error-alert').is(':visible'), "error alert should be rendered");
});