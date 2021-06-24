class Public::DistinationsController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @distination = Distination.new
    @distinations = @customer.distinations
  end 
  
  def create
    distination = current_customer.distinations.new(distination_params)
    distination.customer_id = current_customer.id
    distination.save
    redirect_to public_distinations_path(current_customer)
  end 
  
  def edit
    @distination = Distination.find(params[:id])
    if @distination.customer != current_customer
      redirect_to root_path
    end 
  end 
  
  def update
    @distination = Distination.find(params[:id])
    if @distination.update(distination_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to public_distinations_path
    else
      render :edit
    end
  end 
  
  def destroy
    distination = Distination.find(params[:id])
    distination.destroy
    redirect_to public_distinations_path
  end 
  
  private

  def distination_params
    params.require(:distination).permit(:postal_code, :address, :name)
  end
  
end
