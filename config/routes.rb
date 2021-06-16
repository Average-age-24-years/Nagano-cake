Rails.application.routes.draw do


  namespace :public do
    resources :products, only: [:index, :show]
    resources :customers, only: [:show, :withdraw_confirm, :edit, :update, :withdraw]
  end
  
  get 'homes/top'
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
