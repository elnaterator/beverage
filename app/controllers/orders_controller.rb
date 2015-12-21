class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  before_action :set_order_service, only: [:create]

  # GET /orders/1
  def show
  end

  # POST /orders
  def create
    logger.info "Creating order: #{all_params}"
    @order = Order.new(all_params.slice(:qty, :first, :last, :city, :country))
    @payment = Payment.new(all_params.slice(:cardholder, :card, :expiry_month, :expiry_year, :cvv))
    order_valid = @order.valid?
    payment_valid = @payment.valid?
    if order_valid && payment_valid
      if @order_service.place_order(@payment,@order)
        render :show, status: :created, location: @order
      else
        render json: { msg: ['unable to place order, please try again later'] }, status: :error
      end
    else
      errors = {}
      errors.merge(@order.errors) if @order.errors
      errors.merge(@payment.errors) if @payment.errors
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
    
    def set_order_service
      @order_service = OrderService.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def all_params
      params.require(:order).permit(:qty, :first, :last, :city, :country, :cardholder, :card, :expiry_month, :expiry_year, :cvv)
    end
end
