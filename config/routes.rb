Rails.application.routes.draw do
   devise_for :customers, controllers: {
    registrations: 'public/customers/registrations',
    sessions: 'public/customers/sessions',
    passwords: 'public/customers/passwords'
  }

  get 'search/search'
  
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'cart_products/index'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'



  namespace :admin do
    devise_for :admins, controllers: {
      sessions: 'admin/admins/sessions',
      registrations: 'admin/admins/registrations',
      passwords: 'admin/admins/passwords'
    }
    resources :products
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_products, only: [:update]
  end

  namespace :public do
    get '/customer/confirm' => 'customers#withdraw_confirm', as: 'confirm_withdraw'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :withdraw_confirm, :edit, :update, :withdraw]
    resources :distinations, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_products, only: [:index]
    post 'cart_products' => 'cart_products#create', as: 'add_cart_products'
    patch 'cart_products/:id/:product_id' => 'cart_products#update', as: 'update_cart_products'
    delete 'cart_products/:id/:product_id' => 'cart_products#destroy', as: 'destroy_cart_products'
    delete 'cart_products' => 'cart_products#all_destroy', as: 'all_destroy'
  end

end
