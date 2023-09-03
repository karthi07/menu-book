require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/menu", to: "menu#index"

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  resources :menu do
    collection do
      post :import
    end
  end
  
  
  # Defines the root path route ("/")
  root "menu#index"
end
