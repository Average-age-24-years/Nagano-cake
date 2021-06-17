class Public::CartProductsController < ApplicationController

  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def create
    @cart_product = current_customer.cart_products.build(cart_product_params)
    @cart_products = current_customer.cart_products.all

    @cart_products.each do |cart_product|
	    if cart_product.product_id == @cart_product.product_id
			  sum_quantity = cart_product.quantity + @cart_product.quantity
			  cart_product.update_attribute(:quantity, sum_quantity)
			  @cart_product.delete
	    end
		end
		@cart_product.save
		redirect_to public_cart_products_path, notice: "カートに商品を追加しました"
  end

  def update
  end

  private

	def cart_product_params
	  params.require(:cart_product).permit(:product_id, :quantity)
	end

end
