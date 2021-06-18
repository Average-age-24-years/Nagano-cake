class Admin::OrderProductsController < ApplicationController

  def update
    order_product = OrderProduct.find(params[:id])
    order_product.update(order_product_params)
    redirect_to request.referrer, notice: "製作ステータスを#{order_product.product_status}に変更しました"
  end

  private

  def order_product_params
    params.require(:order_product).permit(:product_status)
  end

end
