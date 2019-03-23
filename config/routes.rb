Rails.application.routes.draw do

  resources :requests, only: [:index, :show, :create] do
    get 'voteup'
    get 'votedown'
    resources :comments, only: [:create]
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'requests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
