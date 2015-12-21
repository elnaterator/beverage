require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should validate missing fields" do
    assert Order.new(valid_order_data).valid?, "with all fields should be valid"
    assert !Order.new(valid_order_data.remove(:qty)).valid?, "missing qty should fail"
    assert !Order.new(valid_order_data.remove(:first)).valid?, "missing first should fail"
    assert !Order.new(valid_order_data.remove(:last)).valid?, "missing last should fail"
    assert !Order.new(valid_order_data.remove(:city)).valid?, "missing city should fail"
    assert !Order.new(valid_order_data.remove(:country)).valid?, "missing country should fail"
  end
  
  def valid_order_data
    {
      qty: 10,
      first: "Bill",
      last: "Billson",
      city: "Billville",
      country: "USA"
    }
  end
  
end
