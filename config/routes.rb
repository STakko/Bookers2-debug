Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end