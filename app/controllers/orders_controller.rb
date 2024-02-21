class OrdersController < ApplicationController
  layout "crm"
  def index
    @commercial = current_commercial
    customers = Customer.where(commercial_id:@commercial.id)
    @orders = Order.where(customer_id: customers.pluck(:id))
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
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
    @customers = Customer.where(commercial_id: current_commercial.id)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.save
    redirect_to orders_path
  end

  def destroy
  end
  private
  def order_params
    params.require(:order).permit(:customer_id,:amount_ht,:amount_ttc,:reduction_ht,:tva,:prestashop_reference,:custom_date,:state,:payment_mode)
  end
end
