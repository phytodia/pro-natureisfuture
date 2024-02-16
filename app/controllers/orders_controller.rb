class OrdersController < ApplicationController
  layout "crm"
  def index
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
  def order_params
    params.require(:product).permit(:customer_id,:amount_ht,:amount_ttc,:reduction_ht)
  end
end
