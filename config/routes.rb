Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  
  devise_for :customers, controllers: {
    registrations: 'public/customers/registrations',
    sessions: "public/customers/sessions",
    passwords: 'public/customers/passwords'
  }
  
  namespace :admin do
    devise_for :admins, controllers: {
      sessions: 'admin/admins/sessions',
      registrations: 'admin/admins/registrations',
      passwords: 'admin/admins/passwords'
    }
  end 
  
  namespace :public do
    get '/customer/confirm' => 'customers#withdraw_confirm', as: 'confirm_withdraw'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do

  end
  end
  
end
