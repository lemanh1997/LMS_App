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
      resources :following, only: [:index]
      resources :followers, only: [:index]
      resources :favorites, only: [:index]
    end
    resources :authors do
      resources :favorites, only: [:index, :create, :destroy], as: "followers"
    end
    resources :books do
      resources :favorites, only: [:index, :create, :destroy], as: "followers"
    end
    resources :categories
    resources :publishers
    resources :comments, only: [:create, :destroy]
    resources :relationship_users, only: [:create, :destroy]
  end
end
