Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users

  resources :bookings, only: [:index, :show, :destroy,  :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dogs, only: [:index, :show, :new, :create] do
    resource :bookings, only: [:new, :create]
  end
end
