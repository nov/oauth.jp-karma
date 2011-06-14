Karma::Application.routes.draw do
  resource :dashboard, only: :show
  resource :session,   only: [:show, :create, :destroy]
  root to: 'top#index'
end
