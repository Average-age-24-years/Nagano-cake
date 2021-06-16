Rails.application.routes.draw do

  namespace :public do
    resources :products, only: [:index, :show]
  end

end
