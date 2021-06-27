class Public::ProductsController < ApplicationController

  def index
    @active_products = Product.where(is_active: true)
    @products = Kaminari.paginate_array(@active_products).page(params[:page]).per(8)
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
    active_products = Product.where(is_active: true)

    case selection
      when 'new'
        @selection = "新着順"
        products = active_products.order(created_at: :DESC)
      when 'low_price'
        @selection = "価格が低い順"
        products = active_products.order(price: :ASC)
      when 'likes'
        @selection = "人気順"
        products = Product.includes(:order_products).sort {|a,b|
        b.order_products.includes(:order_products).count <=>
        a.order_products.includes(:order_products).count
        }
    end
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

end
