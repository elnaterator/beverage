class HomeController < ApplicationController
  def index
    @env = Rails.env
    @price = Product.first.price
    @testimonials = Testimonial.all
    @total_qty_ordered = Order.sum(:qty)
    @latest_orders = Order.order(created_at: :desc).limit(5)
  end
end
