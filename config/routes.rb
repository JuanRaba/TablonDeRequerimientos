Rails.application.routes.draw do
  get 'requests/index'
  get 'requests/create'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'requests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
