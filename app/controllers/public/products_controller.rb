class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).reverse_order
    @active_products = Product.where(is_active: true)
  end

  def show
    @product = Product.find(params[:id])
    tax = 1.10
    @tax_price = @product.price * tax
    if !@product.is_active
      redirect_to public_products_path
    end
    @cart_product = CartProduct.new
  end

  def sort
    selection = params[:keyword]
    @products = Product.where(is_active: true).sort(selection)
  end

end
