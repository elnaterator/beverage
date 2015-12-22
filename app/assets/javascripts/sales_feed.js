/**
 * Live sales feed
 */
;(function(exports) {

    function initSalesFeed() {
        var pusher = new Pusher('d64b28cbfe60f2535ec3', {
          encrypted: true
        });
        var channel = pusher.subscribe('default');
        channel.bind('new_sale', function(data) {
          renderNewSale(data);
        });
        channel.bind('new_delivery', function(data) {
          updateBottlesDelivered(data);
        });
    }
    
    function renderNewSale(data) {
      // add new item to feed
      $('#sales-feed .sales-feed-item').first().clone().prependTo('#sales-feed');
      // set field values
      var $item = $('#sales-feed .sales-feed-item').first();
      $item.show();
      $item.find('.datetime').text(data.datetime);
      $item.find('.qty').text(data.qty);
      $item.find('.name').text(data.name);
      $item.find('.city').text(data.city);
      $item.find('.country').text(data.country);
      // remove 6th item (or greater) from list
      $('#sales-feed').find('.sales-feed-item').slice(5).remove();
      // update bottles sold
      var bottlesSold = parseFloat($('#bottles-sold').text());
      var bottlesSold = bottlesSold + data.qty;
      $('#bottles-sold').text(bottlesSold);
    }
    
    function updateBottlesDelivered(data) {
      var bottlesDelivered = parseFloat($('#bottles-delivered').text());
      bottlesDelivered = bottlesDelivered + data.qty;
      $('#bottles-delivered').text(bottlesDelivered);
    }
    
    exports.feed = {};
    exports.feed.initSalesFeed = initSalesFeed;
    exports.feed.renderNewSale = renderNewSale;
    exports.feed.updateBottlesDelivered = updateBottlesDelivered;
    
})(window);