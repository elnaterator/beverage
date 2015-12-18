/**
 * Live sales feed
 */
;(function(exports) {

    function initSalesFeed() {
        // Enable pusher logging - don't include this in production
        Pusher.log = function(message) {
          if (window.console && window.console.log && $('#env').text() != 'production') {
            window.console.log(message);
          }
        };
        var pusher = new Pusher('d64b28cbfe60f2535ec3', {
          encrypted: true
        });
        var channel = pusher.subscribe('sales');
        channel.bind('new_sale', function(data) {
          console.log('new sale');
          console.log(data);
          renderNewSale(data);
        });
    }
    
    function renderNewSale(data) {
      // add new item to feed
      $('#sales-feed .sales-feed-item').first().clone().prependTo('#sales-feed');
      // set field values
      var $item = $('#sales-feed .sales-feed-item').first();
      $item.find('.datetime').text(data.datetime);
      $item.find('.qty').text(data.qty);
      $item.find('.name').text(data.name);
      $item.find('.city').text(data.city);
      $item.find('.country').text(data.country);
      // remove 6th item (or greater) from list
      $('#sales-feed').find('.sales-feed-item').slice(5).remove();
    }
    
    exports.feed = {};
    exports.feed.initSalesFeed = initSalesFeed;
    exports.feed.renderNewSale = renderNewSale;
    
})(window);