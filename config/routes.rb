Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get '/users/:id' => 'users#show'
  end

  root :to => 'pages#home'

  namespace :v1 do
    resources :sessions, only: [:create]

    get 'next' => 'counters#next'
    get 'current' => 'counters#current'
    put 'current' => 'counters#update'
  end
end
