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
      resources :authorfollowing, only: [:index]
    end
    resources :authors do
      resources :userfollowing, only: [:index]
    end
    resources :categories
    resources :publishers
    resources :books
    resources :comments, only: [:create, :destroy]
    resources :relationship_users, only: [:create, :destroy]
    resources :relationship_authors, only: [:create, :destroy]
  end
end
