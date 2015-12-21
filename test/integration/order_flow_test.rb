require 'test_helper'

class OrderFlowTest < ActionDispatch::IntegrationTest
  setup do
    @order_params = { card: '4111111111111111', cardholder: 'Bill Billson', city: 'Seattle', 
      country: 'USA', cvv: '123', expiry_month: '01', expiry_year: '19', first: 'Bill', last: 'Billson', qty: 5 }
  end
    
  test "should place an order successfully" do
    get '/'
    assert_response :success
    assert_difference('Order.count') do
      post '/orders', order: @order_params, format: :json
      assert_response :success
    end
  end

end