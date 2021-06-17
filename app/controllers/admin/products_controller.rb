class Admin::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).reverse_order
  end

  def new
    @product = Product.new
  end

  def create

  end

  def show
    @product = Product.find(params[:id])
    tax = 1.1
    @tax_price = @product.price * tax
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end

end
