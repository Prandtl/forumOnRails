Rails.application.routes.draw do

  post '/users/:id/ban' => 'users#ban'
  post '/users/:id/unban' => 'users#unban'

  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :posts do
    resources :comments
  end


  resources :users, :only => [:show]

  root 'posts#index'

end
