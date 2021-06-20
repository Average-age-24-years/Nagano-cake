class Public::OrdersController < ApplicationController
  
  before_action :customer
  before_action :customer_address, only: [:new, :create]
  
  def new
    @order = Order.new
    @new_distination = Distination.new
    @distinations    = @customer.distinations.all
    @distination     = []
    @distinations.each do |d|
      @distination << "#{d.postal_code}  #{d.address}  #{d.name}"
    end 
  end 
  
  
  
  def create 
    session[:payment] = order_params[:payment]
    if    order_params[:radio] == "radio1"
      session[:address] = @customer_address
      redirect_to public_orders_confirm_path
    elsif order_params[:radio] == "radio2"
      session[:address] = order_params[:chose_address]
      redirect_to public_orders_confirm_path
    elsif order_params[:radio] == "radio3"
      postal_code       = order_params[:postal_code]
      address           = order_params[:address]
      name              = order_params[:name]
      session[:address] = "〒#{postal_code}　#{address}　#{name}" 
      new_distination
      redirect_to public_orders_confirm_path
    else
      render new_public_order_path
    end
  end 
  
  def confirm
    @cart_products  = @customer.cart_products.all
    @shipping       = shipping
    @total_price    = subtotal_price
    @billing_amount = subtotal_price + shipping
  end 
  
  # def create_order
  #   order.customer_id = @customer.id
  #   order.shipping    = shipping
  #   order.total_price = subtotal_price + shipping
  #   payment
  #   if order.save
  #     redirect_to public_orders_thanks_path
  #   else
  #     render :new
  #   end
  # end 
  
  def thanks
  end 
  
  private
  
  def customer
    @customer = current_customer
  end 
  
  def shipping
    shipping = 800
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
    distination.postal_code = order_params[:postal_code]
    distination.address     = order_params[:address]
    distination.name        = order_params[:name]
    flash[:notice] = "新しい配送先を追加しました" if distination.save
  end 
  
  def order_params
    params.require(:order).permit(:payment, :radio, :chose_address, :postal_code, :address, :name)
  end
	
end
