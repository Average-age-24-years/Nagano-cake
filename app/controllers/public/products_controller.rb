class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).reverse_order
  end

  def show
    @product = Product.find(params[:id])
    tax = 1.1
    @tax_price = @product.price * tax
  end

end
