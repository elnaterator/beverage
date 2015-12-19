//= require jquery/dist/jquery
//= require order_form

module('order form : quantity change handler', {
    setup: function() {
        fixture.load('fixtures.html');
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