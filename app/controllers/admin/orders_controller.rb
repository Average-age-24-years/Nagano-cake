class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin_admin!

  def index
    @orders = Order.page(params[:page]).reverse_order
    customer = Customer.current_scope
    @orders_all = customer.all.order('created_at ASC')
    order_date_sum = @orders_all.group("date(created_at)").sum(:total_price)
    @prices = order_date_sum.values
    @dates = order_date_sum.keys
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)

    order_product = OrderProduct.where(order_id: order.id)
    if order.order_status == "入金確認"
      order_product.update(product_status: "製作待ち")
    end

    redirect_to admin_order_path(order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
