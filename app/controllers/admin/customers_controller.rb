class Admin::CustomersController < ApplicationController
  
   before_action :authenticate_admin_admin!
  
  def index
    customers = Customer.all
    @customers = Kaminari.paginate_array(customers).page(params[:page]).per(10)
  end 
  
  def show
    @customer = Customer.find(params[:id])
  end 
  
  def edit
    @customer = Customer.find(params[:id])
  end 
  
  def update
     @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to admin_customer_path
    else
      render "edit"
    end
  end 
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
  
end
