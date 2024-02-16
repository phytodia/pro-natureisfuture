class OrdersController < ApplicationController
  layout "crm"
  def index
    @commercial = current_commercial
    @orders = Order.all
  end

  def new
    @order = Order.new
    @customers = Customer.where(commercial_id: current_commercial.id)
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_path
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
    params.require(:order).permit(:customer_id,:amount_ht,:amount_ttc,:reduction_ht,:prestashop_reference,:custom_date)
  end
end
