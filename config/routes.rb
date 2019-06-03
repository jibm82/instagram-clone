# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
    controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  # get '/users/:id', to: 'users#show'
  resources :users, only: %i(index show)
  resources :posts, only: %i(index show create destroy) do
    resource :like, only: %i(create destroy index show new edit update)
    resource :bookmark, only: %i(create destroy)
    resources :comments, only: %i(index create destroy), shallow: true
    resources :photos, only: :create
  end
end
