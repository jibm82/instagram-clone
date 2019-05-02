# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # get '/users/:id', to: 'users#show'
  resources :users, only: :show
end
