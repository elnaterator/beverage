class HomeController < ApplicationController
  def index
    @env = Rails.env
  end
end
