Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'devise/registrations',
    sessions:      'devise/sessions',
  }
  root 'posts#index'
  resources :posts
  resources :categories, except: [:new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end