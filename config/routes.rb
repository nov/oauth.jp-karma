Karma::Application.routes.draw do
  resources :transactions, only: :create
  resource :dashboard, only: :show
  resource :session,   only: [:show, :create, :destroy]
  root to: 'top#index'
end
