Rails.application.routes.draw do
  resources :jobs
  resources :clients
  resources :orders
  resources :products
  devise_for :users#,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },:skip => [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#admin'
  get '/cal_cost', to: "orders#cal_cost", as: 'cal_cost'
  get '/dashboard', to: "home#dashboard", as: "dashboard"
  get 'admin', to: 'home#admin', as: :admin
  # get 'users/profile/edit', to: 'users#edit_profile', as: :edit_profile
  resources :users, only: [:edit, :update]
  # , path: '/users/profile'

end
