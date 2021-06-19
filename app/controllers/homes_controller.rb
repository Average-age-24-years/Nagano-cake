class HomesController < ApplicationController
  def top
    binding.pry
    @products = Product.page(params[:page]).reverse_order.limit(4)
  end

  def about
  end
end
