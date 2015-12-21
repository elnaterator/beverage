

namespace :order do
    
    desc 'place an order, params are optional, defaulting to 5,Bill,Billson,Seattle,USA'
    task :place, [:qty,:first,:last,:city,:country] => :environment do |t, args|
        args.with_defaults(qty: 5, first: 'Bill', last: 'Billson', city: 'Seattle', country: 'USA')
        puts "Placing an order for: #{args}"
        
        order = Order.new(args.to_h)
        payment = Payment.new(cardholder: 'Bill Billson', card: '4111111111111111', expiry_month: '01', expiry_year: '19', cvv: '111')
        
        if !order.valid?
            puts "Unable to place order: #{order.errors}"
            return
        end
        
        order_service = OrderService.new
        order_service.place_order(payment,order)
        puts "Order successfully placed."
    end
    
end