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
  post "likes/:tweet_id/create" => "likes#create"
  post "likes/:tweet_id/destroy" => "likes#destroy"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end