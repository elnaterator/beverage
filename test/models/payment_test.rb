require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  
  test "should validate missing fields" do
    # with all fields should pass validation
    assert Payment.new(valid_payment_data).valid?
    # missing any 1 field should fail validation
    assert !Payment.new(valid_payment_data.remove(:cardholder)).valid?, 'missing cardholder not validated'
    assert !Payment.new(valid_payment_data.remove(:card)).valid?, 'missing card not validated'
    assert !Payment.new(valid_payment_data.remove(:expiry_month)).valid?, 'missing expiry_month not validated'
    assert !Payment.new(valid_payment_data.remove(:expiry_year)).valid?, 'missing expiry_year not validated'
    assert !Payment.new(valid_payment_data.remove(:cvv)).valid?, 'missing cvv not validated'
  end
  
  test "should validate credit card number" do
    assert !Payment.new(valid_payment_data.merge(card: '123')).valid?
  end
  
  test "should validate cvv code" do
    assert !Payment.new(valid_payment_data.merge(cvv: '12')).valid?, '2 digits not allowed'
    assert Payment.new(valid_payment_data.merge(cvv: '123')).valid?, '3 digits allowed'
    assert Payment.new(valid_payment_data.merge(cvv: '1234')).valid?, '4 digits allowed'
    assert !Payment.new(valid_payment_data.merge(cvv: '12345')).valid?, '5 digits not allowed'
    assert !Payment.new(valid_payment_data.merge(cvv: 'abc')).valid?, 'chars not allowed'
  end
  
  # authorize, confirm, and void are just dummy methods that would connect to paypal or something
  
  test "should authorize payment" do
    payment = Payment.new(valid_payment_data)
    assert payment.authorize, "should return true when payment authorized"
    assert_equal payment.transaction_id, "12345", "should set a transaction id"
  end
  
  test "should confirm payment" do
    payment = Payment.new(valid_payment_data)
    assert !payment.confirm, "should not allow confirm if not authorized"
    payment.authorize
    assert payment.confirm, "should return true if authorized"
  end
  
  test "should void payment" do
    payment = Payment.new(valid_payment_data)
    assert !payment.void, "should not allow void if not authorized"
    payment.authorize
    assert payment.void, "should allow void if authorized"
  end
  
  def valid_payment_data
      { cardholder: "John L Smith", card: "4111111111111111", expiry_month: "01", expiry_year: "19", cvv: "111" }
  end
  
end
