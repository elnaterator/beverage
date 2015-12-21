class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]

  # GET /orders/1
  def show
  end

  # POST /orders
  def create
    order_params = all_params.slice(:qty, :first, :last, :city, :country)
    payment_params = all_params.slice(:cardholder, :card, :expiry_month, :expiry_year, :cvv)
    @order = Order.new(order_params)
    @payment = Payment.new(payment_params)
    if @order.save
      render :show, status: :created, location: @order
    else
      render json: @order.errors, status: :error
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def all_params
      params.require(:order).permit(:qty, :first, :last, :city, :country, :cardholder, :card, :expiry_month, :expiry_year, :cvv)
    end
end
