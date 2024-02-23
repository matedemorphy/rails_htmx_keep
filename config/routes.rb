Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}
  resources :notes do
    member do
      patch 'color'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
    mount RailsPerformance::Engine, at: "rails/performance"
  end
  # Defines the root path route ("/")
  root "notes#index"
end
