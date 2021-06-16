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
  end

  def edit
  end

  def update
  end

end
