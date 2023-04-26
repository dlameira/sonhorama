Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/about', to: "pages#about"

  resources :projects

  resources :projects do
    put :update_order, on: :collection
  end

  resources :projects do
    patch :update_position, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
