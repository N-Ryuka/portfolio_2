Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'devise/registrations',
    sessions:      'devise/sessions',
    sessions: 'users/sessions'
  }
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show]
  resources :categories, except: [:new, :show]
  resources :tags, except: [:new, :show]

  get '/posts/like/:id', to: "posts#like"
  get '/mypage', to: 'users#mypage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end