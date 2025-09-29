Rails.application.routes.draw do
  # Posts routes with nested comments
  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  # Authentication routes
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  # Convenience routes for authentication
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"

  # Convenience routes for feed
  get "/feed", to: "posts#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
