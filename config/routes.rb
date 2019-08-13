Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/about", to: "static_pages#about"
    root "static_pages#home"
    resources :users do
      member do
        get :following, :followers
      end        
    end
    resources :categories
    resources :publishers
    resources :authors
    resources :books
    resources :comments, only: [:create, :destroy]
    resources :relationship_users, only: [:create, :destroy]
  end
end
