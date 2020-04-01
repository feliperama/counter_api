Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :sessions, only: [:create]

    get 'next' => 'counters#next'
    get 'current' => 'counters#current'
    put 'current' => 'counters#update'
  end
end
