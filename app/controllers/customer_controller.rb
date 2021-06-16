class CustomerController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def withdraw_confirm
  end

  def withdraw
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Costomer.find(params[:id])
    @customer.update(customer_params)
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_kana, :first_kana, :email, :password, :post_code, :address, :phone_number, :is_deleted, :created_at, :updated_at)
  end
end
