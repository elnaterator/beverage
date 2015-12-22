

namespace :order do
    
    desc 'place an order, default order details are 5,Bill,Billson,Seattle,USA'
    task :sell, [:qty,:first,:last,:city,:country] => :environment do |t, args|
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
    
    desc 'mark an order as delivered, default order id is the earliest non-delivered order'
    task :deliver, [:id] => :environment do |t, args|
        args.with_defaults(id: Order.where(delivered: false).order(id: :asc).take.id)
        puts "Deliver order #{args[:id]}"
        order = Order.find(args[:id])
        puts "Order details: #{order.inspect}"
        
        order_service = OrderService.new
        order_service.deliver(order)
        puts "Order successfully delivered"
    end
    
end