Rails.application.routes.draw do
  
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new" #url reads /session/new...more user friendly with this makes url /signin. also change path on header layout

  resources :users
  get "signup" => "users#new"

  resources :genres

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
