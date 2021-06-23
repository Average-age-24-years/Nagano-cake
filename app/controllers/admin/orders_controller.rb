class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin_admin!

  def index
    @orders = Order.page(params[:page]).reverse_order
    @diaries=Order.all.order('created_at ASC')
    @weights=@diaries.map(&:total_price)
    @dates=@diaries.map{|diary| diary.created_at.strftime('%Y/%m/%d') }
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
