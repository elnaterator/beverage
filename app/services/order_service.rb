require 'pusher'

Pusher.url = "https://d64b28cbfe60f2535ec3:6b7414729ad4543aa71b@api.pusherapp.com/apps/161222"
Pusher.logger = Rails.logger

class OrderService
    
    # 1. authorize payment
    # 2. create order in db
    # 3. confirm payment
    # 4. post message to pusher
    def place_order payment, order
        Rails.logger.debug "Placing an order for #{order.qty} bottles..."
        total = order.qty * Product.find_by(code: 'HABSELTZ').price
        return false if total <= 0 || !payment.authorize(total)
        if order.save
            if !payment.confirm
                order.delete
                return false
            end
            Pusher.trigger('default', 'new_sale', {
              qty: order.qty,
              name: order.first,
              city: order.city,
              country: order.country
            })
            return true
        else
            Rails.logger.error 'unable to save order'
            payment.void
            return false
        end
    end
    
    
    def deliver order
        order.update(delivered: true)
        Pusher.trigger('default', 'new_delivery', {
          qty: order.qty,
          name: order.first,
          city: order.city,
          country: order.country
        })
    end
    
end