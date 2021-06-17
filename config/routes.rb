Rails.application.routes.draw do

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  
  devise_for :customers, controllers: {
    registrations: 'public/customers/registrations',
    sessions: 'public/customers/sessions',
    passwords: 'public/customers/passwords'
  }
  
  namespace :admin do
    devise_for :admins, controllers: {
      sessions: 'admin/admins/sessions',
      registrations: 'admin/admins/registrations',
      passwords: 'admin/admins/passwords'      
    }
    resources :products
  end 
  
  namespace :public do
    devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: "customers/sessions",
    passwords: 'customers/passwords'
    }
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :withdraw_confirm, :edit, :update, :withdraw]
    resources :distinations, only: [:index, :create, :edit, :update, :destroy]
  end

end
