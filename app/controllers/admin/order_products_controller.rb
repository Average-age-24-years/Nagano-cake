class Admin::OrderProductsController < ApplicationController

  before_action :authenticate_admin_admin!

  def update
    order_product = OrderProduct.find(params[:order_product][:product_id])
    order_product.update(order_product_params)
    late_order_product = OrderProduct.where(order_id: params[:id]).where(product_status: "製作中")
    latest_order_product = OrderProduct.where(order_id: params[:id]).where(product_status: "製作待ち")

    order = Order.find(order_product.order_id)
    if order_product.product_status == "製作中"
      order.update(order_status: "製作中")
    elsif order_product.product_status == "製作完了" && late_order_product.count == 0 && latest_order_product.count == 0
      order.update(order_status: "発送準備中")
    end
    redirect_to request.referrer
  end

  private

  def order_product_params
    params.require(:order_product).permit(:product_status)
  end

end
