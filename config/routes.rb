Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "books#index"

  resources :users

  resources :books do
    collection do
      get :search
      get :random
    end
  end

  resources :requests
  # devise_for :users, :controllers => { registrations: 'registrations' }
end
