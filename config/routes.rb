Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :edit, :create, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards, only: [:index, :show, :new, :update, :create, :edit]
end
