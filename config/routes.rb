Rails.application.routes.draw do
  root "home#index"

  get "login" => "user_sessions#new", as: :login
  post "logout" => "user_sessions#destroy", as: :logout
  get "signup" => "users#new", as: :signup

  resource :user_sessions, only: %i(new create destroy)
  resources :users, only: %i(new edit create update) do
    resources :articles, only: %i(index)
  end

  resources :articles, only: %i(show new edit create update destroy) do
    resources :comments, only: %i(new edit create update destroy)
  end

  resources :statics, only: %i(index)
end
