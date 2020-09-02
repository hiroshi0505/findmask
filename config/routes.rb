Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#number'
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search', 'number'
    end
  end
  resources :users, only: :show
end