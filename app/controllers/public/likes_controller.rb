class Public::LikesController < ApplicationController

  def index
    products = current_customer.likes.all
    @products = Kaminari.paginate_array(products).page(params[:page]).per(10)
  end

  def create
    product = Product.find(params[:product_id])
    like = current_customer.likes.new(product_id: product.id)
    like.save
    redirect_to request.referrer
  end

  def destroy
    product = Product.find(params[:product_id])
    like = current_customer.likes.find_by(product_id: product.id)
    like.destroy
    redirect_to request.referrer
  end

end
