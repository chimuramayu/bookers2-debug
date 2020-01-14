Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
  	member do
  		get :following, :followers
      resource :relationships, only: [:create, :destroy]
  	end
  end
	resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :comments, only: [:create, :destroy]
  end
  root 'home#top'
  get 'home/about'
end
