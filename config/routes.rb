Kodiak::Application.routes.draw do


  resources :search
  resources :attachments

  resources :posts

  devise_for :users

  resources :users

  resources :photos

  resources :categories

  get '/archives' => 'archives#index'
  
  get '/:year' => 'archives#year', constraints: {
    year: /\d{4}/
  }

  get '/:year/:month' => 'archives#month', constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/
  }

  get '/:year/:month/:day' => 'archives#day', constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/
  }

  root :to => "home#index"

  
end
