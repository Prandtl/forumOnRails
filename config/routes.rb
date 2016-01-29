Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments
  end

  resources :users, :only => [:show]

  root 'posts#index'
end
