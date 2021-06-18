class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin_admin!

  def index
    products = Product.order(created_at: :asc)
    @products = Kaminari.paginate_array(products).page(params[:page]).per(10)

  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to admin_product_path(product), notice: "商品を登録しました"
    else
      @product = Product.new
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    tax = 1.1
    @tax_price = @product.price * tax
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to admin_product_path(product), notice: "商品情報を編集しました"
    else
      @product = Product.find(params[:id])
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
  end

end
