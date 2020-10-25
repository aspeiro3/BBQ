Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  # Вложенные в ресурсы события
  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end

  resources :users
end
