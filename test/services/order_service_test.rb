require 'test_helper'
require 'pusher'

class OrderServiceTest < ActiveSupport::TestCase
    setup do
        @order = Order.new(qty: 5, first: 'Bill', last: 'Billson', city: 'Seattle', country: 'USA')
        @payment = Payment.new(cardholder: 'John Smith', card: '4111111111111111', expiry_month: '01', expiry_year: '19')
        @order_service = OrderService.new
    end
    
    test "should create new order" do
        assert_difference('Order.count') do
            assert @order_service.place_order(@payment, @order)
        end
    end
    
    test "should send new sale event to pusher" do
        @order_service.place_order(@payment, @order)
        assert_equal Pusher.last_trigger[:channel], 'default'
        assert_equal Pusher.last_trigger[:event], 'new_sale'
        assert_equal Pusher.last_trigger[:payload][:qty], 5
        assert_equal Pusher.last_trigger[:payload][:name], 'Bill'
        assert_equal Pusher.last_trigger[:payload][:city], 'Seattle'
        assert_equal Pusher.last_trigger[:payload][:country], 'USA'
    end
    
    test "deliver should mark order as delivered" do
        @order.save
        assert !@order.delivered, 'order shouldnt be delivered before calling deliver'
        @order_service.deliver @order
        @order.reload
        assert @order.delivered, 'order should be delivered after calling deliver'
    end
    
    test "should send new delivery event to pusher" do
        @order.save
        @order_service.deliver(@order)
        assert_equal Pusher.last_trigger[:channel], 'default'
        assert_equal Pusher.last_trigger[:event], 'new_delivery'
        assert_equal Pusher.last_trigger[:payload][:qty], 5
        assert_equal Pusher.last_trigger[:payload][:name], 'Bill'
        assert_equal Pusher.last_trigger[:payload][:city], 'Seattle'
        assert_equal Pusher.last_trigger[:payload][:country], 'USA'
    end

end