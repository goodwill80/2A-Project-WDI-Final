Rails.application.routes.draw do
  get 'product/new'

  resources :users
  resources :products


  #static Pages
  root 'static_pages#home'
  get  '/contact',    to: 'static_pages#contact'
  get  '/about',   to: 'static_pages#about'

  #users
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  #sessions for log in and log out
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
