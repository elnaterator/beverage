require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  
  setup do
    @order = orders(:one)
    @order_params = { card: '4111111111111111', cardholder: 'Bill Billson', city: 'Seattle', 
      country: 'USA', cvv: '123', expiry_month: '01', expiry_year: '19', first: 'Bill', last: 'Billson', qty: 5 }
  end
  
  test "should have routes for creating, showing and deleting an order" do
    assert_routing({ method: 'post', path: '/orders' }, { controller: "orders", action: "create", format: :json })
    assert_routing({ method: 'get', path: '/orders/1' }, { controller: "orders", action: "show", id: "1", format: :json })
    assert_routing({ method: 'delete', path: '/orders/1' }, { controller: "orders", action: "destroy", id: "1", format: :json })
  end
  
  test "should show order" do
    get :show, id: @order, format: :json
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: @order_params, format: :json
    end
    assert_response :success
    resp = JSON.parse(@response.body)
    assert_not_nil resp['id'], 'should return order as json'
    assert_equal resp['qty'], 5
    assert_equal resp['first'], 'Bill'
  end
  
  test "should reject invalid input on create" do
    post :create, order: @order_params.except(:qty), format: :json
    assert_response 400
    resp = JSON.parse(@response.body)
    assert_equal resp['qty'], ["can't be blank"]
  end
  
  test "should reject unauthorized payment on create" do
    # with a mock payment that fails authorization
    mock_payment = MiniTest::Mock.new
    mock_payment.expect :valid?, true
    mock_payment.expect :authorize, false, [Float]
    Payment.stub :new, mock_payment do
      post :create, order: @order_params, format: :json
      assert_response :error
      resp = JSON.parse(@response.body)
      assert_equal resp['msg'], ["unable to place order, please try again later"]
    end
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order, format: :json
    end
    assert_response :success
  end
  
end
