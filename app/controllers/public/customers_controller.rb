class Public::CustomersController < ApplicationController
    def show
      @customer = Customer.find(params[:id])
    end
    
    def withdraw_confirm
    end
    
    def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
    end
    
    def edit
      @customer = current_customer
    end
    
    def update
      @customer = current_customer
      if @customer.update(customer_params)
       flash[:notice] = "登録を変更しました。"
       redirect_to public_customer_path
      else
       render "edit"  
      end
    end  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :password, :postal_code, :address, :telephone_number, :is_deleted, :created_at, :updated_at )
  end
end
