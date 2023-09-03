Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/menu", to: "menu#index"

  resources :menu do
    collection do
      post :import
    end
  end
  
  
  # Defines the root path route ("/")
  root "menu#index"
end
