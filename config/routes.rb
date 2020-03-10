Rails.application.routes.draw do
  root 'users#index'
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show]
end
