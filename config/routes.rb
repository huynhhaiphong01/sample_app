Rails.application.routes.draw do
  resources :products
  get 'partials/new'
  get 'partials/edit'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'users/new'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
