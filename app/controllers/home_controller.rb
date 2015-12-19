class HomeController < ApplicationController
  def index
    @env = Rails.env
    @price = 3.0
  end
end
