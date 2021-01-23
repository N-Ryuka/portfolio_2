Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'devise/sessions',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show]
  resources :categories, except: [:new, :show]
  resources :tags, except: [:new, :show]
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index

  get '/posts/like/:id', to: "posts#like"
  get '/mypage', to: 'users#mypage'
  get '/follows/user/:id', to: "users#follow"
  get '/followers/user/:id', to: "users#follower"
  get '/users/:id/likes', to: "users#likes"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end