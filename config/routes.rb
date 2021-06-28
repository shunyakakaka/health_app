Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, only: [:index, :show, :new, :edit, :create, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "boards#index"
  resources :boards, only: [:index, :show, :new, :update, :create, :edit]
end
