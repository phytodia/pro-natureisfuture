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
    @order.order_products.build
  end

  def create
    @order = Order.new(order_params)
    @order.order_products.clear
    order_products = params[:order][:order_products_attributes]
    order_products.keys.each do |key|
      orderpdt = OrderProduct.new(product_id:order_products[key]["product_id"], quantity:order_products[key]["quantity"], amount_ht:order_products[key]["amount_ht"])
      orderpdt.save
      @order.order_products << orderpdt
    end
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
    order_pdts_params = params[:order][:order_products_attributes]

    ## comparer les quantités pour chaque produit
    @order.update(order_params)

    if order_pdts_params.present?
      @order.order_products.destroy_all
      order_pdts_params.keys.each do |key|
        orderpdt = OrderProduct.new(product_id:order_pdts_params[key]["product_id"], quantity:order_pdts_params[key]["quantity"], amount_ht:order_pdts_params[key]["amount_ht"],order_id:@order.id)
        orderpdt.save
        #@order.order_products << orderpdt
      end
    end
    @order.save
    redirect_to orders_path
  end

  def destroy
  end
  private
  def order_params
    params.require(:order).permit(:customer_id,:order_id,:amount_ht,:amount_ttc,:reduction_ht,:tva,:prestashop_reference,:custom_date,:state,:payment_mode,order_products:[:product_id,:amount_ht,:quantity])
  end
end
