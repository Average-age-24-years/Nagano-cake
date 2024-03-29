class Public::OrdersController < ApplicationController

  before_action :customer
  before_action :customer_address, only: [:new, :create]

  def new
    @order = Order.new
    @new_distination = Distination.new
    @distinations    = @customer.distinations.all
  end

  def shipping
    if order_params[:code] == "202106" && current_customer.orders.count == 0
      shipping = 0
    else
      shipping = 800
    end
  end

  def confirm
    @order = Order.new
    @cart_products = current_customer.cart_products.all
    @total_price   = subtotal_price
    if order_params[:code].present? && current_customer.orders.count != 0
      redirect_to new_public_order_path, alert: "無効なクーポンです"
    elsif order_params[:code].present? && order_params[:code] != "202106"
      redirect_to new_public_order_path, alert: "無効なクーポンです"
    else
      @shipping = shipping
      @order.shipping = shipping
    end
    @billing_amount = subtotal_price + shipping
    @order.payment   = order_params[:payment]
    if order_params[:radio]    == "radio1"
      @order.post_code = @customer.postal_code
      @order.address   = @customer.address
      @order.name      = @customer.last_name + @customer.first_name
    elsif order_params[:radio] == "radio2"
      @distination = Distination.find(params[:order][:id])
      @order.post_code = @distination.postal_code
      @order.address   = @distination.address
      @order.name      = @distination.name
    elsif order_params[:radio] == "radio3"
      if    order_params[:post_code] == ""
        redirect_to new_public_order_path, alert: "郵便番号を入力してください"
      elsif order_params[:address]   == ""
        redirect_to new_public_order_path, alert: "住所を入力してください"
      elsif order_params[:name]      == ""
        redirect_to new_public_order_path, alert: "宛名を入力してください"
      end 
      @order.post_code = order_params[:post_code]
      @order.address   = order_params[:address]
      @order.name      = order_params[:name]
      new_distination
    else
      render new_public_order_path
    end
  end

  def create
    @order             = Order.new
    @order.customer_id = @customer.id
    @order.payment     = order_params[:payment]
    shipping          = order_params[:shipping].to_i
    @order.shipping    = order_params[:shipping]
    @order.total_price = subtotal_price + shipping
    @order.post_code   = order_params[:post_code]
    @order.address     = order_params[:address]
    @order.name        = order_params[:name]
    if @order.save && @customer.cart_products.each do |products|
      @order_product                = OrderProduct.new
      @order_product.product_id     = products.product.id
      @order_product.order_id       = @order.id
      @order_product.products_price = products.product.price
      @order_product.quantity       = products.quantity
      @order_product.save
    end
      @customer.cart_products.destroy_all
      ThanksMailer.send_when_create_order(@order, @customer).deliver
      redirect_to public_orders_thanks_path
    else
      render :confirm
    end
  end

  def thanks
  end

  def index
    orders = current_customer.orders.all
    @orders = Kaminari.paginate_array(orders).page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def customer
    @customer = current_customer
  end

  def customer_address
    postal_code = @customer.postal_code
    address     = @customer.address
    name        = @customer.last_name + @customer.first_name
    @customer_address = "〒#{postal_code}　#{address}　#{name}"
  end

  def subtotal_price
	  @cart_products = current_customer.cart_products.all
	  total_price = 0
    @cart_products.each do |cart_product|
      product_price = ((cart_product.product.price * 1.10) * cart_product.quantity).round
      total_price += product_price
    end
    total_price
  end

  def new_distination
    distination = Distination.new
    distination.customer_id = current_customer.id
    distination.postal_code = order_params[:post_code]
    distination.address     = order_params[:address]
    distination.name        = order_params[:name]
    flash[:notice] = "新しい配送先を追加しました" if distination.save
  end

  def order_params
    params.require(:order).permit(:radio, :payment, :post_code, :address, :name, :code, :shipping)
  end

end
