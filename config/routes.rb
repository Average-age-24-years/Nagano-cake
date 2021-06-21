Rails.application.routes.draw do

  namespace :admin do
    get 'orders/index'
    get 'orders/show'
    get '/search', to: 'search#search'
  end
  namespace :public do
    get 'cart_products/index'
    get '/search', to: 'search#search'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end

  root to: 'homes#top'
  get      'homes/about' => 'homes#about', as: 'about'


  devise_for :customers, controllers: {
    registrations: 'public/customers/registrations',
    sessions:      'public/customers/sessions',
    passwords:     'public/customers/passwords'
  }

  namespace :admin do
    devise_for :admins, controllers: {
      sessions:      'admin/admins/sessions',
      registrations: 'admin/admins/registrations',
      passwords:     'admin/admins/passwords'
    }
    resources :products
    resources :genres,         only:[:index, :create, :edit, :update]
    resources :customers,      only:[:index, :show, :edit, :update]
    resources :orders,         only:[:index, :show, :update]
    resources :order_products, only: [:update]
  end

  namespace :public do
    get       '/customer/confirm'             => 'customers#withdraw_confirm', as: 'confirm_withdraw'
    patch     '/customers/withdraw'           => 'customers#withdraw',         as: 'withdraw_customer'
    get       'orders/confirm'                => 'orders#confirm',             as: 'orders_confirm'
    get       'orders/thanks'                 => 'orders#thanks',              as: 'orders_thanks'
    post      'orders/new_distination'        => 'orders#new_distination',     as: 'orders_new_distination'
    post      'orders/create_order'           => 'orders#create_order',        as: 'orders_create_order'
    resources :products,      only: [:index, :show] do
      resource :likes,        only: [:create, :destroy]
    end
    resources :customers,     only: [:show, :withdraw_confirm, :edit, :update, :withdraw] do
      resources :likes,       only: [:index]
    end

    resources :distinations,  only: [:index, :create, :edit, :update, :destroy]
    resources :cart_products, only: [:index]
    resources :orders,        only: [:new, :create, :index, :show]

    post      'cart_products'                 => 'cart_products#create',      as: 'add_cart_products'
    patch     'cart_products/:id/:product_id' => 'cart_products#update',      as: 'update_cart_products'
    delete    'cart_products/:id/:product_id' => 'cart_products#destroy',     as: 'destroy_cart_products'
    delete    'cart_products'                 => 'cart_products#all_destroy', as: 'all_destroy'
  end

end
