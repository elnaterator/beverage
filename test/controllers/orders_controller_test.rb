require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  
  setup do
    @order = orders(:one)
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
      post :create, 
        order: { card: '4111111111111111', cardholder: 'Bill Billson', city: @order.city, country: @order.country, cvv: '123', expiry_month: '01', expiry_year: '19', first: @order.first, last: @order.last, qty: @order.qty }, 
        format: :json
    end
    assert_response :success
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order, format: :json
    end
    assert_response :success
  end
  
end
