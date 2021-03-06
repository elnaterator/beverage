//= require jquery/dist/jquery
//= require sales_feed

var data;

module("sales feed : renderNewSale", {
    setup: function() {
        fixture.load("sales_feed.html");
        data = {
            datetime: '2015-12-31 12:59:59',
            qty: 10,
            name: 'Bill',
            city: 'London',
            country: 'England'
        }
    }
});



test("should render a new sales-feed-item", function() {
    
    ok(typeof(feed.renderNewSale) !== "undefined", 'function exists');
    
    var $feed = $('#sales-feed');
    var lenBefore = $feed.children().length
    
    feed.renderNewSale(data);
    equal(lenBefore + 1, $feed.children().length, 'adds 1 more item to feed');
    
    var datetime = $feed.children().first().find('.datetime').text();
    var qty = $feed.children().first().find('.qty').text();
    var name = $feed.children().first().find('.name').text();
    var city = $feed.children().first().find('.city').text();
    var country = $feed.children().first().find('.country').text();
    
    equal(data.datetime, datetime, 'datetime');
    equal(data.qty, qty, 'qty');
    equal(data.name, name, 'name');
    equal(data.city, city, 'city');
    equal(data.country, country, 'country');
    
});



test("should render max of 5 items on screen", function() {
    var $feed = $('#sales-feed');
    equal(3, $feed.children().length, '3 items total');
    feed.renderNewSale(data);
    equal(4, $feed.children().length, '4 items total');
    feed.renderNewSale(data);
    equal(5, $feed.children().length, '5 items total');
    feed.renderNewSale(data);
    equal(5, $feed.children().length, '5 items total');
});



function getData(qty) {
    data.qty = qty;
    return data;
}

test("should move items down the list", function() {
    var $feed = $('#sales-feed');
    feed.renderNewSale(getData(5));
    feed.renderNewSale(getData(4));
    feed.renderNewSale(getData(3));
    feed.renderNewSale(getData(2));
    feed.renderNewSale(getData(1));
    equal('5', $feed.children().eq(4).find('.qty').text(), 'first added, last in list');
    equal('4', $feed.children().eq(3).find('.qty').text(), '2nd');
    equal('3', $feed.children().eq(2).find('.qty').text(), '3rd');
    equal('2', $feed.children().eq(1).find('.qty').text(), '4th');
    equal('1', $feed.children().eq(0).find('.qty').text(), '5th added is first in list');
});



test("should update bottles sold statistic", function() {
    $('#bottles-sold').text('10');
    feed.renderNewSale(getData(5));
    equal($('#bottles-sold').text(),'15','bottles sold not updated correctly');
});




module("sales feed : updateBottlesDelivered", {
    setup: function() {
        fixture.load("sales_feed.html");
    }
});

test('should update bottles delivered', function() {
    $('#bottles-delivered').text('10');
    data = { qty: 5 };
    feed.updateBottlesDelivered(data);
    equal($('#bottles-delivered').text(),'15','bottles delivered not updated correctly');
});