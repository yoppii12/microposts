Rails.application.routes.draw do

  get 'sessions/new'

  #home.html.erbの内容がトップページに表示されるようになる
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
