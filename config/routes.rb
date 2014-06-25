Kodiak::Application.routes.draw do


  resources :search
  resources :attachments

  resources :posts

  devise_for :users

  resources :users

  resources :photos

  resources :categories

  root :to => "home#index"

end
