Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :users, only: [:show,:index,:edit,:update] do
    member do #meberを使うことで別のルーティングも追加できる
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get '/search' => 'searches#search'
  
  resources :chats, only: [:show, :create]
end