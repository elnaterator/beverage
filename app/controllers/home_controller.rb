class HomeController < ApplicationController
  def index
    @env = Rails.env
    @price = Product.first.price
    @testimonials = Testimonial.all
  end
end
