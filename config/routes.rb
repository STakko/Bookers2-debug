Rails.application.routes.draw do
  get 'book_charts/index'
  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  

  resources :users, only: [:show,:index,:edit,:update] do
    get 'day_search', to: 'users#day_search'
    member do #meberを使うことで別のルーティングも追加できる
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  get '/search' => 'searches#search'


  resources :chats, only: [:show, :create]
end