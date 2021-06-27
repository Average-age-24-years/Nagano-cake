class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin_admin!
  before_action :set_genres, only: [:new, :create, :edit, :update]

  def index
    products = Product.order(created_at: :asc)
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.name.match(/[一-龠々]/)
      @product.conversion_name = @product.name.to_kanhira.to_roman
    elsif @product.name.is_hira? || @product.name.is_kana?
      @product.conversion_name = @product.name.to_roman
    else
      @product.conversion_name = @product.name
    end
    if @product.save
      redirect_to admin_product_path(@product), notice: "商品を登録しました"
    else
      render "new"
    end
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
    @product = Product.find(params[:id])
    if @product.name.match(/[一-龠々]/)
      @product.conversion_name = @product.name.to_kanhira.to_roman
    elsif @product.name.is_hira? || @product.name.is_kana?
      @product.conversion_name = @product.name.to_roman
    else
      @product.conversion_name = @product.name
    end    
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品情報を編集しました"
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end
  
  def set_genres
    @genres = Genre.all
  end

end
