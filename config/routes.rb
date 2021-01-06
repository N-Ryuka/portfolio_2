Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users, controllers: {
    registrations: 'devise/registrations',
    sessions:      'devise/sessions',
  }
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :categories, except: [:new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end