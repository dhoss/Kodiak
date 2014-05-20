Kodiak::Application.routes.draw do


  get "photos/new"
  get "photos/create"
  get "photos/update"
  get "photos/edit"
  get "photos/destroy"
  get "photos/index"
  get "photos/show"
  resources :search
  resources :attachments

  resources :posts

  devise_for :users

  resources :users

  resources :categories

  root :to => "home#index"

end
