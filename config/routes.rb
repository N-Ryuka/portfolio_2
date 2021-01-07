Rails.application.routes.draw do
  get '/mypage', to: 'users#mypage'
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
  resources :users, only: [:show, :edit, :update]
  resources :categories, except: [:new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end