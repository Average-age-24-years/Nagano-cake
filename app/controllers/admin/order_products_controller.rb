class Admin::OrderProductsController < ApplicationController

  before_action :authenticate_admin_admin!

  def update
    order_product = OrderProduct.find(params[:id])
    order_product.update(order_product_params)

    order = Order.find(order_product.order_id)
    case order_product.product_status
      when "製作中"
        order.update(order_status: "製作中")
      when "製作完了"
        order.update(order_status: "発送準備中")
    end
    redirect_to request.referrer
  end

  private

  def order_product_params
    params.require(:order_product).permit(:product_status)
  end

end
