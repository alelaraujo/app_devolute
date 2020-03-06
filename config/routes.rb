Rails.application.routes.draw do
  resources :albums
  devise_for :users
  root to: 'pages#home'

  namespace :api do 
    namespace :v1 do 
     resources :albums, only: [:index, :create, :destroy, :update]
    end 
  end 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end