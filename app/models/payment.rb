class Payment
    include ActiveModel::Model
    attr_accessor :cardholder, :card, :expiry_month, :expiry_year, :cvv, :transaction_id
    validates_presence_of :cardholder, :card, :expiry_month, :expiry_year, :cvv
    validates :card, credit_card_number: true
    validates :cvv, format: { with: /\A[0-9]{3,4}\z/, message: "only 3 or 4 numeric digits allowed" }
    
    def authorize
        # send credit card information to payment service
        # store a transaction id if authorized
        # returns true if authorized, false if not
        @transaction_id = '12345'
        return true
    end
    
    def confirm
        return false if !@transaction_id
        # confirm transaction with payment service
        return true
    end
    
    def void
        return false if !@transaction_id
        # void transaction with payment service to release funds that were authorized
        return true
    end
    
end