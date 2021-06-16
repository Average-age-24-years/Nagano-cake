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
  
end
