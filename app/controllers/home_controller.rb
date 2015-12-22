class HomeController < ApplicationController
  def index
    @env = Rails.env
    @price = Product.first.price
    @testimonials = Testimonial.all
    @total_qty_ordered = Order.sum(:qty)
    @latest_orders = Order.order(created_at: :desc).limit(5)
    if(@latest_orders.size < 1)
      @latest_orders = [{ qty: 0, first: '', last: '', city: '', country: '', created_at: '' }]
    end
    @total_qty_delivered = Order.where(delivered: true).sum(:qty)
  end
end
