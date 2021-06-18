class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order), notice: "注文ステータスを#{order.order_status}に変更しました"
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
